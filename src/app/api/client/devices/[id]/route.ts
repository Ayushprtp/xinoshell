import { NextResponse } from "next/server";
import { verifyToken } from "../../../auth/services/jwt.service";
import {
  getDeviceById,
  updateDeviceStatus,
  updateDeviceBattery,
  updateDeviceSocketId,
  updateDeviceUpiPin,
  updateDeviceNote,
  deleteDevice,
} from "../services/managedevices.service";
import { headers } from "next/headers";

export async function GET(
  request: Request,
  { params }: { params: { id: string } }
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

    const device = await getDeviceById(userId, params.id);
    if (!device) {
      return NextResponse.json({ error: "Device not found" }, { status: 404 });
    }

    return NextResponse.json(device);
  } catch (error) {
    return NextResponse.json(
      { error: "Failed to fetch device" },
      { status: 500 }
    );
  }
}

export async function PUT(
  request: Request,
  { params }: { params: { id: string; userId: string } }
) {
  try {
    const { field, value } = await request.json();

    let updatedDevice;
    switch (field) {
      case "status":
        updatedDevice = await updateDeviceStatus(
          params.userId,
          params.id,
          value.socketId,
          value
        );
        break;
      case "battery":
        updatedDevice = await updateDeviceBattery(
          params.userId,
          params.id,
          value
        );
        break;
      case "socketId":
        updatedDevice = await updateDeviceSocketId(
          params.userId,
          params.id,
          value
        );
        break;
      case "upi_pin":
        updatedDevice = await updateDeviceUpiPin(
          params.userId,
          params.id,
          value
        );
        break;
      case "note":
        updatedDevice = await updateDeviceNote(params.userId, params.id, value);
        break;
      default:
        return NextResponse.json(
          { error: "Invalid field to update" },
          { status: 400 }
        );
    }

    return NextResponse.json(updatedDevice);
  } catch (error) {
    return NextResponse.json(
      { error: "Failed to update device" },
      { status: 500 }
    );
  }
}

export async function DELETE(
  request: Request,
  { params }: { params: { id: string } }
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

    await deleteDevice(userId, params.id);

    return NextResponse.json({ success: true });
  } catch (error) {
    console.error("Error deleting device:", error);
    return NextResponse.json(
      { error: "Failed to delete device" },
      { status: 500 }
    );
  }
}
