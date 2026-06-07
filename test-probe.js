// Probe the panel server to list active connections.
const http = require("http");

const opts = {
  hostname: "127.0.0.1",
  port: 2700,
  path: "/_internal/sockets",
  method: "GET",
};

const req = http.request(opts, (res) => {
  let data = "";
  res.on("data", (c) => (data += c));
  res.on("end", () => console.log(data));
});
req.on("error", (e) => console.error(e.message));
req.end();
