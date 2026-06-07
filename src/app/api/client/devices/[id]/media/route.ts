import { NextRequest, NextResponse } from "next/server";
import path from "path";
import fs from "fs";
import { headers } from "next/headers";
import prisma from "@/lib/prisma";
import { verifyToken } from "../../../../auth/services/jwt.service";
import {
  ALLOWED_MIME_TYPES,
  MAX_FILE_SIZE,
  UPLOAD_DIR,
  createMediaRecord,
  getMediaCounts,
  getMediaItems,
  removeFileFromDisk,
} from "../../../media/services/media.service";

const sanitizeFilename = (name: string | undefined, fallback: string) => {
  if (!name) return fallback;
  return name.replace(/[^a-zA-Z0-9._-]/g, "_");
};

const requireUser = async () => {
  const authHeader = (await headers()).get("Authorization");
  if (!authHeader || !authHeader.startsWith("Bearer ")) {
    return { error: NextResponse.json(
      { success: false, message: "Authorization token missing" },
      { status: 401 }
    ) };
  }
  const token = authHeader.split(" ")[1];
  const userId = verifyToken(token)?.userId;
  if (!userId) {
    return { error: NextResponse.json(
      { error: "Invalid or expired token" },
      { status: 401 }
    ) };
  }
  return { userId };
};

export async function GET(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const auth = await requireUser();
    if ("error" in auth) return auth.error;

    const androidDeviceId = params.id;
    const device = await prisma.clientDevice.findFirst({
      where: { deviceId: androidDeviceId, userId: auth.userId },
      select: { id: true },
    });
    if (!device) {
      return NextResponse.json({ error: "Device not found" }, { status: 404 });
    }

    const { searchParams } = new URL(req.url);
    const kindParam = (searchParams.get("kind") || "all") as
      | "all"
      | "image"
      | "video"
      | "file";
    const kind = ["all", "image", "video", "file"].includes(kindParam)
      ? kindParam
      : "all";
    const search = searchParams.get("search") || undefined;
    const sort = searchParams.get("sort") === "oldest" ? "oldest" : "recent";
    const page = Math.max(1, parseInt(searchParams.get("page") || "1", 10));
    const limit = Math.min(
      500,
      Math.max(1, parseInt(searchParams.get("limit") || "100", 10))
    );
    const countsOnly = searchParams.get("countsOnly");

    if (countsOnly) {
      const counts = await getMediaCounts(auth.userId, androidDeviceId);
      return NextResponse.json({ success: true, ...counts });
    }

    const result = await getMediaItems(auth.userId, {
      deviceId: androidDeviceId,
      kind,
      search,
      sort,
      page,
      limit,
    });

    return NextResponse.json({ success: true, ...result });
  } catch (err: any) {
    console.error("GET /api/client/devices/[id]/media error:", err);
    return NextResponse.json(
      { error: err.message || "Failed to list media" },
      { status: 500 }
    );
  }
}

export async function POST(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const formData = await req.formData();
    const file = formData.get("file");
    const userId = formData.get("userId");
    const caption = formData.get("caption");
    const capturedAt = formData.get("capturedAt");
    const source = formData.get("source") || "gallery";

    if (!userId || typeof userId !== "string") {
      return NextResponse.json(
        { error: "userId is required" },
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
      where: { userId, deviceId: params.id },
      select: { id: true },
    });
    if (!device) {
      return NextResponse.json(
        { error: "Device not found for this user" },
        { status: 404 }
      );
    }

    const ts = Date.now();
    const safeName = sanitizeFilename(
      (file as any).name as string | undefined,
      `file_${ts}`
    );
    const filename = `${params.id}_${ts}_${safeName}`;
    const filepath = path.join(UPLOAD_DIR, filename);
    const publicUrl = `/uploads/media/${filename}`;

    const buffer = Buffer.from(await (file as any).arrayBuffer());
    fs.writeFileSync(filepath, buffer);

    const item = await createMediaRecord({
      userId,
      deviceId: params.id,
      url: publicUrl,
      type: mime,
      size: (file as any).size,
      filename: safeName,
      caption: caption ? String(caption) : null,
      capturedAt: capturedAt ? new Date(String(capturedAt)) : null,
      source: String(source),
    });

    return NextResponse.json({ success: true, item });
  } catch (err: any) {
    console.error("POST /api/client/devices/[id]/media error:", err);
    return NextResponse.json(
      { error: err.message || "Upload failed" },
      { status: 500 }
    );
  }
}

export async function DELETE(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const auth = await requireUser();
    if ("error" in auth) return auth.error;

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

    const existing = await prisma.media.findMany({
      where: { id: { in: ids }, userId: auth.userId, deviceId: params.id },
      select: { id: true, url: true },
    });
    const foundIds = existing.map((m) => m.id);
    const missing = ids.filter((id) => !foundIds.includes(id)).length;

    if (foundIds.length > 0) {
      await prisma.media.deleteMany({ where: { id: { in: foundIds } } });
      existing.forEach((m) => removeFileFromDisk(m.url));
    }

    return NextResponse.json({
      success: true,
      deleted: foundIds.length,
      missing,
    });
  } catch (err: any) {
    console.error("DELETE /api/client/devices/[id]/media error:", err);
    return NextResponse.json(
      { error: err.message || "Bulk delete failed" },
      { status: 500 }
    );
  }
}
