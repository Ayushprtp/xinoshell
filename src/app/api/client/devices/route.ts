import { NextResponse } from "next/server";
import { verifyToken } from "../../auth/services/jwt.service";
import {
  getDevices,
  getDeviceCounts,
  upsertDevice,
  getDeviceAnalytics,
} from "./services/managedevices.service";
import { headers } from "next/headers";

export async function GET(request: Request) {
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
    const status = searchParams.get("status");
    const hasUpiPin = searchParams.get("hasUpiPin");
    const sort = searchParams.get("sort");
    const search = searchParams.get("search");
    const page = parseInt(searchParams.get("page") || "1");
    const limit = parseInt(searchParams.get("limit") || "20");
    const date = searchParams.get("date");
    const countsOnly = searchParams.get("countsOnly");
    const analytics = searchParams.get("analytics");
    const timeRange = searchParams.get("timeRange");

    if (countsOnly) {
      const counts = await getDeviceCounts(userId);
      return NextResponse.json(counts);
    }

    if (analytics) {
      const analyticsData = await getDeviceAnalytics(
        userId,
        timeRange || "1day"
      );
      return NextResponse.json(analyticsData);
    }

    const devices = await getDevices(userId, {
      status: status ? status === "true" : undefined,
      hasUpiPin: hasUpiPin ? hasUpiPin === "true" : undefined,
      sort: sort === "oldest" ? "oldest" : "recent",
      search: search || undefined,
      page,
      limit,
      date: date || undefined,
    });

    return NextResponse.json(devices);
  } catch (error) {
    return NextResponse.json(
      { error: "Failed to fetch devices" },
      { status: 500 }
    );
  }
}

export async function POST(request: Request) {
  try {
    const deviceData = await request.json();
    const device = await upsertDevice(deviceData.userId, deviceData);

    return NextResponse.json(device);
  } catch (error) {
    return NextResponse.json(
      { error: "Failed to upsert device" },
      { status: 500 }
    );
  }
}
