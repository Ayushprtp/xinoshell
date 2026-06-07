import prisma from '@/lib/prisma';
import { UserDevice } from '@prisma/client';


export const addUserDevice = async (
  userId: string,
  deviceInfo: {
    ipAddress: string;
    userAgent: string;
  }
): Promise<UserDevice> => {
  return await prisma.userDevice.create({
    data: {
      status: true,
      loggedInAt: new Date(),
      ipAddress: deviceInfo.ipAddress,
      userAgent: deviceInfo.userAgent,
      userId: userId
    }
  });
};

export const checkActiveDevices = async (userId: string): Promise<number> => {
  return await prisma.userDevice.count({
    where: {
      userId: userId,
      status: true
    }
  });
};

export const deactivateOtherDevices = async (userId: string): Promise<void> => {
  await prisma.userDevice.updateMany({
    where: {
      userId: userId,
      status: true
    },
    data: {
      status: false
    }
  });
};