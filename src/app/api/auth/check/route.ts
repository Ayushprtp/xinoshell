import { NextResponse } from "next/server";
import { headers } from "next/headers";
import { verifyToken } from "../services/jwt.service";
import prisma from "@/lib/prisma";

export async function GET() {
  const authHeader = (await headers()).get("Authorization");
  
  if (!authHeader || !authHeader.startsWith("Bearer ")) {
    return NextResponse.json(
      { success: false, message: "Authorization token missing" },
      { status: 401 }
    );
  }

  const token = authHeader.split(" ")[1];

  try {
    const decoded = verifyToken(token);
    if (!decoded?.userId) {
      return NextResponse.json(
        { success: false, message: "Invalid token" },
        { status: 401 }
      );
    }

    const user = await prisma.user.findUnique({
      where: { id: decoded.userId },
      select: {
        id: true,
        name: true,
        username: true,
        tg_username: true,
        lang: true,
        isMultiDevice: true,
      },
    });

    if (!user) {
      return NextResponse.json(
        { success: false, message: "User not found" },
        { status: 404 }
      );
    }

    return NextResponse.json({ success: true, user });
  } catch (error) {
    return NextResponse.json(
      { success: false, message: "Invalid token" },
      { status: 401 }
    );
  }
}