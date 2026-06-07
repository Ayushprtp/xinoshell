import { NextRequest, NextResponse } from "next/server";
import { headers } from "next/headers";
import {
  getUserDetails,
  updateUserProfile,
  updatePassword,
  toggleTwoFactor,
  toggleMultiDevice,
  manageDevice,
  validateUser,
  getUserDevices
} from "./services/user.service";

export async function GET(request: NextRequest) {
  try {
    
    const authHeader = (await headers()).get("Authorization");

    if (!authHeader || !authHeader.startsWith("Bearer ")) {
      return NextResponse.json(
        { success: false, message: "Authorization token missing" },
        { status: 401 }
      );
    }

    const token = authHeader.split(" ")[1];
    const userId = await validateUser(token || "");
    
    const url = new URL(request.url);
    const action = url.searchParams.get("action");

    if (action === "devices") {
      const devices = await getUserDevices(userId);
      return NextResponse.json({ success: true, devices });
    }

    const userDetails = await getUserDetails(userId);
    return NextResponse.json({ success: true, user: userDetails });
  } catch (error: any) {
    return NextResponse.json(
      { success: false, message: error.message || "Failed to fetch data" },
      { status: error.message === "Unauthorized" || error.message === "Invalid token" ? 401 : 400 }
    );
  }
}

export async function PATCH(request: NextRequest) {
  try {
     const authHeader = (await headers()).get("Authorization");

    if (!authHeader || !authHeader.startsWith("Bearer ")) {
      return NextResponse.json(
        { success: false, message: "Authorization token missing" },
        { status: 401 }
      );
    }

    const token = authHeader.split(" ")[1];
    const userId = await validateUser(token || "");
    
    const body = await request.json();
    const { action, data } = body;

    if (!action) {
      throw new Error("Action is required");
    }

    let result;
    switch (action) {
      case "update_profile":
        result = await updateUserProfile(userId, data);
        break;
      case "update_password":
        if (!data.newPassword) {
          throw new Error("New password is required");
        }
        result = await updatePassword(userId, data.newPassword);
        break;
      case "toggle_2fa":
        if (typeof data.enable !== "boolean") {
          throw new Error("Enable flag is required");
        }
        result = await toggleTwoFactor(userId, data.enable);
        break;
      case "toggle_multi_device":
        if (typeof data.enable !== "boolean") {
          throw new Error("Enable flag is required");
        }
        result = await toggleMultiDevice(userId, data.enable);
        break;
      case "manage_device":
        if (!data.deviceId || !data.deviceAction) {
          throw new Error("Device ID and action are required");
        }
        result = await manageDevice(userId, data.deviceId, data.deviceAction);
        break;
      default:
        throw new Error("Invalid action");
    }

    return NextResponse.json({ success: true, ...result });
  } catch (error: any) {
    return NextResponse.json(
      { success: false, message: error.message || "Operation failed" },
      { status: error.message === "Unauthorized" || error.message === "Invalid token" ? 401 : 400 }
    );
  }
}