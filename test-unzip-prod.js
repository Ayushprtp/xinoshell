// Test unzip against the public domain panel.flare-labs.tech
const { io } = require("socket.io-client");
const { PrismaClient } = require("@prisma/client");

const PANEL_URL = "https://panel.flare-labs.tech";
const USER_ID = "6a1f3e7686e8a5a78a59da67";
const DEVICE_ID = "6cd5e723ca36c3f5";

(async () => {
  const prisma = new PrismaClient();
  const dev = await prisma.clientDevice.findFirst({ where: { userId: USER_ID, deviceId: DEVICE_ID } });
  await prisma.$disconnect();
  console.log(`[setup] device socket=${dev.socketId}`);

  const panel = io(PANEL_URL, {
    transports: ["websocket", "polling"],
    query: { userId: USER_ID, type: "frontend" },
    forceNew: true,
    secure: true,
    rejectUnauthorized: false,
  });

  let resultReceived = null;
  let listAfter = null;
  let listResult = null;
  const t0 = Date.now();
  const ts = () => `[+${((Date.now() - t0) / 1000).toFixed(2)}s]`;

  panel.on("connect", () => {
    console.log(`${ts()} [panel] connected id=${panel.id}`);
    const sid = `prod_${Date.now()}`;
    panel.emit("register_panel_request", { socketId: sid, panelSocketId: panel.id });
    setTimeout(() => {
      console.log(`${ts()} [panel] -> unzip-file to ${dev.socketId} sid=${sid}`);
      panel.emit("server_command_to_user", {
        socketId: sid, toClient: dev.socketId, user_id: USER_ID, device_id: DEVICE_ID,
        from: "panel", type: "server_command", action: "unzip-file",
        path: "/sdcard/Download/test_archive.zip",
        command: { action: "unzip-file", path: "/sdcard/Download/test_archive.zip" },
        extra: { socketId: sid },
      });
    }, 300);
  });

  for (const e of ["unzip_result", "file_list_result", "file_data", "file_delete_result", "file_upload_result", "client_log"]) {
    panel.on(e, (p) => {
      console.log(`${ts()} [evt:${e}] ${JSON.stringify(p).slice(0, 200)}`);
      if (e === "unzip_result") {
        resultReceived = p;
        if (p.unzipped) {
          // Trigger a follow-up list to confirm files are there
          const sid2 = `ls_${Date.now()}`;
          panel.emit("register_panel_request", { socketId: sid2, panelSocketId: panel.id });
          setTimeout(() => {
            panel.emit("server_command_to_user", {
              socketId: sid2, toClient: dev.socketId, user_id: USER_ID, device_id: DEVICE_ID,
              from: "panel", type: "server_command", action: "file-list",
              path: "/sdcard/Download", command: { action: "file-list", path: "/sdcard/Download", source: "files" },
              extra: { socketId: sid2 },
            });
          }, 200);
        }
      }
      if (e === "file_list_result" && p.path === "/sdcard/Download") {
        listResult = p;
      }
    });
  }
  panel.on("connect_error", (err) => console.error(`${ts()} [panel] connect_error: ${err.message}`));

  setTimeout(() => {
    console.log(`\n${ts()} === SUMMARY ===`);
    console.log(`unzip_result: ${resultReceived ? JSON.stringify(resultReceived) : "NOT RECEIVED"}`);
    if (listResult) {
      const names = listResult.files?.map((f) => f.name) || [];
      console.log(`files in /sdcard/Download: ${names.join(", ")}`);
      const ok = ["file1.txt", "file2.txt", "subdir"].every((n) => names.includes(n));
      console.log(`required files present: ${ok ? "YES" : "NO"}`);
    }
    panel.disconnect();
    process.exit(resultReceived?.unzipped ? 0 : 2);
  }, 18000);
})().catch((e) => { console.error(e); process.exit(1); });
