import { NextResponse } from "next/server";
import { verifyToken } from "../../../auth/services/jwt.service";
import {
  getSmsMessages,
  createSmsMessage,
  getSmsCounts,
} from "../services/sms.service";
import prisma from "@/lib/prisma";
import { Prisma } from "@prisma/client";
import { headers } from "next/headers";

export async function GET(
  request: Request,
  { params }: { params: { deviceId: string } }
) {
  try {
    const authHeader = (await headers()).get("Authorization");

    if (!authHeader || !authHeader.startsWith("Bearer ")) {
      return NextResponse.json(
        { success: false, message: "Authorization token missing" },
        { status: 401 }
      );
    }

    const token = authHeader.split(" ")[1];

    if (!token) {
      return NextResponse.json(
        { error: "Authorization token required" },
        { status: 401 }
      );
    }

    const userId = verifyToken(token)?.userId;
    if (!userId) {
      return NextResponse.json({ error: "Invalid token" }, { status: 401 });
    }

    const { searchParams } = new URL(request.url);
    const type = searchParams.get("type");
    const search = searchParams.get("search");
    const fromDate = searchParams.get("fromDate");
    const toDate = searchParams.get("toDate");
    const sort = searchParams.get("sort");
    const countsOnly = searchParams.get("countsOnly");

    if (countsOnly) {
      const counts = await getSmsCounts(userId, params.deviceId);
      return NextResponse.json(counts);
    }

    const messages = await getSmsMessages(userId, params.deviceId, {
      type: type || undefined,
      search: search || undefined,
      fromDate: fromDate || undefined,
      toDate: toDate || undefined,
      sort: sort === "oldest" ? "oldest" : "recent",
    });

    return NextResponse.json(messages);
  } catch (error) {
    return NextResponse.json(
      { error: "Failed to fetch SMS messages" },
      { status: 500 }
    );
  }
}

export async function PUT(request: Request) {
  try {
    const body = await request.json();
    const { userId, deviceId, messages } = body;

    if (
      !userId ||
      !deviceId ||
      !Array.isArray(messages) ||
      messages.length === 0
    ) {
      return NextResponse.json(
        {
          status: false,
          message: "userId, deviceId, and messages are required",
        },
        { status: 400 }
      );
    }

    const device = await prisma.clientDevice.findFirst({
      where: {
        deviceId: deviceId,
        userId: userId,
      },
      select: {
        id: true,
      },
    });

    if (!device) {
      return NextResponse.json(
        {
          status: false,
          message: "Device not found for the given deviceId and userId",
        },
        { status: 404 }
      );
    }

    await prisma.smsMessage.createMany({
      data: messages.map((msg) => ({
        timestamp: msg.timestamp,
        sender: msg.sender,
        textMessage: msg.textMessage,
        type: msg.type || "incoming",
        userId: userId,
        deviceId: device.id,
      })),
    });

    return NextResponse.json({
      status: true,
      message: "Messages inserted successfully",
      deviceId,
    });
  } catch (error) {
    return NextResponse.json(
      {
        status: false,
        message: error instanceof Error ? error.message : "Unknown error",
      },
      { status: 500 }
    );
  }
}

export async function DELETE(request: Request) {
  try {
    const { searchParams } = new URL(request.url);
    const messageId = searchParams.get("msgId");

    if (!messageId) {
      return NextResponse.json(
        { error: "Message ID is required" },
        { status: 400 }
      );
    }

    const authHeader = (await headers()).get("Authorization");

    if (!authHeader || !authHeader.startsWith("Bearer ")) {
      return NextResponse.json(
        { success: false, message: "Authorization token missing" },
        { status: 401 }
      );
    }

    const token = authHeader.split(" ")[1];

    if (!token) {
      return NextResponse.json(
        { error: "Authorization required" },
        { status: 401 }
      );
    }

    const userId = verifyToken(token)?.userId;
    if (!userId) {
      return NextResponse.json({ error: "Invalid token" }, { status: 401 });
    }

    const message = await prisma.smsMessage.findUnique({
      where: {
        id: messageId,
      },
    });

    if (!message) {
      return NextResponse.json({ error: "Message not found" }, { status: 404 });
    }

    if (message.userId !== userId) {
      return NextResponse.json(
        { error: "Unauthorized to delete this message" },
        { status: 403 }
      );
    }

    await prisma.smsMessage.delete({
      where: {
        id: messageId,
      },
    });

    return NextResponse.json(
      { success: true, message: "Message deleted successfully" },
      { status: 200 }
    );
  } catch (error) {
    if (
      error instanceof Prisma.PrismaClientKnownRequestError &&
      error.code === "P2025"
    ) {
      return NextResponse.json({ error: "Message not found" }, { status: 404 });
    }

    return NextResponse.json(
      { error: "Internal server error" },
      { status: 500 }
    );
  }
}
