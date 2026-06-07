"use client";

import { useState, useEffect } from "react";
import { motion } from "framer-motion";
import {
  FiUser,
  FiEdit,
  FiCalendar,
  FiEye,
  FiEyeOff,
  FiLock,
  FiSmartphone,
  FiPower,
  FiTrash2,
  FiMapPin,
  FiShield,
  FiLogOut,
  FiSave,
  FiX,
} from "react-icons/fi";
import { Toaster, toast } from "sonner";
import { useAuth } from "../../context/AuthContext";
import { useRouter } from "next/navigation";
import { getIpInfo, getPublicIp, IpInfo } from "@/lib/network";
import { DeviceLocationPopup } from "./DeviceLocationPopup";

interface Device {
  locationInfo?: {
    city?: string;
    country?: string;
    latitude?: number;
    longitude?: number;
  };
  id: string;
  status: boolean;
  loggedInAt: string;
  ipAddress: string;
  userAgent: string;
}

interface UserData {
  id: string;
  name: string;
  tg_username: string;
  tg_id: number;
  lang: string;
  registeredOn: string;
  last_login: string | null;
  exp_date: string;
  amount_paid: string;
  username: string;
  password: string;
  isTwoFactor: boolean;
  isMultiDevice: boolean;
  user_devices: Device[];
}

export default function Profile() {
  const { user: authUser, logout } = useAuth();
  const router = useRouter();
  const [userData, setUserData] = useState<UserData | null>(null);
  const [loading, setLoading] = useState(true);
  const [showPassword, setShowPassword] = useState(false);
  const [currentDeviceId, setCurrentDeviceId] = useState<string | null>(null);
  const [editField, setEditField] = useState<string | null>(null);
  const [editValue, setEditValue] = useState("");
  const [isDeletingDevice, setIsDeletingDevice] = useState(false);
  const [selectedDeviceIp, setSelectedDeviceIp] = useState<string | null>(null);
  const [selectedDeviceInfo, setSelectedDeviceInfo] = useState<IpInfo | null>(
    null
  );
  const [isLoadingLocation, setIsLoadingLocation] = useState(false);

  const fetchUserData = async () => {
    try {
      const localData = localStorage.getItem("userData");
      const token = localData ? JSON.parse(localData).token : null;

      const response = await fetch("/api/auth/user", {
        credentials: "include",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });

      if (!response.ok) throw new Error("Failed to fetch user data");

      const data = await response.json();
      if (data.success) {
        setUserData(data.user);
        identifyCurrentDevice(data.user.user_devices);
      }
    } catch (error) {
      toast.error("Failed to load profile data");
      console.error(error);
    } finally {
      setLoading(false);
    }
  };

  const identifyCurrentDevice = async (devices: Device[]) => {
    try {
      const currentIp = await getPublicIp();

      if (!currentIp) return;

      const currentDevice = devices?.find(
        (device) =>
          device.ipAddress === currentIp ||
          device.userAgent.includes(navigator.userAgent.substring(0, 50))
      );

      if (currentDevice) {
        setCurrentDeviceId(currentDevice.id);
        if (!currentDevice.status) {
          toast.warning("Your session has expired. Logging out...");
          await handleLogout();
        }
      }
    } catch (error) {
      console.error("Error identifying current device:", error);
    }
  };

  const handleLogout = async () => {
    try {
      if (currentDeviceId) {
        setIsDeletingDevice(true);
        await handleDeviceAction(currentDeviceId, "delete");
      }

      await logout();
      toast.success("Logged out successfully");
      router.push("/login");
    } catch (error) {
      toast.error("Logout failed");
      console.error(error);
    } finally {
      setIsDeletingDevice(false);
    }
  };

  const loadDeviceLocation = async (ip: string) => {
    try {
      setIsLoadingLocation(true);
      const info = await getIpInfo(ip);
      setSelectedDeviceInfo(info);
      setSelectedDeviceIp(ip);
    } catch (error) {
      toast.error("Could not load device location");
      console.error(error);
    } finally {
      setIsLoadingLocation(false);
    }
  };

  const closeLocationPopup = () => {
    setSelectedDeviceIp(null);
    setSelectedDeviceInfo(null);
  };

  const openEditModal = (field: string, currentValue: string) => {
    setEditField(field);
    setEditValue(currentValue);
  };

  const closeEditModal = () => {
    setEditField(null);
    setEditValue("");
  };

  const saveEdit = async () => {
    if (!editField || !userData) return;

    try {
      let response;
      const localData = localStorage.getItem("userData");
      const token = localData ? JSON.parse(localData).token : null;
      if (editField === "password") {
        response = await fetch("/api/auth/user", {
          method: "PATCH",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
          credentials: "include",
          body: JSON.stringify({
            action: "update_password",
            data: { newPassword: editValue },
          }),
        });
      } else {
        response = await fetch("/api/auth/user", {
          method: "PATCH",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
          credentials: "include",
          body: JSON.stringify({
            action: "update_profile",
            data: { [editField]: editValue },
          }),
        });
      }

      const data = await response.json();
      if (data.success) {
        toast.success("Update successful");
        fetchUserData();
        closeEditModal();
      } else {
        throw new Error(data.message || "Update failed");
      }
    } catch (error) {
      toast.error(error instanceof Error ? error.message : "Update failed");
      console.error(error);
    }
  };

  const updateProfile = async (field: string, value: string) => {
    try {
      const localData = localStorage.getItem("userData");
      const token = localData ? JSON.parse(localData).token : null;
      const response = await fetch("/api/auth/user", {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        credentials: "include",
        body: JSON.stringify({
          action: "update_profile",
          data: { [field]: value },
        }),
      });

      const data = await response.json();
      if (data.success) {
        toast.success("Profile updated successfully");
        fetchUserData();
      } else {
        throw new Error(data.message || "Update failed");
      }
    } catch (error) {
      toast.error(error instanceof Error ? error.message : "Update failed");
      console.error(error);
    }
  };

  const toggleSecuritySetting = async (
    setting: "2fa" | "multiDevice",
    enabled: boolean
  ) => {
    try {
      const action = setting === "2fa" ? "toggle_2fa" : "toggle_multi_device";
      const localData = localStorage.getItem("userData");
      const token = localData ? JSON.parse(localData).token : null;
      const response = await fetch("/api/auth/user", {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        credentials: "include",
        body: JSON.stringify({
          action,
          data: { enable: enabled },
        }),
      });

      const data = await response.json();
      if (data.success) {
        toast.success(
          `${setting === "2fa" ? "Two-factor" : "Multi-device"} ${
            enabled ? "enabled" : "disabled"
          }`
        );
        fetchUserData();
      } else {
        throw new Error(data.message || "Operation failed");
      }
    } catch (error) {
      toast.error(error instanceof Error ? error.message : "Operation failed");
      console.error(error);
    }
  };

  const handleDeviceAction = async (
    deviceId: string,
    action: "logout" | "delete"
  ) => {
    try {
      const localData = localStorage.getItem("userData");
      const token = localData ? JSON.parse(localData).token : null;
      const response = await fetch("/api/auth/user", {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        credentials: "include",
        body: JSON.stringify({
          action: "manage_device",
          data: {
            deviceId,
            deviceAction: action === "logout" ? "deactivate" : "delete",
          },
        }),
      });

      const data = await response.json();
      if (data.success) {
        toast.success(
          `Device ${
            action === "logout" ? "logged out" : "removed"
          } successfully`
        );
        fetchUserData();
      } else {
        throw new Error(data.message || "Operation failed");
      }
    } catch (error) {
      toast.error(error instanceof Error ? error.message : "Operation failed");
      console.error(error);
    }
  };

  const locateDevice = (ip: string) => {
    window.open(`https://www.iplocation.net/?query=${ip}`, "_blank");
  };

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleString();
  };

  useEffect(() => {
    fetchUserData();
  }, []);

  if (loading || !userData) {
    return (
      <div className="min-h-screen bg-gray-900 text-gray-100 flex items-center justify-center">
        <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-indigo-500"></div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-900 text-gray-100 p-4 md:p-8">
      <Toaster position="top-right" richColors expand={false} />

      {/* Edit Modal */}
      {editField && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
          <div className="bg-gray-800 rounded-lg p-6 w-full max-w-md border border-gray-700">
            <div className="flex justify-between items-center mb-4">
              <h3 className="text-xl font-bold">
                Edit {editField.replace("_", " ")}
              </h3>
              <button
                onClick={closeEditModal}
                className="text-gray-400 hover:text-white"
              >
                <FiX size={24} />
              </button>
            </div>

            <div className="mb-4">
              <label className="block text-gray-400 mb-2">
                New {editField.replace("_", " ")}
              </label>
              <input
                type={
                  editField === "password"
                    ? showPassword
                      ? "text"
                      : "password"
                    : "text"
                }
                value={editValue}
                onChange={(e) => setEditValue(e.target.value)}
                className="w-full bg-gray-700 border border-gray-600 rounded px-3 py-2 text-white"
                autoFocus
              />
              {editField === "password" && (
                <button
                  onClick={() => setShowPassword(!showPassword)}
                  className="mt-2 text-indigo-400 hover:text-indigo-300 flex items-center text-sm"
                >
                  {showPassword ? (
                    <FiEyeOff className="mr-1" />
                  ) : (
                    <FiEye className="mr-1" />
                  )}
                  {showPassword ? "Hide" : "Show"} Password
                </button>
              )}
            </div>

            <div className="flex justify-end space-x-3">
              <button
                onClick={closeEditModal}
                className="px-4 py-2 bg-gray-700 hover:bg-gray-600 rounded"
              >
                Cancel
              </button>
              <button
                onClick={saveEdit}
                className="px-4 py-2 bg-indigo-600 hover:bg-indigo-700 rounded flex items-center"
              >
                <FiSave className="mr-2" /> Save
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Device Location Popup */}
      {selectedDeviceIp && (
        <DeviceLocationPopup
          ipInfo={selectedDeviceInfo}
          onClose={closeLocationPopup}
        />
      )}

      <div className="max-w-6xl mx-auto">
        {/* Header with logout button */}
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
          className="mb-8 flex justify-between items-center"
        >
          <div>
            <h1 className="text-3xl font-bold text-indigo-400">
              Profile Settings
            </h1>
            <div className="w-20 h-1 bg-indigo-500 mt-2"></div>
          </div>
          <button
            onClick={handleLogout}
            disabled={isDeletingDevice}
            className={`flex items-center gap-2 px-4 py-2 rounded-lg ${
              isDeletingDevice
                ? "bg-gray-700 text-gray-500 cursor-not-allowed"
                : "bg-red-900/50 hover:bg-red-900/70 text-red-400"
            }`}
          >
            {isDeletingDevice ? (
              <div className="flex items-center">
                <div className="animate-spin rounded-full h-4 w-4 border-t-2 border-b-2 border-white mr-2"></div>
                Logging out...
              </div>
            ) : (
              <>
                <FiLogOut /> Logout
              </>
            )}
          </button>
        </motion.div>

        {/* Profile Sections Grid */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          {/* User Information Section */}
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.2, duration: 0.5 }}
            className="bg-gray-800 rounded-xl p-6 border border-gray-700"
          >
            <div className="flex justify-between items-center mb-6">
              <h2 className="text-xl font-bold flex items-center">
                <FiUser className="mr-2 text-indigo-400" />
                Personal Information
              </h2>
            </div>

            <div className="space-y-4">
              <div className="flex items-center">
                <span className="w-1/3 text-gray-400">Name:</span>
                <span className="w-2/3 font-medium flex items-center">
                  {userData.name}
                  <button
                    onClick={() => openEditModal("name", userData.name)}
                    className="ml-2 text-indigo-400 hover:text-indigo-300"
                  >
                    <FiEdit size={16} />
                  </button>
                </span>
              </div>
              <div className="flex items-center">
                <span className="w-1/3 text-gray-400">Telegram:</span>
                <span className="w-2/3 font-medium flex items-center">
                  {userData.tg_username}
                  <button
                    onClick={() =>
                      openEditModal("tg_username", userData.tg_username)
                    }
                    className="ml-2 text-indigo-400 hover:text-indigo-300"
                  >
                    <FiEdit size={16} />
                  </button>
                </span>
              </div>
              <div className="flex items-center">
                <span className="w-1/3 text-gray-400">Telegram ID:</span>
                <span className="w-2/3 font-medium">{userData.tg_id}</span>
              </div>
              <div className="flex items-center">
                <span className="w-1/3 text-gray-400">Language:</span>
                <div className="w-2/3 flex items-center">
                  <select
                    value={userData.lang}
                    onChange={(e) => updateProfile("lang", e.target.value)}
                    className="w-full bg-gray-700 border border-gray-600 rounded px-3 py-1"
                  >
                    <option value="en">English</option>
                    <option value="es">Spanish</option>
                    <option value="fr">French</option>
                    <option value="de">German</option>
                    <option value="ru">Russian</option>
                  </select>
                </div>
              </div>
            </div>
          </motion.div>

          {/* Registration Information Section */}
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.4, duration: 0.5 }}
            className="bg-gray-800 rounded-xl p-6 border border-gray-700"
          >
            <h2 className="text-xl font-bold flex items-center mb-6">
              <FiCalendar className="mr-2 text-indigo-400" />
              Registration Information
            </h2>

            <div className="space-y-4">
              <div className="flex items-center">
                <span className="w-1/3 text-gray-400">Registered:</span>
                <span className="w-2/3 font-medium">
                  {formatDate(userData.registeredOn)}
                </span>
              </div>
              <div className="flex items-center">
                <span className="w-1/3 text-gray-400">Last Login:</span>
                <span className="w-2/3 font-medium">
                  {userData.last_login
                    ? formatDate(userData.last_login)
                    : "Never"}
                </span>
              </div>
              <div className="flex items-center">
                <span className="w-1/3 text-gray-400">Expiry Date:</span>
                <span className="w-2/3 font-medium">
                  {formatDate(userData.exp_date)}
                </span>
              </div>
              <div className="flex items-center">
                <span className="w-1/3 text-gray-400">Amount Paid:</span>
                <span className="w-2/3 font-medium">
                  {userData.amount_paid}
                </span>
              </div>
            </div>
          </motion.div>

          {/* Login Information Section */}
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.6, duration: 0.5 }}
            className="bg-gray-800 rounded-xl p-6 border border-gray-700"
          >
            <h2 className="text-xl font-bold flex items-center mb-6">
              <FiLock className="mr-2 text-indigo-400" />
              Login Information
            </h2>

            <div className="space-y-4">
              <div className="flex items-center">
                <span className="w-1/3 text-gray-400">Username:</span>
                <span className="w-2/3 font-medium flex items-center">
                  {userData.username}
                  <button
                    onClick={() => openEditModal("username", userData.username)}
                    className="ml-2 text-indigo-400 hover:text-indigo-300"
                  >
                    <FiEdit size={16} />
                  </button>
                </span>
              </div>
              <div className="flex items-center">
                <span className="w-1/3 text-gray-400">Password:</span>
                <div className="w-2/3 flex items-center">
                  <span className="font-medium mr-2">
                    {showPassword ? userData.password : "••••••••"}
                  </span>
                  <button
                    onClick={() => setShowPassword(!showPassword)}
                    className="text-indigo-400 hover:text-indigo-300 mr-2"
                  >
                    {showPassword ? (
                      <FiEyeOff size={16} />
                    ) : (
                      <FiEye size={16} />
                    )}
                  </button>
                  <button
                    onClick={() => openEditModal("password", "")}
                    className="text-indigo-400 hover:text-indigo-300"
                  >
                    <FiEdit size={16} />
                  </button>
                </div>
              </div>
            </div>
          </motion.div>

          {/* Security Settings Section */}
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.8, duration: 0.5 }}
            className="bg-gray-800 rounded-xl p-6 border border-gray-700"
          >
            <h2 className="text-xl font-bold flex items-center mb-6">
              <FiShield className="mr-2 text-indigo-400" />
              Security Settings
            </h2>

            <div className="space-y-6">
              <div className="flex justify-between items-center">
                <div>
                  <h3 className="font-medium">Two-Factor Authentication</h3>
                  <p className="text-sm text-gray-400">
                    {userData.isTwoFactor
                      ? "Extra layer of security enabled"
                      : "Add extra layer of security"}
                  </p>
                </div>
                <button
                  onClick={() =>
                    toggleSecuritySetting("2fa", !userData.isTwoFactor)
                  }
                  className={`relative inline-flex h-6 w-11 items-center rounded-full transition-colors focus:outline-none ${
                    userData.isTwoFactor ? "bg-indigo-600" : "bg-gray-600"
                  }`}
                >
                  <span
                    className={`inline-block h-4 w-4 transform rounded-full bg-white transition-transform ${
                      userData.isTwoFactor ? "translate-x-6" : "translate-x-1"
                    }`}
                  />
                </button>
              </div>

              <div className="flex justify-between items-center">
                <div>
                  <h3 className="font-medium">Multi-Device Login</h3>
                  <p className="text-sm text-gray-400">
                    {userData.isMultiDevice
                      ? "Allowed to login from multiple devices"
                      : "Restrict to single device"}
                  </p>
                </div>
                <button
                  onClick={() =>
                    toggleSecuritySetting(
                      "multiDevice",
                      !userData.isMultiDevice
                    )
                  }
                  className={`relative inline-flex h-6 w-11 items-center rounded-full transition-colors focus:outline-none ${
                    userData.isMultiDevice ? "bg-indigo-600" : "bg-gray-600"
                  }`}
                >
                  <span
                    className={`inline-block h-4 w-4 transform rounded-full bg-white transition-transform ${
                      userData.isMultiDevice ? "translate-x-6" : "translate-x-1"
                    }`}
                  />
                </button>
              </div>
            </div>
          </motion.div>
        </div>

        {/* Active Devices Section */}
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 1, duration: 0.5 }}
          className="mt-8"
        >
          <div className="flex justify-between items-center mb-4">
            <h2 className="text-xl font-bold flex items-center">
              <FiSmartphone className="mr-2 text-indigo-400" />
              Active Devices
            </h2>
            <span className="text-sm text-gray-400">
              {userData.user_devices
                ? userData.user_devices.filter((d) => d.status).length
                : 0}{" "}
              currently online
            </span>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            {userData?.user_devices?.map((device) => (
              <div
                key={device.id}
                className={`bg-gray-800 rounded-lg p-4 border ${
                  device.status ? "border-indigo-500" : "border-gray-700"
                } ${
                  device.id === currentDeviceId ? "ring-2 ring-indigo-500" : ""
                }`}
              >
                <div className="flex justify-between items-start mb-2">
                  <h3 className="font-medium">
                    {device.userAgent.split(" ")[0] || "Unknown Device"}
                    {device.id === currentDeviceId && " (Current)"}
                  </h3>
                  <span
                    className={`text-xs px-2 py-1 rounded-full ${
                      device.status
                        ? "bg-green-900/50 text-green-400"
                        : "bg-gray-700 text-gray-400"
                    }`}
                  >
                    {device.status ? "Online" : "Offline"}
                  </span>
                </div>
                <div className="text-sm space-y-1 text-gray-400">
                  <p>Last login: {formatDate(device.loggedInAt)}</p>
                  <p>IP: {device.ipAddress}</p>
                  <div className="flex items-center">
                    <FiMapPin className="mr-1 text-blue-400" size={14} />
                    <span>Click on Locate</span>
                  </div>
                </div>
                <div className="mt-4 flex justify-between items-center">
                  <button
                    onClick={() => loadDeviceLocation(device.ipAddress)}
                    disabled={isLoadingLocation}
                    className={`flex items-center text-sm px-3 py-1 rounded ${
                      isLoadingLocation && selectedDeviceIp === device.ipAddress
                        ? "bg-gray-700 text-gray-500 cursor-not-allowed"
                        : "bg-blue-900/50 hover:bg-blue-900/70 text-blue-400"
                    }`}
                  >
                    {isLoadingLocation &&
                    selectedDeviceIp === device.ipAddress ? (
                      <div className="flex items-center">
                        <div className="animate-spin rounded-full h-3 w-3 border-t-2 border-b-2 border-white mr-2"></div>
                        Loading...
                      </div>
                    ) : (
                      <>
                        <FiMapPin className="mr-1" /> Locate
                      </>
                    )}
                  </button>
                  <div className="flex space-x-2">
                    {device.status ? (
                      <button
                        onClick={() => handleDeviceAction(device.id, "logout")}
                        disabled={device.id === currentDeviceId}
                        className={`flex items-center text-sm px-3 py-1 rounded ${
                          device.id === currentDeviceId
                            ? "bg-gray-700 text-gray-500 cursor-not-allowed"
                            : "bg-red-900/50 hover:bg-red-900/70 text-red-400"
                        }`}
                      >
                        <FiPower className="mr-1" /> Logout
                      </button>
                    ) : (
                      device.id !== currentDeviceId && (
                        <button
                          onClick={() =>
                            handleDeviceAction(device.id, "delete")
                          }
                          className="flex items-center text-sm bg-gray-700 hover:bg-gray-600 text-gray-300 px-3 py-1 rounded"
                        >
                          <FiTrash2 className="mr-1" /> Remove
                        </button>
                      )
                    )}
                  </div>
                </div>
              </div>
            ))}
          </div>
        </motion.div>
      </div>
    </div>
  );
}
