import prisma from "@/lib/prisma";
import { Prisma, SmsMessage } from "@prisma/client";

export const getSmsMessages = async (
  userId: string,
  deviceId: string,
  filters: {
    type?: string;
    search?: string;
    fromDate?: string;
    toDate?: string;
    sort?: "recent" | "oldest";
  }
) => {
  const { type, search, fromDate, toDate, sort = "recent" } = filters;

  const where: any = { userId, deviceId };

  if (type) where.type = type;
  if (search) {
    where.OR = [
      { sender: { contains: search, mode: "insensitive" } },
      { textMessage: { contains: search, mode: "insensitive" } },
    ];
  }
  if (fromDate || toDate) {
    where.timestamp = {};
    if (fromDate) where.timestamp.gte = new Date(fromDate);
    if (toDate) where.timestamp.lte = new Date(toDate);
  }

  const orderBy: Prisma.SmsMessageOrderByWithRelationInput = {
    timestamp: sort === "recent" ? "desc" : "asc",
  };

  const messages = await prisma.smsMessage.findMany({
    where,
    orderBy,
  });

  return {
    messages,
    total: messages.length,
  };
};

export const getSmsMessageById = async (
  userId: string,
  deviceId: string,
  messageId: string
) => {
  return prisma.smsMessage.findFirst({
    where: { id: messageId, deviceId,  userId },
  });
};

export const createSmsMessage = async (
  userId: string,
  deviceId: string,
  messageData: Omit<SmsMessage, "id" | "userId" | "deviceId">
) => {
  return prisma.smsMessage.create({
    data: {
      ...messageData,
      userId,
      deviceId,
    },
  });
};

export const getSmsCounts = async (userId: string, deviceId: string) => {
  const [total, incoming, outgoing] = await Promise.all([
    prisma.smsMessage.count({ where: { userId, deviceId } }),
    prisma.smsMessage.count({
      where: {
        userId,
        deviceId,
        type: "incoming",
      },
    }),
    prisma.smsMessage.count({
      where: {
        userId,
        deviceId,
        type: "outgoing",
      },
    }),
  ]);

  return { total, incoming, outgoing };
};