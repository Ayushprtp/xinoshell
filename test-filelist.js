// Send a file-list request and wait for the result with longer timeout.
// Read the device's current socketId directly from server logs.
const { io } = require("socket.io-client");
const { PrismaClient } = require("@prisma/client");

const PANEL_URL = "http://172.17.0.1:2700";
const USER_ID = "6a1f3e7686e8a5a78a59da67";

(async () => {
  const prisma = new PrismaClient();
  const dev = await prisma.clientDevice.findFirst({
    where: { userId: USER_ID, status: true },
    orderBy: { lastSeen: "desc" },
  });
  console.log(`[setup] device: ${dev?.deviceId} socket=${dev?.socketId}`);
  await prisma.$disconnect();

  const panel = io(PANEL_URL, {
    transports: ["websocket", "polling"],
    query: { userId: USER_ID, type: "frontend" },
    forceNew: true,
  });

  const sid = `t_${Date.now()}_${Math.random().toString(36).slice(2, 5)}`;

  panel.on("connect", () => {
    console.log(`[panel] connected id=${panel.id}`);
    // Register BEFORE sending so the result can be routed back
    panel.emit("register_panel_request", { socketId: sid, panelSocketId: panel.id });

    setTimeout(() => {
      console.log(`[panel] sending file-list to socket=${dev.socketId}`);
      panel.emit("server_command_to_user", {
        socketId: sid,
        toClient: dev.socketId,
        user_id: USER_ID,
        device_id: dev.deviceId,
        from: "panel",
        type: "server_command",
        action: "file-list",
        path: "/sdcard",
        source: "files",
        command: { action: "file-list", path: "/sdcard", source: "files" },
        extra: { socketId: sid },
      });
    }, 500);
  });

  panel.on("file_list_result", (payload) => {
    console.log(`\n[panel] *** file_list_result received! ***`);
    console.log(`  full payload: ${JSON.stringify(payload, null, 2)}`);
    console.log(`  path=${payload?.path}  files=${payload?.files?.length ?? 0}`);
    if (payload?.error) console.log(`  error=${payload.error}`);
    if (Array.isArray(payload?.files) && payload.files.length) {
      payload.files.slice(0, 20).forEach((f) => {
        console.log(`    - ${f.name}  size=${f.size}  isDir=${f.isDir}  type=${f.type || ""}`);
      });
      if (payload.files.length > 20) {
        console.log(`    ... and ${payload.files.length - 20} more`);
      }
    }
    cleanup(0);
  });

  panel.on("file_data", (payload) => {
    console.log(`[panel] file_data chunk=${payload?.chunk}/${payload?.totalChunks}`);
  });

  panel.on("file_delete_result", (payload) => {
    console.log(`[panel] file_delete_result deleted=${payload?.deleted}`);
  });

  panel.on("file_upload_result", (payload) => {
    console.log(`[panel] file_upload_result uploaded=${payload?.uploaded}`);
  });

  panel.on("connect_error", (err) => {
    console.error(`[panel] connect_error: ${err.message}`);
  });

  const cleanup = (code) => {
    setTimeout(() => {
      panel.disconnect();
      process.exit(code);
    }, 200);
  };

  setTimeout(() => cleanup(2), 45000);
})().catch((e) => { console.error(e); process.exit(1); });
