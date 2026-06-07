// Diagnostic: send unzip-file and capture EVERY relevant event.
// Confirms whether the device receives the command and what it sends back.
const { io } = require("socket.io-client");
const { PrismaClient } = require("@prisma/client");

const PANEL_URL = "http://172.17.0.1:2700";
const USER_ID = "6a1f3e7686e8a5a78a59da67";
const DEVICE_ID = "cc8940b365722c06";

(async () => {
  const prisma = new PrismaClient();
  const dev = await prisma.clientDevice.findFirst({ where: { userId: USER_ID, deviceId: DEVICE_ID } });
  console.log(`[setup] device: ${dev?.deviceId} socket=${dev?.socketId} status=${dev?.status} lastSeen=${dev?.lastSeen}`);
  await prisma.$disconnect();

  const panel = io(PANEL_URL, { transports: ["websocket", "polling"], query: { userId: USER_ID, type: "frontend" }, forceNew: true });

  panel.on("connect", () => {
    console.log(`[panel] connected id=${panel.id}`);
    const sid = `diag_${Date.now()}_${Math.random().toString(36).slice(2, 5)}`;

    panel.emit("register_panel_request", { socketId: sid, panelSocketId: panel.id });

    setTimeout(() => {
      console.log(`[panel] emitting unzip-file to device socket=${dev.socketId} sid=${sid}`);
      panel.emit("server_command_to_user", {
        socketId: sid,
        toClient: dev.socketId,
        user_id: USER_ID,
        device_id: DEVICE_ID,
        from: "panel",
        type: "server_command",
        action: "unzip-file",
        path: "/sdcard/Download/test_archive.zip",
        command: { action: "unzip-file", path: "/sdcard/Download/test_archive.zip" },
        extra: { socketId: sid },
      });
    }, 300);
  });

  // Listen for ANY event from the device side
  const anyEvent = (name) => (payload) => {
    console.log(`[evt:${name}] ${JSON.stringify(payload).slice(0, 500)}`);
  };
  for (const e of ["unzip_result", "file_list_result", "file_data", "file_delete_result", "file_upload_result", "server_command", "device_location", "client_log", "client_message"]) {
    panel.on(e, anyEvent(e));
  }

  panel.on("connect_error", (err) => console.error(`[panel] connect_error: ${err.message}`));
  panel.on("disconnect", (reason) => console.log(`[panel] disconnected: ${reason}`));

  setTimeout(() => {
    console.log(`\n[timeout] 90s reached, no result received.`);
    panel.disconnect();
    process.exit(2);
  }, 90000);
})().catch((e) => { console.error(e); process.exit(1); });
