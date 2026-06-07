import prisma from "@/lib/prisma";
import { NextResponse } from "next/server";

export async function DELETE(request: Request) {
  try {
    const cutoff = new Date(Date.now() - 24 * 60 * 60 * 1000);
    await prisma.tempDevice.deleteMany({
      where: { connectedAt: { lt: cutoff } }
    });
    return NextResponse.json({ success: true });
  } catch (error) {
    return NextResponse.json(
      { error: "Failed to clean temp devices" },
      { status: 500 }
    );
  }
}