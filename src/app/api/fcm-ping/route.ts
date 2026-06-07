import admin from "firebase-admin";
import { StatusCodes } from "http-status-codes";
import path from "path";
import { readFile } from "fs/promises";
import { NextResponse } from "next/server";
import prisma from "@/lib/prisma";

const SERVICE_ACCOUNT_PATH = path.join(
  process.cwd(),
  "firebase_service_account.json"
);

type FcmMessagePayload = {
  token: string;
  notification?: {
    title: string;
    body: string;
    imageUrl?: string;
  };
  data?: Record<string, string>;
  android?: {
    priority?: "normal" | "high";
    ttl?: number;
    notification?: {
      channel_id?: string;
      icon?: string;
      color?: string;
    };
  };
  apns?: {
    headers?: Record<string, string>;
    payload?: {
      aps: {
        "mutable-content"?: number;
        "content-available"?: number;
      };
    };
  };
};

let firebaseInitialized = false;

async function initializeFirebase() {
  if (firebaseInitialized) return;

  try {
    const serviceAccount = JSON.parse(
      await readFile(SERVICE_ACCOUNT_PATH, "utf8")
    );

    admin.initializeApp({
      credential: admin.credential.cert(serviceAccount),
    });

    firebaseInitialized = true;
  } catch (error) {
    console.error("Failed to initialize Firebase:", error);
    throw error;
  }
}

export async function POST(request: Request) {
  try {
    await initializeFirebase();
  } catch (error) {
    return NextResponse.json(
      {
        status: "error",
        message: "Failed to initialize Firebase service",
      },
      { status: StatusCodes.INTERNAL_SERVER_ERROR }
    );
  }

  try {
    const { token, title, body } = await request.json();

    if (!token || !title || !body) {
      return NextResponse.json(
        { error: "Missing required fields: token, title, or body" },
        { status: 400 }
      );
    }

    const message = {
      token,
      notification: {
        title,
        body,
      },
    };

    const response = await admin.messaging().send(message);

    return NextResponse.json(
      {
        status: "success",
        message: "Message sent successfully",
        data: {
          messageId: response,
          fcmToken: token,
        },
      },
      { status: StatusCodes.OK }
    );
  } catch (error: any) {
    console.error("Error sending FCM message:", error);

    const errorResponse = {
      status: "error",
      message: "Failed to send FCM message",
      details:
        process.env.NODE_ENV === "development" ? error.message : undefined,
      code: error.code,
    };

    // Handle specific FCM errors
    if (
      error.code === "messaging/invalid-registration-token" ||
      error.code === "messaging/registration-token-not-registered"
    ) {
      return NextResponse.json(
        {
          ...errorResponse,
          message: "Invalid or unregistered device token",
        },
        { status: StatusCodes.BAD_REQUEST }
      );
    }

    return NextResponse.json(errorResponse, {
      status: StatusCodes.INTERNAL_SERVER_ERROR,
    });
  }
}

export async function PATCH(request: Request) {
  try {
    await initializeFirebase();
  } catch (error) {
    return NextResponse.json(
      {
        status: "error",
        message: "Failed to initialize Firebase service",
      },
      { status: StatusCodes.INTERNAL_SERVER_ERROR }
    );
  }

  try {
    const { userId, deviceId, fcmToken } = await request.json();

    if (!userId || !deviceId || !fcmToken) {
      return NextResponse.json(
        {
          status: "error",
          message: "Missing required fields: userId, deviceId, or fcmToken",
        },
        { status: StatusCodes.BAD_REQUEST }
      );
    }

    const user = await prisma.user.findUnique({
      where: { id: userId },
    });

    if (!user) {
      return NextResponse.json(
        {
          status: "error",
          message: "User not found",
        },
        { status: StatusCodes.NOT_FOUND }
      );
    }

    const updatedDevice = await prisma.clientDevice.update({
      where: {
        deviceId: deviceId,
        userId: userId,
      },
      data: {
        FCM_Token: fcmToken,
        lastSeen: new Date(),
      },
    });

    return NextResponse.json(
      {
        status: "success",
        message: "FCM token updated successfully",
        data: {
          deviceId: updatedDevice.deviceId,
          fcmToken: updatedDevice.FCM_Token,
        },
      },
      { status: StatusCodes.OK }
    );
  } catch (error: any) {
    console.error("Error updating FCM token:", error);

    const errorResponse = {
      status: "error",
      message: "Failed to update FCM token",
      details:
        process.env.NODE_ENV === "development" ? error.message : undefined,
    };

    if (error.code === "P2025") {
      return NextResponse.json(
        {
          ...errorResponse,
          message: "Device not found for this user",
        },
        { status: StatusCodes.NOT_FOUND }
      );
    }

    return NextResponse.json(errorResponse, {
      status: StatusCodes.INTERNAL_SERVER_ERROR,
    });
  }
}
