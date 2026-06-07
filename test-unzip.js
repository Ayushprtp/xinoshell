// Test the unzip feature on the redroid
const { io } = require("socket.io-client");
const { PrismaClient } = require("@prisma/client");

const PANEL_URL = "http://172.17.0.1:2700";
const USER_ID = "6a1f3e7686e8a5a78a59da67";
const DEVICE_ID = "cc8940b365722c06";

(async () => {
  const prisma = new PrismaClient();
  const dev = await prisma.clientDevice.findFirst({ where: { userId: USER_ID, deviceId: DEVICE_ID } });
  console.log(`[setup] device: ${dev?.deviceId} socket=${dev?.socketId}`);
  await prisma.$disconnect();

  const panel = io(PANEL_URL, { transports: ["websocket", "polling"], query: { userId: USER_ID, type: "frontend" }, forceNew: true });

  let unzipSid;
  let listSid;

  const send = (action, path, sidName) => {
    const sid = `${sidName}_${Date.now()}_${Math.random().toString(36).slice(2, 5)}`;
    panel.emit("register_panel_request", { socketId: sid, panelSocketId: panel.id });
    panel.emit("server_command_to_user", {
      socketId: sid, toClient: dev.socketId, user_id: USER_ID, device_id: DEVICE_ID,
      from: "panel", type: "server_command", action, path,
      command: { action, path },
      extra: { socketId: sid },
    });
    return sid;
  };

  panel.on("connect", () => {
    console.log(`[panel] connected id=${panel.id}`);
    setTimeout(() => {
      console.log(`\n=== TEST 1: List /sdcard/Download to confirm test_archive.zip exists ===`);
      listSid = send("file-list", "/sdcard/Download", "ls");
    }, 500);
  });

  panel.on("file_list_result", (payload) => {
    if (payload.socketId !== listSid) return;
    const zipFile = payload.files?.find(f => f.name === "test_archive.zip");
    if (zipFile) {
      console.log(`[LIST] found test_archive.zip (size=${zipFile.size})`);
      setTimeout(() => {
        console.log(`\n=== TEST 2: Unzip test_archive.zip ===`);
        unzipSid = send("unzip-file", "/sdcard/Download/test_archive.zip", "unzip");
      }, 800);
    } else {
      console.log(`[LIST] FAIL: test_archive.zip not found`);
      console.log(`  Files:`, payload.files?.map(f => f.name));
      cleanup(1);
    }
  });

  panel.on("unzip_result", (payload) => {
    if (payload.socketId !== unzipSid) return;
    console.log(`[UNZIP] unzipped=${payload.unzipped} files=${payload.files} error=${payload.error || "none"}`);
    if (payload.unzipped) {
      console.log(`\n=== TEST 3: List /sdcard/Download to verify extracted files ===`);
      setTimeout(() => {
        listSid = send("file-list", "/sdcard/Download", "ls2");
      }, 800);
    } else {
      console.log(`[UNZIP] FAILED`);
      cleanup(1);
    }
  });

  panel.on("file_list_result", (payload) => {
    if (!listSid.startsWith("ls2")) return;
    console.log(`[LIST2] /sdcard/Download files: ${payload.files?.map(f => f.name).join(", ")}`);
    const hasFile1 = payload.files?.some(f => f.name === "file1.txt");
    const hasFile2 = payload.files?.some(f => f.name === "file2.txt");
    const hasSubdir = payload.files?.some(f => f.name === "subdir" && f.isDir);
    if (hasFile1 && hasFile2 && hasSubdir) {
      console.log(`\n✓ ALL UNZIP TESTS PASS - files extracted into device storage`);
      cleanup(0);
    } else {
      console.log(`\n✗ FAIL: file1=${hasFile1} file2=${hasFile2} subdir=${hasSubdir}`);
      cleanup(1);
    }
  });

  panel.on("connect_error", (err) => console.error(`[panel] connect_error: ${err.message}`));

  function cleanup(code) {
    setTimeout(() => { panel.disconnect(); process.exit(code); }, 1500);
  }
  setTimeout(() => cleanup(2), 60000);
})().catch((e) => { console.error(e); process.exit(1); });
