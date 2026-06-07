import prisma from "@/lib/prisma";
import { Prisma, Media } from "@prisma/client";
import fs from "fs";
import path from "path";

export const UPLOAD_DIR = path.join(process.cwd(), "public/uploads/media");

export const ALLOWED_MIME_TYPES = [
  "image/jpeg",
  "image/png",
  "image/gif",
  "image/webp",
  "image/bmp",
  "video/mp4",
  "video/3gpp",
  "application/pdf",
  "text/plain",
  "application/zip",
  "application/octet-stream",
];

export const MAX_FILE_SIZE = 100 * 1024 * 1024;

if (!fs.existsSync(UPLOAD_DIR)) {
  fs.mkdirSync(UPLOAD_DIR, { recursive: true });
}

export type MediaKind = "all" | "image" | "video" | "file";

export type MediaFilters = {
  deviceId?: string;
  source?: string;
  kind?: MediaKind;
  search?: string;
  fromDate?: string;
  toDate?: string;
  sort?: "recent" | "oldest";
  page?: number;
  limit?: number;
};

const kindPredicate = (kind: MediaKind) => {
  switch (kind) {
    case "image":
      return { type: { startsWith: "image/" } };
    case "video":
      return { type: { startsWith: "video/" } };
    case "file":
      return {
        AND: [
          { NOT: { type: { startsWith: "image/" } } },
          { NOT: { type: { startsWith: "video/" } } },
        ],
      };
    default:
      return {};
  }
};

export const getMediaItems = async (userId: string, filters: MediaFilters) => {
  const {
    deviceId,
    source,
    kind = "all",
    search,
    fromDate,
    toDate,
    sort = "recent",
    page = 1,
    limit = 100,
  } = filters;

  const where: Prisma.MediaWhereInput = { userId };

  if (deviceId) where.deviceId = deviceId;
  if (source) where.source = source;

  const kindFilter = kindPredicate(kind);
  if (Object.keys(kindFilter).length > 0) {
    Object.assign(where, kindFilter);
  }

  if (search) {
    where.OR = [
      { filename: { contains: search, mode: "insensitive" } },
      { caption: { contains: search, mode: "insensitive" } },
    ];
  }

  if (fromDate || toDate) {
    where.uploadedAt = {};
    if (fromDate) where.uploadedAt.gte = new Date(fromDate);
    if (toDate) where.uploadedAt.lte = new Date(toDate);
  }

  const orderBy: Prisma.MediaOrderByWithRelationInput = {
    uploadedAt: sort === "recent" ? "desc" : "asc",
  };

  const skip = Math.max(0, (page - 1) * limit);

  const [items, total] = await Promise.all([
    prisma.media.findMany({ where, orderBy, skip, take: limit }),
    prisma.media.count({ where }),
  ]);

  return {
    items,
    total,
    page,
    limit,
    totalPages: Math.max(1, Math.ceil(total / limit)),
  };
};

export const getMediaById = async (userId: string, id: string) => {
  return prisma.media.findFirst({ where: { id, userId } });
};

export const getMediaCounts = async (userId: string, deviceId?: string) => {
  const baseWhere: Prisma.MediaWhereInput = { userId };
  if (deviceId) baseWhere.deviceId = deviceId;

  const [total, images, videos, files, gallery, sizeAgg] = await Promise.all([
    prisma.media.count({ where: baseWhere }),
    prisma.media.count({
      where: { ...baseWhere, type: { startsWith: "image/" } },
    }),
    prisma.media.count({
      where: { ...baseWhere, type: { startsWith: "video/" } },
    }),
    prisma.media.count({
      where: {
        ...baseWhere,
        AND: [
          { NOT: { type: { startsWith: "image/" } } },
          { NOT: { type: { startsWith: "video/" } } },
        ],
      },
    }),
    prisma.media.count({
      where: {
        ...baseWhere,
        OR: [
          { type: { startsWith: "image/" } },
          { type: { startsWith: "video/" } },
        ],
      },
    }),
    prisma.media.aggregate({
      where: baseWhere,
      _sum: { size: true },
    }),
  ]);

  return {
    total,
    images,
    videos,
    files,
    gallery,
    totalSize: sizeAgg._sum.size ?? 0,
  };
};

export type CreateMediaInput = Omit<
  Media,
  "id" | "userId" | "uploadedAt"
> & {
  userId: string;
};

export const createMediaRecord = async (input: CreateMediaInput) => {
  return prisma.media.create({ data: input });
};

export const updateMediaMetadata = async (
  userId: string,
  id: string,
  data: { caption?: string | null; source?: string }
) => {
  const existing = await prisma.media.findFirst({ where: { id, userId } });
  if (!existing) return null;

  return prisma.media.update({
    where: { id },
    data: {
      ...(data.caption !== undefined ? { caption: data.caption } : {}),
      ...(data.source ? { source: data.source } : {}),
    },
  });
};

export const deleteMediaRecord = async (userId: string, id: string) => {
  const existing = await prisma.media.findFirst({
    where: { id, userId },
    select: { id: true, url: true },
  });
  if (!existing) return null;

  await prisma.media.delete({ where: { id } });
  removeFileFromDisk(existing.url);
  return existing;
};

export const deleteMediaBulk = async (userId: string, ids: string[]) => {
  if (!ids.length) return { deleted: 0, missing: 0 };

  const existing = await prisma.media.findMany({
    where: { id: { in: ids }, userId },
    select: { id: true, url: true },
  });

  const foundIds = existing.map((m) => m.id);
  const missing = ids.filter((id) => !foundIds.includes(id)).length;

  if (foundIds.length === 0) {
    return { deleted: 0, missing };
  }

  await prisma.media.deleteMany({ where: { id: { in: foundIds } } });
  existing.forEach((m) => removeFileFromDisk(m.url));

  return { deleted: foundIds.length, missing };
};

export const removeFileFromDisk = (url: string) => {
  const filename = url.split("/").pop();
  if (!filename) return;
  const filepath = path.join(UPLOAD_DIR, filename);
  if (fs.existsSync(filepath)) {
    try {
      fs.unlinkSync(filepath);
    } catch {
      // ignore unlink errors
    }
  }
};

export const resolveMediaFile = (item: { url: string; type: string; size: number; filename: string }) => {
  const filename = item.url.split("/").pop();
  if (!filename) return { error: "INVALID_URL" as const };
  const filepath = path.join(UPLOAD_DIR, filename);
  if (!fs.existsSync(filepath)) return { error: "FILE_MISSING" as const };
  return { filepath, filename };
};
