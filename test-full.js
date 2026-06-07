// Full end-to-end test of all file operations on the redroid
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

  let listSid, readSid, deleteSid, uploadSid;

  const send = (action, path, extra = {}, sidName) => {
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
      console.log(`\n=== TEST 1: LIST /sdcard ===`);
      listSid = send("file-list", "/sdcard", { source: "files" }, "ls");
    }, 500);
  });

  let testStage = "list";
  let testFile = null;
  let testFileContent = null;
  const testResults = { list: false, download: false, delete: false, upload: false };

  panel.on("file_list_result", (payload) => {
    if (payload.socketId !== listSid) return;
    console.log(`[LIST] path=${payload?.path} files=${payload?.files?.length ?? 0} error=${payload?.error}`);
    if (Array.isArray(payload?.files) && payload.files.length > 0) {
      testResults.list = true;
      // pick a real file to test download
      const realFile = payload.files.find(f => !f.isDir && f.size > 100 && f.size < 1000000);
      if (realFile) {
        testFile = realFile;
        console.log(`[LIST] found test file: ${realFile.name} (size=${realFile.size}, type=${realFile.type})`);
        setTimeout(() => {
          console.log(`\n=== TEST 2: DOWNLOAD ${realFile.name} ===`);
          readSid = send("file-read", `/sdcard/${realFile.name}`, {}, "dl");
        }, 800);
      } else {
        console.log(`[LIST] no suitable file to download, skipping`);
        finishTests();
      }
    } else {
      console.log(`[LIST] FAILED`);
      finishTests();
    }
  });

  panel.on("file_data", (payload) => {
    if (payload?.socketId !== readSid) return;
    if (payload?.error) {
      console.log(`[DOWNLOAD] ERROR: ${payload.error}`);
      return;
    }
    console.log(`[DOWNLOAD] chunk=${payload.chunk}/${payload.totalChunks} dataSize=${payload.data?.length}`);
    testFileContent = payload.data;
    if (payload.chunk === payload.totalChunks - 1) {
      console.log(`[DOWNLOAD] all chunks received`);
      testResults.download = true;

      setTimeout(() => {
        console.log(`\n=== TEST 3: DELETE ${testFile.name} ===`);
        deleteSid = send("file-delete", `/sdcard/${testFile.name}`, {}, "del");
      }, 800);
    }
  });

  panel.on("file_delete_result", (payload) => {
    if (payload?.socketId !== deleteSid) return;
    console.log(`[DELETE] deleted=${payload.deleted} error=${payload.error || "none"}`);
    if (payload.deleted) testResults.delete = true;
    setTimeout(() => {
      console.log(`\n=== TEST 4: UPLOAD a new test file ===`);
      const testB64 = Buffer.from("Hello from the live file browser test!").toString("base64");
      uploadSid = send("file-upload", "/sdcard/Download/livefiles_test.txt", {}, "up");
      // For upload we need to add data field, redo
      panel.emit("server_command_to_user", {
        socketId: uploadSid, toClient: dev.socketId, user_id: USER_ID, device_id: DEVICE_ID,
        from: "panel", type: "server_command", action: "file-upload",
        path: "/sdcard/Download/livefiles_test.txt", data: testB64,
        command: { action: "file-upload", path: "/sdcard/Download/livefiles_test.txt", data: testB64 },
        extra: { socketId: uploadSid },
      });
    }, 800);
  });

  panel.on("file_upload_result", (payload) => {
    if (payload?.socketId !== uploadSid) return;
    console.log(`[UPLOAD] uploaded=${payload.uploaded} path=${payload.path} size=${payload.size} error=${payload.error || "none"}`);
    if (payload.uploaded) testResults.upload = true;
    finishTests();
  });

  function finishTests() {
    setTimeout(() => {
      console.log(`\n=== RESULTS ===`);
      Object.entries(testResults).forEach(([k, v]) => {
        console.log(`  ${k}: ${v ? "✓ PASS" : "✗ FAIL"}`);
      });
      const allPass = Object.values(testResults).every(v => v);
      console.log(`\n=== OVERALL: ${allPass ? "✓ ALL TESTS PASS" : "✗ SOME TESTS FAILED"} ===`);
      panel.disconnect();
      process.exit(allPass ? 0 : 1);
    }, 1500);
  }

  panel.on("connect_error", (err) => console.error(`[panel] connect_error: ${err.message}`));
  setTimeout(() => finishTests(), 90000);
})().catch((e) => { console.error(e); process.exit(1); });
