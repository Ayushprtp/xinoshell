"use client";

import { useMemo, useRef, useState } from "react";
import useSWR from "swr";
import { toast } from "sonner";
import {
  FiDownload,
  FiFile,
  FiImage,
  FiRefreshCw,
  FiSearch,
  FiTrash2,
  FiUpload,
  FiX,
} from "react-icons/fi";
import { Device } from "../../../types/device-types";

type MediaItem = {
  id: string;
  userId: string;
  deviceId: string;
  url: string;
  type: string;
  size: number;
  filename: string;
  caption?: string | null;
  source: string;
  capturedAt?: string | null;
  uploadedAt: string;
};

type MediaResponse = {
  success: boolean;
  items: MediaItem[];
  total?: number;
  page?: number;
  limit?: number;
  totalPages?: number;
  error?: string;
};

type FilterMode = "all" | "gallery" | "files";

const getAuthHeader = (): Record<string, string> => {
  if (typeof window === "undefined") return {};
  try {
    const localData = localStorage.getItem("userData");
    const token = localData ? JSON.parse(localData).token : null;
    return token ? { Authorization: `Bearer ${token}` } : {};
  } catch {
    return {};
  }
};

const fetcher = async (url: string) => {
  const res = await fetch(url, {
    headers: {
      "Content-Type": "application/json",
      ...getAuthHeader(),
    },
  });

  const data = await res.json();
  if (!res.ok) {
    throw new Error(data?.error || data?.message || "Failed to load media");
  }
  return data;
};

const postForm = async (url: string, formData: FormData) => {
  return fetch(url, { method: "POST", body: formData });
};

const formatBytes = (bytes: number) => {
  if (!bytes) return "0 B";
  const units = ["B", "KB", "MB", "GB"];
  const index = Math.min(Math.floor(Math.log(bytes) / Math.log(1024)), units.length - 1);
  return `${(bytes / Math.pow(1024, index)).toFixed(index === 0 ? 0 : 1)} ${units[index]}`;
};

const isImage = (type: string) => type.startsWith("image/");
const isVideo = (type: string) => type.startsWith("video/");

function CaptionEditor({
  item,
  onSave,
}: {
  item: MediaItem;
  onSave: (newCaption: string) => void;
}) {
  const [editing, setEditing] = useState(false);
  const [value, setValue] = useState(item.caption || "");

  if (!editing) {
    return (
      <button
        onClick={() => {
          setValue(item.caption || "");
          setEditing(true);
        }}
        className="px-4 py-2 rounded-lg bg-gray-700 hover:bg-gray-600 text-gray-200 text-sm"
      >
        {item.caption ? "Edit caption" : "Add caption"}
      </button>
    );
  }

  return (
    <div className="flex items-center gap-2 w-full sm:w-auto">
      <input
        value={value}
        onChange={(e) => setValue(e.target.value)}
        placeholder="Caption..."
        className="flex-1 sm:w-64 px-3 py-2 rounded-lg bg-gray-700 text-gray-200 text-sm border border-gray-600 focus:border-indigo-500 focus:outline-none"
      />
      <button
        onClick={() => {
          onSave(value);
          setEditing(false);
        }}
        className="px-3 py-2 rounded-lg bg-indigo-600 hover:bg-indigo-700 text-white text-sm"
      >
        Save
      </button>
      <button
        onClick={() => setEditing(false)}
        className="px-3 py-2 rounded-lg bg-gray-700 hover:bg-gray-600 text-gray-200 text-sm"
      >
        Cancel
      </button>
    </div>
  );
}

export default function GallerySection({ device }: { device: Device }) {
  const [filter, setFilter] = useState<FilterMode>("all");
  const [search, setSearch] = useState("");
  const [selectedItem, setSelectedItem] = useState<MediaItem | null>(null);
  const [isUploading, setIsUploading] = useState(false);
  const fileInputRef = useRef<HTMLInputElement>(null);

  const queryParts = [
    `userId=${encodeURIComponent(device.userId)}`,
    `deviceId=${encodeURIComponent(device.deviceId)}`,
    `limit=200`,
  ];
  const mediaUrl = `/api/client/media?${queryParts.join("&")}`;

  const { data, error, isLoading, mutate } = useSWR<MediaResponse>(mediaUrl, fetcher);
  const items = data?.items || [];

  const filteredItems = useMemo(() => {
    let result = items;
    if (filter === "gallery") {
      result = result.filter((item) => isImage(item.type) || isVideo(item.type));
    } else if (filter === "files") {
      result = result.filter(
        (item) => !isImage(item.type) && !isVideo(item.type)
      );
    }
    if (search.trim()) {
      const q = search.toLowerCase();
      result = result.filter(
        (item) =>
          item.filename.toLowerCase().includes(q) ||
          (item.caption || "").toLowerCase().includes(q)
      );
    }
    return result;
  }, [filter, items, search]);

  const galleryCount = items.filter(
    (item) => isImage(item.type) || isVideo(item.type)
  ).length;
  const filesCount = items.length - galleryCount;

  const getDownloadUrl = (item: MediaItem) =>
    `/api/client/media/${item.id}?userId=${encodeURIComponent(device.userId)}`;

  const getForcedDownloadUrl = (item: MediaItem) =>
    `/api/client/media/${item.id}?userId=${encodeURIComponent(
      device.userId
    )}&download=1`;

  const handleUpload = async (file: File | null) => {
    if (!file) return;

    setIsUploading(true);
    try {
      const formData = new FormData();
      formData.append("file", file);
      formData.append("userId", device.userId);
      formData.append("deviceId", device.deviceId);
      formData.append(
        "source",
        isImage(file.type) || isVideo(file.type) ? "gallery" : "files"
      );
      formData.append("caption", file.name);

      const res = await postForm("/api/client/media", formData);
      const payload = await res.json();

      if (!res.ok) {
        throw new Error(payload?.error || "Upload failed");
      }

      toast.success("File uploaded to media directory");
      await mutate();
    } catch (err) {
      toast.error(err instanceof Error ? err.message : "Upload failed");
    } finally {
      setIsUploading(false);
      if (fileInputRef.current) fileInputRef.current.value = "";
    }
  };

  const handleDelete = async (item: MediaItem) => {
    if (!confirm(`Delete ${item.filename}?`)) return;

    try {
      const res = await fetch(getDownloadUrl(item), {
        method: "DELETE",
        headers: { ...getAuthHeader() },
      });
      const payload = await res.json().catch(() => ({}));

      if (!res.ok) {
        throw new Error(payload?.error || "Delete failed");
      }

      if (selectedItem?.id === item.id) setSelectedItem(null);
      toast.success("File deleted");
      await mutate();
    } catch (err) {
      toast.error(err instanceof Error ? err.message : "Delete failed");
    }
  };

  const handleCaptionEdit = async (item: MediaItem, newCaption: string) => {
    try {
      const res = await fetch(getDownloadUrl(item), {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          ...getAuthHeader(),
        },
        body: JSON.stringify({ caption: newCaption }),
      });
      const payload = await res.json();
      if (!res.ok) {
        throw new Error(payload?.error || "Update failed");
      }
      toast.success("Caption updated");
      await mutate();
    } catch (err) {
      toast.error(err instanceof Error ? err.message : "Update failed");
    }
  };

  return (
    <div className="lg:col-span-3 bg-gray-800 rounded-xl border border-gray-700 overflow-hidden">
      <div className="px-5 py-4 border-b border-gray-700 flex flex-col md:flex-row md:items-center md:justify-between gap-3">
        <div>
          <h2 className="text-lg font-semibold text-white flex items-center gap-2">
            <FiImage className="text-indigo-400" /> Gallery & Files
          </h2>
          <p className="text-xs text-gray-400 mt-1">
            View uploaded pictures, videos, and files for this device.
          </p>
        </div>

        <div className="flex items-center gap-2">
          <button
            onClick={() => mutate()}
            disabled={isLoading}
            className="px-3 py-2 rounded-lg bg-gray-700 text-gray-200 hover:bg-gray-600 disabled:opacity-50 flex items-center gap-2 text-sm"
          >
            <FiRefreshCw className={isLoading ? "animate-spin" : ""} /> Refresh
          </button>
          <button
            onClick={() => fileInputRef.current?.click()}
            disabled={isUploading}
            className="px-3 py-2 rounded-lg bg-indigo-600 text-white hover:bg-indigo-700 disabled:opacity-50 flex items-center gap-2 text-sm"
          >
            <FiUpload /> {isUploading ? "Uploading..." : "Upload File"}
          </button>
          <input
            ref={fileInputRef}
            type="file"
            className="hidden"
            onChange={(e) => handleUpload(e.target.files?.[0] || null)}
          />
        </div>
      </div>

      <div className="px-5 py-3 border-b border-gray-700 flex flex-col md:flex-row md:items-center md:justify-between gap-3">
        <div className="flex flex-wrap gap-2">
          {[
            { key: "all", label: `All (${items.length})` },
            { key: "gallery", label: `Gallery (${galleryCount})` },
            { key: "files", label: `Files (${filesCount})` },
          ].map((tab) => (
            <button
              key={tab.key}
              onClick={() => setFilter(tab.key as FilterMode)}
              className={`px-3 py-1.5 rounded-full text-sm transition-colors ${
                filter === tab.key
                  ? "bg-indigo-600 text-white"
                  : "bg-gray-700 text-gray-300 hover:bg-gray-600"
              }`}
            >
              {tab.label}
            </button>
          ))}
        </div>

        <div className="relative">
          <FiSearch className="absolute left-2.5 top-1/2 -translate-y-1/2 text-gray-400" />
          <input
            type="search"
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            placeholder="Search filename or caption..."
            className="pl-8 pr-3 py-1.5 rounded-lg bg-gray-700 text-gray-200 text-sm border border-gray-600 focus:border-indigo-500 focus:outline-none w-56"
          />
        </div>
      </div>

      <div className="p-5">
        {error && (
          <div className="bg-red-900/30 border border-red-700 text-red-300 rounded-lg p-3 text-sm">
            {error.message}
          </div>
        )}

        {isLoading && (
          <div className="flex items-center justify-center py-12 text-gray-400">
            <FiRefreshCw className="animate-spin mr-2" /> Loading media...
          </div>
        )}

        {!isLoading && !error && filteredItems.length === 0 && (
          <div className="text-center py-12 text-gray-400 border border-dashed border-gray-700 rounded-xl">
            <FiFile className="mx-auto mb-3 text-3xl text-gray-500" />
            <p>No {filter === "all" ? "gallery or files" : filter} items yet.</p>
            <p className="text-xs mt-1">Use Upload File to add files to this device media directory.</p>
          </div>
        )}

        {!isLoading && filteredItems.length > 0 && (
          <div className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-4">
            {filteredItems.map((item) => (
              <div key={item.id} className="bg-gray-900 border border-gray-700 rounded-xl overflow-hidden">
                <button
                  onClick={() => setSelectedItem(item)}
                  className="w-full h-40 bg-gray-950 flex items-center justify-center overflow-hidden"
                >
                  {isImage(item.type) ? (
                    <img
                      src={getDownloadUrl(item)}
                      alt={item.filename}
                      className="w-full h-full object-cover"
                    />
                  ) : isVideo(item.type) ? (
                    <video src={getDownloadUrl(item)} className="w-full h-full object-cover" />
                  ) : (
                    <FiFile className="text-5xl text-indigo-400" />
                  )}
                </button>

                <div className="p-3">
                  <p className="text-sm text-white truncate" title={item.filename}>{item.filename}</p>
                  <p className="text-xs text-gray-400 mt-1">
                    {formatBytes(item.size)} • {new Date(item.uploadedAt).toLocaleString()}
                  </p>
                  <div className="flex gap-2 mt-3">
                    <a
                      href={getForcedDownloadUrl(item)}
                      download={item.filename}
                      className="flex-1 px-2 py-1.5 rounded bg-gray-700 hover:bg-gray-600 text-xs text-center flex items-center justify-center gap-1"
                    >
                      <FiDownload /> Download
                    </a>
                    <button
                      onClick={() => handleDelete(item)}
                      className="px-2 py-1.5 rounded bg-red-900/50 hover:bg-red-900 text-red-200 text-xs flex items-center justify-center"
                    >
                      <FiTrash2 />
                    </button>
                  </div>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      {selectedItem && (
        <div className="fixed inset-0 z-50 bg-black/80 flex items-center justify-center p-4">
          <div className="bg-gray-900 border border-gray-700 rounded-xl max-w-5xl w-full max-h-[90vh] overflow-hidden">
            <div className="px-4 py-3 border-b border-gray-700 flex items-center justify-between">
              <div className="min-w-0">
                <h3 className="text-white font-medium truncate">{selectedItem.filename}</h3>
                <p className="text-xs text-gray-400">{selectedItem.type} • {formatBytes(selectedItem.size)}</p>
              </div>
              <button onClick={() => setSelectedItem(null)} className="p-2 rounded hover:bg-gray-800">
                <FiX />
              </button>
            </div>

            <div className="p-4 max-h-[70vh] overflow-auto flex items-center justify-center bg-black">
              {isImage(selectedItem.type) ? (
                <img src={getDownloadUrl(selectedItem)} alt={selectedItem.filename} className="max-w-full max-h-[65vh] object-contain" />
              ) : isVideo(selectedItem.type) ? (
                <video src={getDownloadUrl(selectedItem)} controls className="max-w-full max-h-[65vh]" />
              ) : (
                <div className="text-center py-16 text-gray-300">
                  <FiFile className="mx-auto text-6xl text-indigo-400 mb-4" />
                  <p>{selectedItem.filename}</p>
                  <p className="text-sm text-gray-500 mt-1">Preview is not available for this file type.</p>
                </div>
              )}
            </div>

            <div className="px-4 py-3 border-t border-gray-700 flex flex-wrap justify-end gap-2">
              <CaptionEditor
                item={selectedItem}
                onSave={(newCaption) => {
                  handleCaptionEdit(selectedItem, newCaption);
                  setSelectedItem({ ...selectedItem, caption: newCaption });
                }}
              />
              <a
                href={getForcedDownloadUrl(selectedItem)}
                download={selectedItem.filename}
                className="px-4 py-2 rounded-lg bg-indigo-600 hover:bg-indigo-700 text-white flex items-center gap-2"
              >
                <FiDownload /> Download
              </a>
              <button
                onClick={() => handleDelete(selectedItem)}
                className="px-4 py-2 rounded-lg bg-red-900/70 hover:bg-red-900 text-red-100 flex items-center gap-2"
              >
                <FiTrash2 /> Delete
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
