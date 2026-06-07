// Server-side observer: connect as a "device" using the same socketId as the
// real device and watch what events the server sees on the device side. This
// tells us whether unzip_result is being emitted at all by the running agent.
const { io } = require("socket.io-client");

const PANEL_URL = "http://172.17.0.1:2700";
const USER_ID = "6a1f3e7686e8a5a78a59da67";
const DEVICE_ID = "cc8940b365722c06";
const FAKE_SOCKET_ID = "OBSERVER_FAKE_SOCKET";

const fake = io(PANEL_URL, {
  transports: ["websocket", "polling"],
  query: { userId: USER_ID, deviceId: DEVICE_ID, type: "android", modelName: "observer" },
  forceNew: true,
});

const allEvents = ["unzip_result", "file_list_result", "file_data", "file_delete_result", "file_upload_result", "device_location", "client_log", "server_command", "client_message", "device_updated"];
for (const e of allEvents) fake.on(e, (p) => console.log(`[OBS:${e}] ${JSON.stringify(p).slice(0, 400)}`));

fake.on("connect", () => {
  console.log(`[OBS] connected as fake device id=${fake.id}`);
});

fake.on("connect_error", (err) => console.error(`[OBS] connect_error: ${err.message}`));
fake.on("disconnect", (r) => console.log(`[OBS] disconnect: ${r}`));

// Also act as a panel to send the unzip command
const panel = io(PANEL_URL, {
  transports: ["websocket", "polling"],
  query: { userId: USER_ID, type: "frontend" },
  forceNew: true,
});

panel.on("connect", () => {
  console.log(`[PANEL] connected id=${panel.id}`);
  const sid = `obs_${Date.now()}`;
  panel.emit("register_panel_request", { socketId: sid, panelSocketId: panel.id });
  setTimeout(() => {
    console.log(`[PANEL] sending unzip to fake-device id ${FAKE_SOCKET_ID}`);
    panel.emit("server_command_to_user", {
      socketId: sid,
      toClient: FAKE_SOCKET_ID,
      user_id: USER_ID,
      device_id: DEVICE_ID,
      from: "panel",
      type: "server_command",
      action: "unzip-file",
      path: "/sdcard/Download/test_archive.zip",
      command: { action: "unzip-file", path: "/sdcard/Download/test_archive.zip" },
      extra: { socketId: sid },
    });
  }, 500);
});

panel.on("unzip_result", (p) => console.log(`[PANEL:unzip_result] ${JSON.stringify(p).slice(0, 400)}`));

setTimeout(() => { fake.disconnect(); panel.disconnect(); process.exit(0); }, 15000);
