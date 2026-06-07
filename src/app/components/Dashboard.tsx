"use client";

import { useState, useEffect } from "react";
import { motion } from "framer-motion";
import Link from "next/link";
import {
  FiServer,
  FiWifi,
  FiWifiOff,
  FiCalendar,
  FiDollarSign,
  FiLoader,
  FiAlertTriangle,
  FiRefreshCw,
} from "react-icons/fi";
import { FaTelegram } from "react-icons/fa";
import {
  AreaChart,
  Area,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
} from "recharts";
import useSWR, { useSWRConfig } from "swr";

const fetcher = async (url: string) => {
  try {
    const localData = localStorage.getItem("userData");
    const token = localData ? JSON.parse(localData).token : null;
    const response = await fetch(url, {
      credentials: "include",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
    });

    if (!response.ok) {
      const errorData = await response.json().catch(() => null);
      console.error("API Error:", {
        url,
        status: response.status,
        statusText: response.statusText,
        errorData,
      });
      throw new Error(
        errorData?.message || `Request failed with status ${response.status}`
      );
    }

    const data = await response.json();
    return data;
  } catch (error) {
    console.error("Error in fetcher:", {
      url,
      error: error instanceof Error ? error.message : "Unknown error",
      stack: error instanceof Error ? error.stack : undefined,
    });
    throw error;
  }
};

const Dashboard = () => {
  const [timeRange, setTimeRange] = useState("1day");
  const [isRefreshing, setIsRefreshing] = useState(false);
  const { mutate } = useSWRConfig();

  const handleRefresh = async () => {
    setIsRefreshing(true);
    try {
      await Promise.all([
        mutate("/api/client/devices?countsOnly=true"),
        mutate(`/api/client/devices?analytics=true&timeRange=${timeRange}`),
        mutate("/api/auth/user"),
      ]);
    } catch (error) {
      console.error("Refresh failed:", error);
    } finally {
      setIsRefreshing(false);
    }
  };

  useEffect(() => {
    console.log("Dashboard component mounted");
    return () => console.log("Dashboard component unmounted");
  }, []);

  useEffect(() => {
    console.log("Time range changed to:", timeRange);
  }, [timeRange]);

  const { data: counts, error: countsError } = useSWR(
    "/api/client/devices?countsOnly=true",
    fetcher,
    {
      onErrorRetry: (error, key, config, revalidate, { retryCount }) => {
        console.log(`Retry attempt ${retryCount} for counts`);
        if (retryCount >= 3) return;
        setTimeout(() => revalidate({ retryCount }), 5000);
      },
    }
  );

  const { data: analyticsData, error: analyticsError } = useSWR(
    `/api/client/devices?analytics=true&timeRange=${timeRange}`,
    fetcher,
    {
      onErrorRetry: (error, key, config, revalidate, { retryCount }) => {
        console.log(`Retry attempt ${retryCount} for analytics`);
        if (retryCount >= 3) return;
        setTimeout(() => revalidate({ retryCount }), 5000);
      },
    }
  );

  const { data: userData, error: userError } = useSWR(
    "/api/auth/user",
    fetcher,
    {
      onErrorRetry: (error, key, config, revalidate, { retryCount }) => {
        console.log(`Retry attempt ${retryCount} for user data`);
        if (retryCount >= 3) return;
        setTimeout(() => revalidate({ retryCount }), 5000);
      },
    }
  );

  useEffect(() => {
    if (counts) console.log("Counts data loaded:", counts);
    if (countsError) console.error("Counts error:", countsError);
  }, [counts, countsError]);

  useEffect(() => {
    if (analyticsData) console.log("Analytics data loaded:", analyticsData);
    if (analyticsError) console.error("Analytics error:", analyticsError);
  }, [analyticsData, analyticsError]);

  useEffect(() => {
    if (userData) console.log("User data loaded:", userData);
    if (userError) console.error("User error:", userError);
  }, [userData, userError]);

  const hasDevices = counts?.total > 0;
  const isLoading = !counts && !countsError;

  const cardVariants = {
    hidden: { opacity: 0, y: 20 },
    visible: { opacity: 1, y: 0 },
  };

  const getEmptyAnalyticsData = () => {
    if (timeRange === "1day") {
      return Array.from({ length: 6 }).map((_, i) => ({
        name: `${i * 4}:00`,
        online: 0,
        offline: 0,
      }));
    } else if (timeRange === "1week") {
      const days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
      return days.map((day) => ({
        name: day,
        online: 0,
        offline: 0,
      }));
    } else {
      return Array.from({ length: 4 }).map((_, i) => ({
        name: `Week ${i + 1}`,
        online: 0,
        offline: 0,
      }));
    }
  };

  return (
    <div className="flex-1 p-6 ml-20 bg-gray-900 text-gray-100 min-h-screen">
      {/* Dashboard Header with Refresh Button */}
      <div className="mb-6 flex justify-between items-start">
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ duration: 0.5 }}
        >
          <h1 className="text-3xl font-bold text-indigo-400">Dashboard</h1>
          <p className="text-gray-400">Overview of your devices and account</p>
        </motion.div>
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
          aria-label="Refresh dashboard"
        >
          <FiRefreshCw
            className={`text-xl ${isRefreshing ? "animate-spin" : ""}`}
          />
        </motion.button>
      </div>

      {/* Devices Overview */}
      <section className="mb-10">
        <h2 className="text-xl font-semibold mb-4 text-gray-300">
          Devices Overview
        </h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          {/* Total Devices Card */}
          <motion.div
            variants={cardVariants}
            initial="hidden"
            animate="visible"
            transition={{ duration: 0.3, delay: 0.1 }}
          >
            <Link href="/devices?filter=total_devices" passHref>
              <div className="bg-gray-800 rounded-lg p-6 hover:bg-gray-700 transition-all duration-300 border border-gray-700 hover:border-indigo-500 cursor-pointer">
                <div className="flex flex-col items-center text-center">
                  <div className="bg-indigo-900/20 p-4 rounded-full mb-4 border border-indigo-500/30">
                    {isLoading ? (
                      <FiLoader className="text-indigo-400 text-2xl animate-spin" />
                    ) : (
                      <FiServer className="text-indigo-400 text-2xl" />
                    )}
                  </div>
                  <h3 className="text-lg font-medium mb-1">Total Devices</h3>
                  <p className="text-3xl font-bold mb-2">
                    {isLoading ? "--" : counts?.total || 0}
                  </p>
                  <p className="text-gray-400 text-sm">
                    All registered devices
                  </p>
                </div>
              </div>
            </Link>
          </motion.div>

          {/* Online Devices Card */}
          <motion.div
            variants={cardVariants}
            initial="hidden"
            animate="visible"
            transition={{ duration: 0.3, delay: 0.2 }}
          >
            <Link href="/devices?filter=online_devices" passHref>
              <div className="bg-gray-800 rounded-lg p-6 hover:bg-gray-700 transition-all duration-300 border border-gray-700 hover:border-green-500 cursor-pointer">
                <div className="flex flex-col items-center text-center">
                  <div className="bg-green-900/20 p-4 rounded-full mb-4 border border-green-500/30">
                    {isLoading ? (
                      <FiLoader className="text-green-400 text-2xl animate-spin" />
                    ) : (
                      <FiWifi className="text-green-400 text-2xl" />
                    )}
                  </div>
                  <h3 className="text-lg font-medium mb-1">Online Devices</h3>
                  <p className="text-3xl font-bold mb-2 text-green-400">
                    {isLoading ? "--" : counts?.online || 0}
                  </p>
                  <p className="text-gray-400 text-sm">Currently connected</p>
                </div>
              </div>
            </Link>
          </motion.div>

          {/* Offline Devices Card */}
          <motion.div
            variants={cardVariants}
            initial="hidden"
            animate="visible"
            transition={{ duration: 0.3, delay: 0.3 }}
          >
            <Link href="/devices?filter=offline_devices" passHref>
              <div className="bg-gray-800 rounded-lg p-6 hover:bg-gray-700 transition-all duration-300 border border-gray-700 hover:border-red-500 cursor-pointer">
                <div className="flex flex-col items-center text-center">
                  <div className="bg-red-900/20 p-4 rounded-full mb-4 border border-red-500/30">
                    {isLoading ? (
                      <FiLoader className="text-red-400 text-2xl animate-spin" />
                    ) : (
                      <FiWifiOff className="text-red-400 text-2xl" />
                    )}
                  </div>
                  <h3 className="text-lg font-medium mb-1">Offline Devices</h3>
                  <p className="text-3xl font-bold mb-2 text-red-400">
                    {isLoading ? "--" : counts?.offline || 0}
                  </p>
                  <p className="text-gray-400 text-sm">Not responding</p>
                </div>
              </div>
            </Link>
          </motion.div>
        </div>
      </section>

      {/* Analytics Section */}
      <section className="mb-10">
        <div className="flex justify-between items-center mb-4">
          <h2 className="text-xl font-semibold text-gray-300">
            Devices Status
          </h2>
          <div className="flex space-x-2">
            {["1day", "1week", "30day"].map((range, i) => (
              <motion.button
                key={range}
                whileHover={{ scale: 1.05 }}
                whileTap={{ scale: 0.95 }}
                onClick={() => setTimeRange(range)}
                className={`px-3 py-1 rounded-md ${
                  timeRange === range ? "bg-indigo-600" : "bg-gray-700"
                }`}
                transition={{ duration: 0.1 }}
              >
                {range === "1day"
                  ? "1 Day"
                  : range === "1week"
                  ? "1 Week"
                  : "30 Days"}
              </motion.button>
            ))}
          </div>
        </div>

        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ duration: 0.5 }}
          className="bg-gray-800 rounded-lg p-6 border border-gray-700"
        >
          <div className="h-80">
            {isLoading ? (
              <div className="flex items-center justify-center h-full">
                <FiLoader className="animate-spin text-indigo-400 text-4xl" />
              </div>
            ) : !hasDevices ? (
              <div className="flex flex-col items-center justify-center h-full text-gray-400">
                <FiAlertTriangle className="text-4xl mb-4 text-yellow-500" />
                <p className="text-xl mb-2">No devices found</p>
                <p className="text-sm">
                  Register your first device to see analytics
                </p>
              </div>
            ) : (
              <ResponsiveContainer width="100%" height="100%">
                <AreaChart data={analyticsData || getEmptyAnalyticsData()}>
                  <defs>
                    <linearGradient
                      id="colorOnline"
                      x1="0"
                      y1="0"
                      x2="0"
                      y2="1"
                    >
                      <stop offset="5%" stopColor="#10B981" stopOpacity={0.8} />
                      <stop offset="95%" stopColor="#10B981" stopOpacity={0} />
                    </linearGradient>
                    <linearGradient
                      id="colorOffline"
                      x1="0"
                      y1="0"
                      x2="0"
                      y2="1"
                    >
                      <stop offset="5%" stopColor="#EF4444" stopOpacity={0.8} />
                      <stop offset="95%" stopColor="#EF4444" stopOpacity={0} />
                    </linearGradient>
                  </defs>
                  <CartesianGrid strokeDasharray="3 3" stroke="#374151" />
                  <XAxis dataKey="name" stroke="#9CA3AF" />
                  <YAxis stroke="#9CA3AF" />
                  <Tooltip
                    contentStyle={{
                      backgroundColor: "#1F2937",
                      borderColor: "#374151",
                      borderRadius: "0.5rem",
                    }}
                  />
                  <Area
                    type="monotone"
                    dataKey="online"
                    stroke="#10B981"
                    fillOpacity={1}
                    fill="url(#colorOnline)"
                    strokeWidth={2}
                  />
                  <Area
                    type="monotone"
                    dataKey="offline"
                    stroke="#EF4444"
                    fillOpacity={1}
                    fill="url(#colorOffline)"
                    strokeWidth={2}
                  />
                </AreaChart>
              </ResponsiveContainer>
            )}
          </div>
        </motion.div>
      </section>

      {/* Plan Information Section */}
      <section>
        <h2 className="text-xl font-semibold mb-4 text-gray-300">
          Plan Information
        </h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          {[
            {
              icon: <FiCalendar className="text-indigo-400 text-xl" />,
              title: "Expiration Date",
              value: userData?.user?.exp_date
                ? new Date(userData.user.exp_date).toLocaleDateString()
                : "--",
            },
            {
              icon: <FiDollarSign className="text-indigo-400 text-xl" />,
              title: "Plan Amount",
              value: userData?.user?.amount_paid
                ? `${userData.user.amount_paid}`
                : "--",
            },
            {
              icon: <FaTelegram className="text-indigo-400 text-xl" />,
              title: "Telegram ID",
              value: userData?.user?.tg_username || "@username",
            },
          ].map((item, index) => (
            <motion.div
              key={index}
              variants={cardVariants}
              initial="hidden"
              animate="visible"
              transition={{ duration: 0.3, delay: 0.4 + index * 0.1 }}
              whileHover={{ y: -5 }}
              className="bg-gray-800 rounded-lg p-6 border border-gray-700 hover:border-indigo-500 transition-all duration-300"
            >
              <div className="flex items-center space-x-4">
                <div className="bg-indigo-900/20 p-3 rounded-full border border-indigo-500/30">
                  {item.icon}
                </div>
                <div>
                  <h3 className="text-gray-400 text-sm">{item.title}</h3>
                  <p className="text-lg font-medium">{item.value}</p>
                </div>
              </div>
            </motion.div>
          ))}
        </div>
      </section>
    </div>
  );
};

export default Dashboard;
