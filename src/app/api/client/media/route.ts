import { NextRequest, NextResponse } from "next/server";
import path from "path";
import fs from "fs";
import { headers } from "next/headers";
import prisma from "@/lib/prisma";
import { verifyToken } from "../../auth/services/jwt.service";
import {
  ALLOWED_MIME_TYPES,
  MAX_FILE_SIZE,
  MediaKind,
  UPLOAD_DIR,
  createMediaRecord,
  deleteMediaBulk,
  getMediaCounts,
  getMediaItems,
} from "./services/media.service";
const sanitizeFilename = (name: string | undefined, fallback: string) => {
  if (!name) return fallback;
  return name.replace(/[^a-zA-Z0-9._-]/g, "_");
};

const inferSource = (mime: string): string => {
  if (mime.startsWith("image/") || mime.startsWith("video/")) return "gallery";
  return "files";
};

export async function GET(req: NextRequest) {
  try {
    const authHeader = (await headers()).get("Authorization");
    if (!authHeader || !authHeader.startsWith("Bearer ")) {
      return NextResponse.json(
        { success: false, message: "Authorization token missing" },
        { status: 401 }
      );
    }
    const token = authHeader.split(" ")[1];
    const userId = verifyToken(token)?.userId;
    if (!userId) {
      return NextResponse.json(
        { error: "Invalid or expired token" },
        { status: 401 }
      );
    }

    const { searchParams } = new URL(req.url);
    const deviceId = searchParams.get("deviceId") || undefined;
    const source = searchParams.get("source") || undefined;
    const kindParam = (searchParams.get("kind") || "all") as MediaKind;
    const kind: MediaKind = ["all", "image", "video", "file"].includes(kindParam)
      ? kindParam
      : "all";
    const search = searchParams.get("search") || undefined;
    const fromDate = searchParams.get("fromDate") || undefined;
    const toDate = searchParams.get("toDate") || undefined;
    const sortParam = searchParams.get("sort");
    const sort: "recent" | "oldest" = sortParam === "oldest" ? "oldest" : "recent";
    const page = Math.max(1, parseInt(searchParams.get("page") || "1", 10));
    const limit = Math.min(
      500,
      Math.max(1, parseInt(searchParams.get("limit") || "100", 10))
    );
    const countsOnly = searchParams.get("countsOnly");

    if (countsOnly) {
      const counts = await getMediaCounts(userId, deviceId);
      return NextResponse.json({ success: true, ...counts });
    }

    const result = await getMediaItems(userId, {
      deviceId,
      source,
      kind,
      search,
      fromDate,
      toDate,
      sort,
      page,
      limit,
    });

    return NextResponse.json({ success: true, ...result });
  } catch (err: any) {
    console.error("GET /api/client/media error:", err);
    return NextResponse.json(
      { error: err.message || "Failed to list media" },
      { status: 500 }
    );
  }
}

export async function POST(req: NextRequest) {
  try {
    const formData = await req.formData();
    const file = formData.get("file");
    const userId = formData.get("userId");
    const deviceId = formData.get("deviceId");
    const caption = formData.get("caption");
    const capturedAt = formData.get("capturedAt");
    const source = formData.get("source") || "gallery";

    if (!userId || typeof userId !== "string") {
      return NextResponse.json(
        { error: "userId is required" },
        { status: 400 }
      );
    }
    if (!deviceId || typeof deviceId !== "string") {
      return NextResponse.json(
        { error: "deviceId is required" },
        { status: 400 }
      );
    }
    if (!file || typeof file === "string") {
      return NextResponse.json(
        { error: "No file uploaded" },
        { status: 400 }
      );
    }

    if ((file as any).size > MAX_FILE_SIZE) {
      return NextResponse.json(
        { error: `File too large. Max ${MAX_FILE_SIZE / 1024 / 1024}MB` },
        { status: 413 }
      );
    }

    const mime = (file as any).type || "application/octet-stream";
    if (!ALLOWED_MIME_TYPES.includes(mime)) {
      return NextResponse.json(
        { error: `Unsupported file type: ${mime}` },
        { status: 415 }
      );
    }

    const device = await prisma.clientDevice.findFirst({
      where: { userId, deviceId },
      select: { id: true },
    });
    if (!device) {
      return NextResponse.json(
        { error: "Device not found for this user" },
        { status: 404 }
      );
    }

    const ts = Date.now();
    const originalName = (file as any).name as string | undefined;
    const safeName = sanitizeFilename(originalName, `file_${ts}`);
    const filename = `${deviceId}_${ts}_${safeName}`;
    const filepath = path.join(UPLOAD_DIR, filename);
    const publicUrl = `/uploads/media/${filename}`;

    const buffer = Buffer.from(await (file as any).arrayBuffer());
    fs.writeFileSync(filepath, buffer);

    const item = await createMediaRecord({
      userId,
      deviceId,
      url: publicUrl,
      type: mime,
      size: (file as any).size,
      filename: safeName,
      caption: caption ? String(caption) : null,
      capturedAt: capturedAt ? new Date(String(capturedAt)) : null,
      source: String(source) || inferSource(mime),
    });

    return NextResponse.json({ success: true, item });
  } catch (err: any) {
    console.error("POST /api/client/media error:", err);
    return NextResponse.json(
      { error: err.message || "Upload failed" },
      { status: 500 }
    );
  }
}

export async function DELETE(req: NextRequest) {
  try {
    const authHeader = (await headers()).get("Authorization");
    if (!authHeader || !authHeader.startsWith("Bearer ")) {
      return NextResponse.json(
        { success: false, message: "Authorization token missing" },
        { status: 401 }
      );
    }
    const token = authHeader.split(" ")[1];
    const userId = verifyToken(token)?.userId;
    if (!userId) {
      return NextResponse.json(
        { error: "Invalid or expired token" },
        { status: 401 }
      );
    }

    const { searchParams } = new URL(req.url);
    const idsParam = searchParams.get("ids");
    const ids = idsParam
      ? idsParam.split(",").map((id) => id.trim()).filter(Boolean)
      : [];

    if (ids.length === 0) {
      return NextResponse.json(
        { error: "Provide at least one id via ?ids=a,b,c" },
        { status: 400 }
      );
    }

    const result = await deleteMediaBulk(userId, ids);
    return NextResponse.json({ success: true, ...result });
  } catch (err: any) {
    console.error("DELETE /api/client/media error:", err);
    return NextResponse.json(
      { error: err.message || "Bulk delete failed" },
      { status: 500 }
    );
  }
}
