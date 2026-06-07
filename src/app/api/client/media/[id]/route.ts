import { NextRequest, NextResponse } from "next/server";
import fs from "fs";
import { headers } from "next/headers";
import { verifyToken } from "../../../auth/services/jwt.service";
import {
  deleteMediaRecord,
  getMediaById,
  resolveMediaFile,
  updateMediaMetadata,
} from "../services/media.service";

const requireUser = async (req: NextRequest) => {
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
    const auth = await requireUser(req);
    if ("error" in auth) return auth.error;

    const { searchParams } = new URL(req.url);
    const download = searchParams.get("download") === "1";

    const item = await getMediaById(auth.userId, params.id);
    if (!item) {
      return NextResponse.json({ error: "Media not found" }, { status: 404 });
    }

    const resolved = resolveMediaFile(item);
    if ("error" in resolved) {
      if (resolved.error === "FILE_MISSING") {
        return NextResponse.json(
          { error: "File not on disk" },
          { status: 410 }
        );
      }
      return NextResponse.json(
        { error: "Invalid media URL" },
        { status: 400 }
      );
    }

    const stat = fs.statSync(resolved.filepath);
    const totalSize = stat.size;
    const range = req.headers.get("range");

    if (range) {
      const match = /bytes=(\d*)-(\d*)/.exec(range);
      if (match) {
        const start = match[1] ? parseInt(match[1], 10) : 0;
        const end = match[2]
          ? Math.min(parseInt(match[2], 10), totalSize - 1)
          : totalSize - 1;
        if (start >= totalSize || end < start) {
          return new NextResponse(null, {
            status: 416,
            headers: { "Content-Range": `bytes */${totalSize}` },
          });
        }
        const stream = fs.createReadStream(resolved.filepath, { start, end });
        const chunks: Buffer[] = [];
        for await (const chunk of stream) {
          chunks.push(typeof chunk === "string" ? Buffer.from(chunk) : (chunk as Buffer));
        }
        const data = Buffer.concat(chunks);
        return new NextResponse(data, {
          status: 206,
          headers: {
            "Content-Type": item.type,
            "Content-Length": String(end - start + 1),
            "Content-Range": `bytes ${start}-${end}/${totalSize}`,
            "Content-Disposition": download
              ? `attachment; filename="${item.filename}"`
              : `inline; filename="${item.filename}"`,
            "Accept-Ranges": "bytes",
            "Cache-Control": "private, max-age=3600",
          },
        });
      }
    }

    const data = fs.readFileSync(resolved.filepath);
    return new NextResponse(data, {
      status: 200,
      headers: {
        "Content-Type": item.type,
        "Content-Length": String(totalSize),
        "Content-Disposition": download
          ? `attachment; filename="${item.filename}"`
          : `inline; filename="${item.filename}"`,
        "Accept-Ranges": "bytes",
        "Cache-Control": "private, max-age=3600",
      },
    });
  } catch (err: any) {
    console.error("GET /api/client/media/[id] error:", err);
    return NextResponse.json(
      { error: err.message || "Download failed" },
      { status: 500 }
    );
  }
}

export async function HEAD(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const auth = await requireUser(req);
    if ("error" in auth) return auth.error;

    const item = await getMediaById(auth.userId, params.id);
    if (!item) return new NextResponse(null, { status: 404 });

    const resolved = resolveMediaFile(item);
    if ("error" in resolved) {
      if (resolved.error === "FILE_MISSING") {
        return new NextResponse(null, { status: 410 });
      }
      return new NextResponse(null, { status: 400 });
    }

    const stat = fs.statSync(resolved.filepath);
    return new NextResponse(null, {
      status: 200,
      headers: {
        "Content-Type": item.type,
        "Content-Length": String(stat.size),
        "Accept-Ranges": "bytes",
      },
    });
  } catch (err: any) {
    console.error("HEAD /api/client/media/[id] error:", err);
    return new NextResponse(null, { status: 500 });
  }
}

export async function PATCH(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const auth = await requireUser(req);
    if ("error" in auth) return auth.error;

    const body = await req.json().catch(() => ({}));
    const { caption, source } = body || {};

    if (caption === undefined && source === undefined) {
      return NextResponse.json(
        { error: "Provide caption and/or source to update" },
        { status: 400 }
      );
    }

    const update: { caption?: string | null; source?: string } = {};
    if (caption !== undefined) {
      update.caption =
        caption === null || caption === "" ? null : String(caption);
    }
    if (source !== undefined) {
      update.source = String(source);
    }

    const updated = await updateMediaMetadata(auth.userId, params.id, update);
    if (!updated) {
      return NextResponse.json({ error: "Media not found" }, { status: 404 });
    }

    return NextResponse.json({ success: true, item: updated });
  } catch (err: any) {
    console.error("PATCH /api/client/media/[id] error:", err);
    return NextResponse.json(
      { error: err.message || "Update failed" },
      { status: 500 }
    );
  }
}

export async function DELETE(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const auth = await requireUser(req);
    if ("error" in auth) return auth.error;

    const result = await deleteMediaRecord(auth.userId, params.id);
    if (!result) {
      return NextResponse.json({ error: "Media not found" }, { status: 404 });
    }

    return NextResponse.json({ success: true });
  } catch (err: any) {
    console.error("DELETE /api/client/media/[id] error:", err);
    return NextResponse.json(
      { error: err.message || "Delete failed" },
      { status: 500 }
    );
  }
}
