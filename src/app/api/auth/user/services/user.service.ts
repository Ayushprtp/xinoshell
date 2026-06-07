import prisma from "@/lib/prisma";
import { verifyToken } from "../../services/jwt.service";

export const getUserDetails = async (userId: string) => {
  try {
    const user = await prisma.user.findUnique({
      where: { id: userId },
      include: {
        user_devices: true
      }
    });

    if (!user) {
      throw new Error("User not found");
    }

    return user;
  } catch (error) {
    throw error;
  }
};

export const updateUserProfile = async (userId: string, data: {
  username?: string;
  name?: string;
  lang?: string;
}) => {
  try {
    const updatedUser = await prisma.user.update({
      where: { id: userId },
      data,
      select: {
        id: true,
        username: true,
        name: true,
        lang: true,
        tg_username: true
      }
    });
    return updatedUser;
  } catch (error) {
    throw error;
  }
};

export const updatePassword = async (userId: string, newPassword: string) => {
  try {
    await prisma.user.update({
      where: { id: userId },
      data: { password: newPassword }
    });
    return { success: true };
  } catch (error) {
    throw error;
  }
};

export const toggleTwoFactor = async (userId: string, enable: boolean) => {
  try {
    await prisma.user.update({
      where: { id: userId },
      data: { isTwoFactor: enable }
    });
    return { success: true };
  } catch (error) {
    throw error;
  }
};

export const toggleMultiDevice = async (userId: string, enable: boolean) => {
  try {
    await prisma.user.update({
      where: { id: userId },
      data: { isMultiDevice: enable }
    });
    return { success: true };
  } catch (error) {
    throw error;
  }
};

export const getUserDevices = async (userId: string) => {
  try {
    const devices = await prisma.userDevice.findMany({
      where: { userId },
      select: {
        id: true,
        status: true,
        loggedInAt: true,
        ipAddress: true,
        userAgent: true
      }
    });
    return devices;
  } catch (error) {
    throw error;
  }
};

export const manageDevice = async (userId: string, deviceId: string, action: 'delete' | 'deactivate') => {
  try {
    if (action === 'delete') {
      await prisma.userDevice.delete({
        where: { id: deviceId, userId }
      });
    } else {
      await prisma.userDevice.update({
        where: { id: deviceId, userId },
        data: { status: false }
      });
    }
    return { success: true };
  } catch (error) {
    throw error;
  }
};

export const validateUser = async (token: string) => {
  if (!token) {
    throw new Error("Unauthorized");
  }

  const decoded = verifyToken(token);
  if (!decoded?.userId) {
    throw new Error("Invalid token");
  }

  return decoded.userId;
};