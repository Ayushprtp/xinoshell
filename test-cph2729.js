// Test against the real CPH2729 device with the same payload shape the panel UI now sends.
const { io } = require("socket.io-client");
const { PrismaClient } = require("@prisma/client");

const PANEL_URL = "http://172.17.0.1:2700";
const USER_ID = "6a1f3e7686e8a5a78a59da67";
const DEVICE_ID = "cc8940b365722c06"; // testing redroid with the same flow that would hit CPH2729

(async () => {
  const prisma = new PrismaClient();
  const dev = await prisma.clientDevice.findFirst({ where: { userId: USER_ID, deviceId: DEVICE_ID } });
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
    panel.emit("register_panel_request", { socketId: sid, panelSocketId: panel.id });

    setTimeout(() => {
      console.log(`[panel] sending file-list to socket=${dev.socketId}`);
      // Payload mirrors what LiveFileBrowser.tsx now sends
      panel.emit("server_command_to_user", {
        socketId: sid,
        toClient: dev.socketId,
        user_id: USER_ID,
        device_id: DEVICE_ID,
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
    console.log(`  path=${payload?.path}  files=${payload?.files?.length ?? 0}`);
    if (payload?.error) console.log(`  error=${payload.error}`);
    if (Array.isArray(payload?.files) && payload.files.length) {
      payload.files.slice(0, 8).forEach((f) => {
        console.log(`    - ${f.name}  size=${f.size}  isDir=${f.isDir}  type=${f.type || ""}`);
      });
      if (payload.files.length > 8) console.log(`    ... and ${payload.files.length - 8} more`);
    }
    cleanup(0);
  });

  panel.on("connect_error", (err) => console.error(`[panel] connect_error: ${err.message}`));

  const cleanup = (code) => setTimeout(() => { panel.disconnect(); process.exit(code); }, 200);
  setTimeout(() => cleanup(2), 30000);
})().catch((e) => { console.error(e); process.exit(1); });
