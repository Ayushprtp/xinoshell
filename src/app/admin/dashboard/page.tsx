"use client";
import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import toast, { Toaster } from "react-hot-toast";
import { ImBlocked, ImCheckmark } from "react-icons/im";
import {
  FiEdit2,
  FiLogOut,
  FiMoon,
  FiPlus,
  FiSun,
  FiTrash2,
  FiUser,
} from "react-icons/fi";

interface User {
  id: string;
  name: string;
  username: string;
  password: string;
  tg_username: string;
  tg_id: number;
  last_login: string | null;
  exp_date: string;
  amount_paid: string;
  isDisabled: boolean;
  isTwoFactor: boolean;
  isMultiDevice: boolean;
  lang: string;
  registeredOn: string;
}

interface ApiResponse {
  success: boolean;
  message: string;
  data: User | User[];
}

const ITEMS_PER_PAGE = 10;

export default function AdminDashboard() {
  const router = useRouter();
  const [users, setUsers] = useState<User[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [currentPage, setCurrentPage] = useState(1);
  const [showModal, setShowModal] = useState(false);
  const [isEditMode, setIsEditMode] = useState(false);
  const [currentUser, setCurrentUser] = useState<User | null>(null);
  const [darkMode, setDarkMode] = useState(false);
  const [isClient, setIsClient] = useState(false);
  const [formData, setFormData] = useState<Partial<User>>({
    name: "",
    username: "",
    password: "",
    tg_username: "",
    tg_id: 0,
    exp_date: "",
    amount_paid: "0.00",
    isTwoFactor: false,
    isMultiDevice: false,
    lang: "en",
  });

  // Check if we're on the client side
  useEffect(() => {
    setIsClient(true);
    const savedDarkMode = localStorage.getItem("darkMode") === "true";
    setDarkMode(savedDarkMode);
  }, []);

  // Toggle dark mode
  const toggleDarkMode = () => {
    const newDarkMode = !darkMode;
    setDarkMode(newDarkMode);
    localStorage.setItem("darkMode", String(newDarkMode));
  };

  // Check authentication and load users
  useEffect(() => {
    if (!isClient) return;

    const token = localStorage.getItem("adminToken");
    if (!token) {
      router.push("/admin/login");
      return;
    }

    fetchUsers();
  }, [router, isClient]);

  const fetchUsers = async () => {
    setIsLoading(true);
    try {
      const token = localStorage.getItem("adminToken");
      const response = await fetch("/api/admin/users", {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });

      const data: ApiResponse = await response.json();

      if (!data.success) {
        throw new Error(data.message || "Failed to fetch users");
      }

      setUsers(Array.isArray(data.data) ? data.data : [data.data]);
    } catch (error) {
      toast.error(
        error instanceof Error ? error.message : "Failed to fetch users"
      );
      if (error instanceof Error && error.message.includes("Unauthorized")) {
        localStorage.removeItem("adminToken");
        localStorage.removeItem("adminData");
        router.push("/admin/login");
      }
    } finally {
      setIsLoading(false);
    }
  };

  const handleInputChange = (
    e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>
  ) => {
    const { name, value, type } = e.target;
    const checked =
      type === "checkbox" ? (e.target as HTMLInputElement).checked : undefined;

    setFormData((prev) => ({
      ...prev,
      [name]: type === "checkbox" ? checked : value,
    }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);

    try {
      const token = localStorage.getItem("adminToken");
      const url =
        isEditMode && currentUser
          ? `/api/admin/users/${currentUser.id}`
          : "/api/admin/users";

      const method = isEditMode ? "PATCH" : "POST";
      const payload = {
        ...formData,
        tg_id: Number(formData.tg_id),
      };

      const response = await fetch(url, {
        method,
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify(payload),
      });

      const data: ApiResponse = await response.json();

      if (!data.success) {
        throw new Error(
          data.message || `Failed to ${isEditMode ? "update" : "create"} user`
        );
      }

      toast.success(data.message);
      setShowModal(false);
      fetchUsers();
    } catch (error) {
      toast.error(
        error instanceof Error
          ? error.message
          : `Failed to ${isEditMode ? "update" : "create"} user`
      );
    } finally {
      setIsLoading(false);
    }
  };

  const handleDeleteUser = async (userId: string) => {
    if (!confirm("Are you sure you want to delete this user?")) return;

    setIsLoading(true);

    try {
      const token = localStorage.getItem("adminToken");
      const response = await fetch(`/api/admin/users/${userId}`, {
        method: "DELETE",
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });

      const data: ApiResponse = await response.json();

      if (!data.success) {
        throw new Error(data.message || "Failed to delete user");
      }

      toast.success(data.message);
      fetchUsers();
    } catch (error) {
      toast.error(
        error instanceof Error ? error.message : "Failed to delete user"
      );
    } finally {
      setIsLoading(false);
    }
  };

  const handleDisableUser = async (userId: string) => {
    const confirmation = confirm(
      "Are you sure you want to toggle this user's status?"
    );
    if (!confirmation) return;

    setIsLoading(true);

    try {
      const token = localStorage.getItem("adminToken");
      const response = await fetch(`/api/admin/users/${userId}`, {
        method: "POST",
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });

      const data: ApiResponse = await response.json();

      if (!data.success) {
        throw new Error(data.message || "Failed to toggle user status");
      }

      toast.success(data.message);
      fetchUsers();
    } catch (error) {
      toast.error(
        error instanceof Error ? error.message : "Failed to toggle user status"
      );
    } finally {
      setIsLoading(false);
    }
  };

  const handleLogout = () => {
    localStorage.removeItem("adminToken");
    localStorage.removeItem("adminData");
    router.push("/admin/login");
  };

  const openEditModal = (user: User) => {
    setCurrentUser(user);
    setIsEditMode(true);
    setFormData({
      name: user.name,
      username: user.username,
      password: user.password,
      tg_username: user.tg_username,
      tg_id: user.tg_id,
      exp_date: user.exp_date.split("T")[0],
      amount_paid: user.amount_paid,
      isTwoFactor: user.isTwoFactor,
      isMultiDevice: user.isMultiDevice,
      lang: user.lang,
    });
    setShowModal(true);
  };

  const openCreateModal = () => {
    setCurrentUser(null);
    setIsEditMode(false);
    setFormData({
      name: "",
      username: "",
      password: "",
      tg_username: "",
      tg_id: 0,
      exp_date: "",
      amount_paid: "0.00",
      isTwoFactor: false,
      isMultiDevice: false,
      lang: "en",
    });
    setShowModal(true);
  };

  // Pagination logic
  const totalPages = Math.ceil(users.length / ITEMS_PER_PAGE);
  const paginatedUsers = users.slice(
    (currentPage - 1) * ITEMS_PER_PAGE,
    currentPage * ITEMS_PER_PAGE
  );

  // Apply dark mode class to body
  useEffect(() => {
    if (darkMode) {
      document.documentElement.classList.add("dark");
    } else {
      document.documentElement.classList.remove("dark");
    }
  }, [darkMode]);

  if (!isClient) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-indigo-500"></div>
      </div>
    );
  }

  return (
    <div
      className={`min-h-screen transition-colors duration-300 ${
        darkMode ? "dark bg-gray-900" : "bg-gray-100"
      }`}
    >
      <Toaster position="top-right" />

      {/* Header */}
      <header className={`shadow-sm ${darkMode ? "bg-gray-800" : "bg-white"}`}>
        <div className="max-w-7xl mx-auto px-4 py-4 sm:px-6 lg:px-8 flex justify-between items-center">
          <h1
            className={`text-xl font-bold ${
              darkMode ? "text-white" : "text-gray-900"
            }`}
          >
            Admin Dashboard
          </h1>
          <div className="flex items-center space-x-4">
            <button
              onClick={toggleDarkMode}
              className={`p-2 rounded-full ${
                darkMode
                  ? "bg-gray-700 text-yellow-300"
                  : "bg-gray-200 text-gray-700"
              }`}
            >
              {darkMode ? <FiSun /> : <FiMoon />}
            </button>
            <button
              onClick={handleLogout}
              className="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500"
            >
              <FiLogOut className="mr-2" /> Logout
            </button>
          </div>
        </div>
      </header>

      {/* Main Content */}
      <main className="max-w-7xl mx-auto px-4 py-6 sm:px-6 lg:px-8">
        {/* Controls */}
        <div className="mb-6 flex justify-between items-center">
          <h2
            className={`text-lg font-medium ${
              darkMode ? "text-white" : "text-gray-900"
            }`}
          >
            User Management
          </h2>
          <button
            onClick={openCreateModal}
            className="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
          >
            <FiPlus className="mr-2" /> Create User
          </button>
        </div>

        {/* Users Table */}
        <div
          className={`shadow rounded-lg overflow-hidden ${
            darkMode ? "bg-gray-800" : "bg-white"
          }`}
        >
          {isLoading ? (
            <div
              className={`p-8 text-center ${
                darkMode ? "text-gray-300" : "text-gray-600"
              }`}
            >
              <i className="fas fa-spinner fa-spin text-2xl text-indigo-600"></i>
              <p className="mt-2">Loading users...</p>
            </div>
          ) : users.length === 0 ? (
            <div
              className={`p-8 text-center ${
                darkMode ? "text-gray-300" : "text-gray-600"
              }`}
            >
              <i className="fas fa-users-slash text-2xl"></i>
              <p className="mt-2">No users found</p>
            </div>
          ) : (
            <>
              <div className="overflow-x-auto">
                <table className="min-w-full divide-y divide-gray-200">
                  <thead className={darkMode ? "bg-gray-700" : "bg-gray-500"}>
                    <tr>
                      <th
                        scope="col"
                        className="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                      >
                        Name
                      </th>
                      <th
                        scope="col"
                        className="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                      >
                        Username
                      </th>
                      <th
                        scope="col"
                        className="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                      >
                        Telegram
                      </th>
                      <th
                        scope="col"
                        className="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                      >
                        Expiry Date
                      </th>
                      <th
                        scope="col"
                        className="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"
                      >
                        Status
                      </th>
                      <th
                        scope="col"
                        className="px-6 py-3 text-right text-xs font-medium uppercase tracking-wider"
                      >
                        Actions
                      </th>
                    </tr>
                  </thead>
                  <tbody
                    className={`divide-y ${
                      darkMode ? "divide-gray-700" : "divide-gray-200"
                    }`}
                  >
                    {paginatedUsers.map((user) => (
                      <tr
                        key={user.id}
                        className={
                          darkMode ? "hover:bg-gray-700" : "hover:bg-gray-50"
                        }
                      >
                        <td className="px-6 py-4 whitespace-nowrap">
                          <div className="flex items-center">
                            <div className="flex-shrink-0 h-10 w-10 rounded-full bg-indigo-100 flex items-center justify-center">
                              <FiUser className="text-indigo-600" />
                            </div>
                            <div className="ml-4">
                              <div
                                className={`text-sm font-medium ${
                                  darkMode ? "text-white" : "text-gray-900"
                                }`}
                              >
                                {user.name}
                              </div>
                              <div
                                className={`text-sm ${
                                  darkMode ? "text-gray-300" : "text-gray-500"
                                }`}
                              >
                                ID: {user.id}
                              </div>
                            </div>
                          </div>
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap">
                          <div
                            className={`text-sm ${
                              darkMode ? "text-white" : "text-gray-900"
                            }`}
                          >
                            {user.username}
                          </div>
                          <div
                            className={`text-sm ${
                              darkMode ? "text-gray-300" : "text-gray-500"
                            }`}
                          >
                            {user.password ? user.password : "No Password"}
                          </div>
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap">
                          <div
                            className={`text-sm ${
                              darkMode ? "text-white" : "text-gray-900"
                            }`}
                          >
                            {user.tg_username}
                          </div>
                          <div
                            className={`text-sm ${
                              darkMode ? "text-gray-300" : "text-gray-500"
                            }`}
                          >
                            ID: {user.tg_id}
                          </div>
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap">
                          <div
                            className={`text-sm ${
                              darkMode ? "text-white" : "text-gray-900"
                            }`}
                          >
                            {new Date(user.exp_date).toLocaleDateString()}
                          </div>
                          <div
                            className={`text-sm ${
                              darkMode ? "text-gray-300" : "text-gray-500"
                            }`}
                          >
                            ${user.amount_paid}
                          </div>
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap">
                          <div className="flex flex-col space-y-1">
                            <span
                              className={`px-2 inline-flex text-xs leading-5 font-semibold rounded-full ${
                                user.isTwoFactor
                                  ? "bg-green-100 text-green-800"
                                  : darkMode
                                  ? "bg-gray-600 text-gray-200"
                                  : "bg-gray-100 text-gray-800"
                              }`}
                            >
                              2FA: {user.isTwoFactor ? "ON" : "OFF"}
                            </span>
                            <span
                              className={`px-2 inline-flex text-xs leading-5 font-semibold rounded-full ${
                                user.isMultiDevice
                                  ? "bg-blue-100 text-blue-800"
                                  : darkMode
                                  ? "bg-gray-600 text-gray-200"
                                  : "bg-gray-100 text-gray-800"
                              }`}
                            >
                              Multi: {user.isMultiDevice ? "ON" : "OFF"}
                            </span>
                          </div>
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap">
                          <div className="flex items-center justify-end gap-4">
                            <button
                              onClick={() => openEditModal(user)}
                              className={`${
                                darkMode
                                  ? "text-blue-400 hover:text-blue-300"
                                  : "text-indigo-600 hover:text-indigo-900"
                              }`}
                            >
                              <FiEdit2 />
                            </button>
                            <button
                              onClick={() => handleDeleteUser(user.id)}
                              className={`${
                                darkMode
                                  ? "text-red-400 hover:text-red-300"
                                  : "text-red-600 hover:text-red-900"
                              }`}
                            >
                              <FiTrash2 />
                            </button>
                            <button
                              onClick={() => handleDisableUser(user.id)}
                              className={`${
                                darkMode
                                  ? user.isDisabled
                                    ? "text-green-400 hover:text-green-300"
                                    : "text-red-400 hover:text-red-300"
                                  : user.isDisabled
                                  ? "text-green-600 hover:text-green-900"
                                  : "text-red-600 hover:text-red-900"
                              }`}
                              title={
                                user.isDisabled ? "Enable user" : "Disable user"
                              }
                            >
                              {user.isDisabled ? (
                                <ImCheckmark />
                              ) : (
                                <ImBlocked />
                              )}
                            </button>
                          </div>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>

              {/* Pagination */}
              {totalPages > 1 && (
                <div
                  className={`px-4 py-3 flex items-center justify-between border-t ${
                    darkMode
                      ? "border-gray-700 bg-gray-800"
                      : "border-gray-200 bg-white"
                  }`}
                >
                  <div className="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
                    <div>
                      <p
                        className={`text-sm ${
                          darkMode ? "text-gray-300" : "text-gray-700"
                        }`}
                      >
                        Showing{" "}
                        <span className="font-medium">
                          {(currentPage - 1) * ITEMS_PER_PAGE + 1}
                        </span>{" "}
                        to{" "}
                        <span className="font-medium">
                          {Math.min(currentPage * ITEMS_PER_PAGE, users.length)}
                        </span>{" "}
                        of <span className="font-medium">{users.length}</span>{" "}
                        users
                      </p>
                    </div>
                    <div>
                      <nav
                        className="relative z-0 inline-flex rounded-md shadow-sm -space-x-px"
                        aria-label="Pagination"
                      >
                        <button
                          onClick={() =>
                            setCurrentPage((prev) => Math.max(prev - 1, 1))
                          }
                          disabled={currentPage === 1}
                          className={`relative inline-flex items-center px-2 py-2 rounded-l-md border text-sm font-medium ${
                            darkMode
                              ? "border-gray-600 bg-gray-700 text-gray-300 hover:bg-gray-600"
                              : "border-gray-300 bg-white text-gray-500 hover:bg-gray-50"
                          } disabled:opacity-50 disabled:cursor-not-allowed`}
                        >
                          <span className="sr-only">Previous</span>
                          <i className="fas fa-chevron-left"></i>
                        </button>
                        {Array.from(
                          { length: totalPages },
                          (_, i) => i + 1
                        ).map((page) => (
                          <button
                            key={page}
                            onClick={() => setCurrentPage(page)}
                            className={`relative inline-flex items-center px-4 py-2 border text-sm font-medium ${
                              currentPage === page
                                ? "z-10 bg-indigo-50 border-indigo-500 text-indigo-600"
                                : darkMode
                                ? "bg-gray-700 border-gray-600 text-gray-300 hover:bg-gray-600"
                                : "bg-white border-gray-300 text-gray-500 hover:bg-gray-50"
                            }`}
                          >
                            {page}
                          </button>
                        ))}
                        <button
                          onClick={() =>
                            setCurrentPage((prev) =>
                              Math.min(prev + 1, totalPages)
                            )
                          }
                          disabled={currentPage === totalPages}
                          className={`relative inline-flex items-center px-2 py-2 rounded-r-md border text-sm font-medium ${
                            darkMode
                              ? "border-gray-600 bg-gray-700 text-gray-300 hover:bg-gray-600"
                              : "border-gray-300 bg-white text-gray-500 hover:bg-gray-50"
                          } disabled:opacity-50 disabled:cursor-not-allowed`}
                        >
                          <span className="sr-only">Next</span>
                          <i className="fas fa-chevron-right"></i>
                        </button>
                      </nav>
                    </div>
                  </div>
                </div>
              )}
            </>
          )}
        </div>
      </main>

      {/* Combined Create/Edit User Modal */}
      {showModal && (
        <div className="fixed z-50 inset-0 overflow-y-auto">
          <div className="flex items-center justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
            {/* Modal container */}
            <div className="inline-block align-bottom rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-2xl sm:w-full">
              <div
                className={`${
                  darkMode ? "bg-gray-800" : "bg-white"
                } px-4 pt-5 pb-4 sm:p-6 sm:pb-4`}
                onClick={(e) => e.stopPropagation()}
              >
                <div>
                  <div className="mx-auto flex items-center justify-center h-12 w-12 rounded-full bg-blue-100">
                    <FiUser className="text-indigo-600" />
                  </div>
                  <div className="mt-3 text-center sm:mt-5">
                    <h3
                      className={`text-lg leading-6 font-medium ${
                        darkMode ? "text-white" : "text-gray-900"
                      }`}
                    >
                      {isEditMode
                        ? `Edit User: ${currentUser?.name}`
                        : "Create New User"}
                    </h3>
                    <div className="mt-2">
                      <form onSubmit={handleSubmit}>
                        <div className="grid grid-cols-1 gap-y-4 gap-x-4 sm:grid-cols-6">
                          <div className="sm:col-span-6">
                            <label
                              htmlFor="name"
                              className={`block text-sm font-medium ${
                                darkMode ? "text-gray-300" : "text-gray-700"
                              }`}
                            >
                              Full Name
                            </label>
                            <input
                              type="text"
                              name="name"
                              id="name"
                              required
                              value={formData.name}
                              onChange={handleInputChange}
                              className={`mt-1 block w-full rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm ${
                                darkMode
                                  ? "bg-gray-700 border-gray-600 text-white"
                                  : "border border-gray-300"
                              }`}
                            />
                          </div>

                          <div className="sm:col-span-3">
                            <label
                              htmlFor="username"
                              className={`block text-sm font-medium ${
                                darkMode ? "text-gray-300" : "text-gray-700"
                              }`}
                            >
                              Username
                            </label>
                            <input
                              type="text"
                              name="username"
                              id="username"
                              required
                              value={formData.username}
                              onChange={handleInputChange}
                              className={`mt-1 block w-full rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm ${
                                darkMode
                                  ? "bg-gray-700 border-gray-600 text-white"
                                  : "border border-gray-300"
                              }`}
                            />
                          </div>

                          <div className="sm:col-span-3">
                            <label
                              htmlFor="password"
                              className={`block text-sm font-medium ${
                                darkMode ? "text-gray-300" : "text-gray-700"
                              }`}
                            >
                              Password
                            </label>
                            <input
                              type="password"
                              name="password"
                              id="password"
                              required={!isEditMode}
                              value={formData.password}
                              onChange={handleInputChange}
                              className={`mt-1 block w-full rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm ${
                                darkMode
                                  ? "bg-gray-700 border-gray-600 text-white"
                                  : "border border-gray-300"
                              }`}
                            />
                          </div>

                          <div className="sm:col-span-3">
                            <label
                              htmlFor="tg_username"
                              className={`block text-sm font-medium ${
                                darkMode ? "text-gray-300" : "text-gray-700"
                              }`}
                            >
                              Telegram Username
                            </label>
                            <input
                              type="text"
                              name="tg_username"
                              id="tg_username"
                              required
                              value={formData.tg_username}
                              onChange={handleInputChange}
                              className={`mt-1 block w-full rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm ${
                                darkMode
                                  ? "bg-gray-700 border-gray-600 text-white"
                                  : "border border-gray-300"
                              }`}
                            />
                          </div>

                          <div className="sm:col-span-3">
                            <label
                              htmlFor="tg_id"
                              className={`block text-sm font-medium ${
                                darkMode ? "text-gray-300" : "text-gray-700"
                              }`}
                            >
                              Telegram ID
                            </label>
                            <input
                              type="number"
                              name="tg_id"
                              id="tg_id"
                              required
                              value={formData.tg_id}
                              onChange={handleInputChange}
                              className={`mt-1 block w-full rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm ${
                                darkMode
                                  ? "bg-gray-700 border-gray-600 text-white"
                                  : "border border-gray-300"
                              }`}
                            />
                          </div>

                          <div className="sm:col-span-3">
                            <label
                              htmlFor="exp_date"
                              className={`block text-sm font-medium ${
                                darkMode ? "text-gray-300" : "text-gray-700"
                              }`}
                            >
                              Expiry Date
                            </label>
                            <input
                              type="date"
                              name="exp_date"
                              id="exp_date"
                              required
                              value={formData.exp_date}
                              onChange={handleInputChange}
                              className={`mt-1 block w-full rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm ${
                                darkMode
                                  ? "bg-gray-700 border-gray-600 text-white"
                                  : "border border-gray-300"
                              }`}
                            />
                          </div>

                          <div className="sm:col-span-3">
                            <label
                              htmlFor="amount_paid"
                              className={`block text-sm font-medium ${
                                darkMode ? "text-gray-300" : "text-gray-700"
                              }`}
                            >
                              Amount Paid ($)
                            </label>
                            <input
                              type="number"
                              step=""
                              name="amount_paid"
                              id="amount_paid"
                              required
                              value={formData.amount_paid}
                              onChange={handleInputChange}
                              className={`mt-1 block w-full rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm ${
                                darkMode
                                  ? "bg-gray-700 border-gray-600 text-white"
                                  : "border border-gray-300"
                              }`}
                            />
                          </div>

                          <div className="sm:col-span-3">
                            <label
                              htmlFor="lang"
                              className={`block text-sm font-medium ${
                                darkMode ? "text-gray-300" : "text-gray-700"
                              }`}
                            >
                              Language
                            </label>
                            <select
                              name="lang"
                              id="lang"
                              value={formData.lang}
                              onChange={handleInputChange}
                              className={`mt-1 block w-full rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm ${
                                darkMode
                                  ? "bg-gray-700 border-gray-600 text-white"
                                  : "border border-gray-300"
                              }`}
                            >
                              <option value="en">English</option>
                              <option value="es">Spanish</option>
                              <option value="fr">French</option>
                              <option value="de">German</option>
                              <option value="ru">Russian</option>
                            </select>
                          </div>

                          <div className="sm:col-span-3">
                            <div className="flex items-center pt-5">
                              <input
                                type="checkbox"
                                name="isTwoFactor"
                                id="isTwoFactor"
                                checked={formData.isTwoFactor || false}
                                onChange={handleInputChange}
                                className={`h-4 w-4 text-indigo-600 focus:ring-indigo-500 rounded ${
                                  darkMode
                                    ? "border-gray-500"
                                    : "border-gray-300"
                                }`}
                              />
                              <label
                                htmlFor="isTwoFactor"
                                className={`ml-2 block text-sm ${
                                  darkMode ? "text-gray-300" : "text-gray-700"
                                }`}
                              >
                                Two Factor Authentication
                              </label>
                            </div>
                            <div className="flex items-center pt-2">
                              <input
                                type="checkbox"
                                name="isMultiDevice"
                                id="isMultiDevice"
                                checked={formData.isMultiDevice || false}
                                onChange={handleInputChange}
                                className={`h-4 w-4 text-indigo-600 focus:ring-indigo-500 rounded ${
                                  darkMode
                                    ? "border-gray-500"
                                    : "border-gray-300"
                                }`}
                              />
                              <label
                                htmlFor="isMultiDevice"
                                className={`ml-2 block text-sm ${
                                  darkMode ? "text-gray-300" : "text-gray-700"
                                }`}
                              >
                                Multi-Device Login
                              </label>
                            </div>
                          </div>
                        </div>
                        <div className="mt-5 sm:mt-6 sm:grid sm:grid-cols-2 sm:gap-3 sm:grid-flow-row-dense">
                          <button
                            type="submit"
                            disabled={isLoading}
                            className="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-indigo-600 text-base font-medium text-white hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:col-start-2 sm:text-sm disabled:opacity-50"
                          >
                            {isLoading ? (
                              <>
                                <i className="fas fa-spinner fa-spin mr-2"></i>{" "}
                                {isEditMode ? "Updating..." : "Creating..."}
                              </>
                            ) : isEditMode ? (
                              "Update User"
                            ) : (
                              "Create User"
                            )}
                          </button>
                          <button
                            type="button"
                            onClick={() => setShowModal(false)}
                            className={`mt-3 w-full inline-flex justify-center rounded-md border shadow-sm px-4 py-2 text-base font-medium focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:mt-0 sm:col-start-1 sm:text-sm ${
                              darkMode
                                ? "bg-gray-600 border-gray-600 text-white hover:bg-gray-500"
                                : "bg-white border-gray-300 text-gray-700 hover:bg-gray-50"
                            }`}
                          >
                            Cancel
                          </button>
                        </div>
                      </form>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
