import { OTP_EXPIRY_MINUTES, OTP_LENGTH } from "@/lib/constants";
import prisma from "@/lib/prisma";
import TelegramBot from "node-telegram-bot-api";

const token = process.env.TELEGRAM_BOT_TOKEN;
if (!token) {
  throw new Error("TELEGRAM_BOT_TOKEN environment variable is not set");
}
const bot = new TelegramBot(token, { polling: false });

export const generateOTP = (): string => {
  let otp = "";
  for (let i = 0; i < OTP_LENGTH; i++) {
    otp += Math.floor(Math.random() * 10).toString();
  }
  return otp;
};

export const sendOtpToTelegram = async (userId: string, ipAddress: string, userAgent: string): Promise<boolean> => {
  try {
    const user = await prisma.user.findUnique({
      where: { id: userId },
    });

    if (!user || !user.tg_id) {
      return false;
    }

    const otp = generateOTP();
    const expiresAt = new Date();
    expiresAt.setMinutes(expiresAt.getMinutes() + OTP_EXPIRY_MINUTES);

    // Store OTP in database
    await prisma.adminOtp.upsert({
      where: { username_tgId: { username: user.username, tgId: user.tg_id } },
      update: {
        otp,
        expiresAt,
        createdAt: new Date()
      },
      create: {
        username: user.username,
        tgId: user.tg_id,
        otp,
        expiresAt
      }
    });

    const now = new Date();
    const loginDateTime = now.toLocaleString();
    const chatId = user.tg_id.toString();
    const message = `🔐 <b>Verification Code Request</b>\n\n💳Your code is: <b>${otp}</b>\n⏱️ This code will expire in <b>${OTP_EXPIRY_MINUTES} minutes</b>.\n<b>⚠️Do NOT share</b> this code with anyone.\n\n<b>Login Attempt Details</b>\n• <b>Date & Time:</b> ${loginDateTime}\n• <b>IP Address:</b> ${ipAddress}\n• <b>User-Agent:</b> ${userAgent}\n\n🔒 If this wasn't you, please secure your account immediately.`;

    await bot.sendMessage(chatId, message, { parse_mode: "HTML" });

    return true;
  } catch (error) {
    console.error("Error sending OTP:", error);
    return false;
  }
};

export const validateOTP = async (userId: string, otp: string): Promise<boolean> => {
  try {
    const user = await prisma.user.findUnique({
      where: { id: userId },
    });

    if (!user) return false;

    const otpRecord = await prisma.adminOtp.findUnique({
      where: { username_tgId: { username: user.username, tgId: user.tg_id } },
    });

    if (!otpRecord) return false;

    // Check if OTP is expired
    if (new Date() > otpRecord.expiresAt) {
      await prisma.adminOtp.delete({
        where: { username_tgId: { username: user.username, tgId: user.tg_id } },
      });
      return false;
    }

    // Check if OTP matches
    if (otpRecord.otp === otp) {
      await prisma.adminOtp.delete({
        where: { username_tgId: { username: user.username, tgId: user.tg_id } },
      });
      return true;
    }

    return false;
  } catch (error) {
    console.error("Error validating OTP:", error);
    return false;
  }
};

setInterval(async () => {
  try {
    const now = new Date();
    await prisma.adminOtp.deleteMany({
      where: {
        expiresAt: {
          lt: now
        }
      }
    });
  } catch (error) {
    console.error("Error cleaning up expired OTPs:", error);
  }
}, 60 * 1000);