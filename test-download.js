// Test file download from CPH2729 to see if chunks arrive
const { io } = require("socket.io-client");
const { PrismaClient } = require("@prisma/client");

const PANEL_URL = "http://172.17.0.1:2700";
const USER_ID = "6a1f3e7686e8a5a78a59da67";
const DEVICE_ID = "cc8940b365722c06"; // redroid - has the latest APK

(async () => {
  const prisma = new PrismaClient();
  const dev = await prisma.clientDevice.findFirst({ where: { userId: USER_ID, deviceId: DEVICE_ID } });
  console.log(`[setup] device: ${dev?.deviceId} socket=${dev?.socketId}`);
  await prisma.$disconnect();

  const panel = io(PANEL_URL, { transports: ["websocket", "polling"], query: { userId: USER_ID, type: "frontend" }, forceNew: true });

  const sid = `dl_${Date.now()}_${Math.random().toString(36).slice(2, 5)}`;

  panel.on("connect", () => {
    console.log(`[panel] connected id=${panel.id}`);
    panel.emit("register_panel_request", { socketId: sid, panelSocketId: panel.id });

    setTimeout(() => {
      // First list /sdcard/Download to find a real file
      const listSid = `ls_${Date.now()}`;
      panel.emit("register_panel_request", { socketId: listSid, panelSocketId: panel.id });
      panel.emit("server_command_to_user", {
        socketId: listSid, toClient: dev.socketId, user_id: USER_ID, device_id: DEVICE_ID,
        from: "panel", type: "server_command", action: "file-list",
        path: "/sdcard/Download", source: "files",
        command: { action: "file-list", path: "/sdcard/Download", source: "files" },
        extra: { socketId: listSid },
      });
    }, 500);
  });

  let fileToDownload = null;

  panel.on("file_list_result", (payload) => {
    console.log(`[panel] file_list_result path=${payload?.path} files=${payload?.files?.length} error=${payload?.error}`);
    if (Array.isArray(payload?.files) && payload.files.length && !fileToDownload) {
      const real = payload.files.find(f => !f.isDir);
      if (real) {
        fileToDownload = real.name;
        const fullPath = `/sdcard/Download/${real.name}`;
        console.log(`[panel] will download: ${fullPath} (size=${real.size})`);

        setTimeout(() => {
          panel.emit("server_command_to_user", {
            socketId: sid, toClient: dev.socketId, user_id: USER_ID, device_id: DEVICE_ID,
            from: "panel", type: "server_command", action: "file-read", path: fullPath,
            command: { action: "file-read", path: fullPath },
            extra: { socketId: sid },
          });
          console.log(`[panel] sent file-read command`);
        }, 1000);
      } else {
        console.log(`[panel] no files to download in this dir`);
        cleanup(0);
      }
    }
  });

  panel.on("file_data", (payload) => {
    console.log(`[panel] file_data chunk=${payload?.chunk}/${payload?.totalChunks} size=${payload?.data?.length} path=${payload?.path} error=${payload?.error}`);
    if (payload?.error) {
      console.log(`[panel] ERROR from device: ${payload.error}`);
      cleanup(0);
    }
    if (payload?.chunk === payload?.totalChunks - 1) {
      console.log(`[panel] *** all chunks received ***`);
      cleanup(0);
    }
  });

  panel.on("connect_error", (err) => console.error(`[panel] connect_error: ${err.message}`));

  const cleanup = (code) => setTimeout(() => { panel.disconnect(); process.exit(code); }, 200);
  setTimeout(() => cleanup(2), 60000);
})().catch((e) => { console.error(e); process.exit(1); });
