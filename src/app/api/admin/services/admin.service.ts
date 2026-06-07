import fs from "fs";
import path from "path";
import crypto from "crypto";
import axios from "axios";
import jwt, { JwtPayload } from "jsonwebtoken";
import prisma from "@/lib/prisma";
import { generateToken, verifyToken } from "../../auth/services/jwt.service";
import {
  AdminAuthResponse,
  AdminLoginPayload,
  AdminUser,
  AdminUserPayload,
  AdminUserResponse,
  AdminVerifyOtpPayload,
} from "../../../../../types/auth-types";
import { NextResponse } from "next/server";

const TELEGRAM_BOT_TOKEN = process.env.TELEGRAM_BOT_TOKEN;
const ADMIN_DATA_PATH = path.join(process.cwd(), "admin.json");

type PendingLogin = {
  username: string;
  password: string;
  tgId: number;
  expiresAt: number;
};
const pendingLogins = new Map<string, PendingLogin>();
const PENDING_LOGIN_TTL_MS = 5 * 60 * 1000;

const createPendingLoginToken = (
  username: string,
  password: string,
  tgId: number
): string => {
  const token = crypto.randomBytes(24).toString("hex");
  pendingLogins.set(token, {
    username,
    password,
    tgId,
    expiresAt: Date.now() + PENDING_LOGIN_TTL_MS,
  });
  return token;
};

const consumePendingLogin = (token: string): PendingLogin | null => {
  const entry = pendingLogins.get(token);
  if (!entry) return null;
  pendingLogins.delete(token);
  if (Date.now() > entry.expiresAt) return null;
  return entry;
};

setInterval(() => {
  const now = Date.now();
  for (const [token, entry] of pendingLogins.entries()) {
    if (entry.expiresAt < now) pendingLogins.delete(token);
  }
}, 60 * 1000).unref();

export const verifyAdmin = (
  authHeader: string | null
): { isValid: boolean; adminId?: string } => {
  try {
    if (!authHeader) {
      return { isValid: false };
    }

    const [bearer, token] = authHeader.split(" ");
    if (bearer !== "Bearer" || !token) {
      return { isValid: false };
    }

    const decoded = verifyToken(token) as JwtPayload;
    if (!decoded || !decoded.userId) {
      return { isValid: false };
    }

    const adminData = JSON.parse(fs.readFileSync(ADMIN_DATA_PATH, "utf-8"));

    const adminExists = adminData.some(
      (admin: { _id: string }) => admin._id === decoded.userId
    );

    if (!adminExists) {
      return { isValid: false };
    }

    return {
      isValid: true,
      adminId: decoded.userId,
    };
  } catch (error) {
    console.error("Admin verification error:", error);
    return { isValid: false };
  }
};


const readAdminData = (): AdminUser[] => {
  try {
    if (!fs.existsSync(ADMIN_DATA_PATH)) {
      fs.writeFileSync(ADMIN_DATA_PATH, JSON.stringify([]), "utf-8");
      return [];
    }
    const data = fs.readFileSync(ADMIN_DATA_PATH, "utf-8");
    const parsed: AdminUser[] = JSON.parse(data);
    return parsed.map((admin) => {
      if (Array.isArray(admin.telegram_accounts) && admin.telegram_accounts.length > 0) {
        return admin;
      }
      const fallback = (admin as unknown as { tg_id?: number; tg_username?: string });
      return {
        ...admin,
        telegram_accounts:
          fallback.tg_id && fallback.tg_username
            ? [{ label: admin.username, tg_id: fallback.tg_id, tg_username: fallback.tg_username }]
            : [],
      };
    });
  } catch (error) {
    console.error("Error reading admin data:", error);
    return [];
  }
};

const writeAdminData = (data: AdminUser[]) => {
  try {
    fs.writeFileSync(ADMIN_DATA_PATH, JSON.stringify(data, null, 2), "utf-8");
  } catch (error) {
    console.error("Error writing admin data:", error);
    throw new Error("Failed to update admin data");
  }
};

const generateOtp = (): string => {
  return Math.floor(100000 + Math.random() * 900000).toString();
};

const sendTelegramOtp = async (
  tg_id: number,
  otp: string,
  accountLabel: string
): Promise<boolean> => {
  if (!TELEGRAM_BOT_TOKEN) {
    throw new Error("Telegram bot token not configured");
  }

  try {
    const message = `Your admin login OTP is: ${otp}\nAccount: ${accountLabel}\nThis code will expire in 2 minutes.`;
    const response = await axios.post(
      `https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage`,
      {
        chat_id: tg_id,
        text: message,
      }
    );

    return response.data.ok === true;
  } catch (error) {
    console.error("Error sending Telegram OTP:", error);
    throw new Error("Failed to send OTP via Telegram");
  }
};

export const adminLogin = async (
  payload: AdminLoginPayload
): Promise<AdminAuthResponse> => {
  try {
    const { username, password } = payload;
    const admins = readAdminData();

    const admin = admins.find((a) => a.username === username);
    if (!admin) {
      return {
        success: false,
        message: "Invalid credentials",
        error: "INVALID_CREDENTIALS",
      };
    }

    const passwordMatch = password === admin.password;
    if (!passwordMatch) {
      return {
        success: false,
        message: "Invalid credentials",
        error: "INVALID_CREDENTIALS",
      };
    }

    if (!admin.telegram_accounts || admin.telegram_accounts.length === 0) {
      return {
        success: false,
        message: "No Telegram accounts configured for this admin",
        error: "NO_TELEGRAM_ACCOUNTS",
      };
    }

    return {
      success: true,
      message: "Select a Telegram account to receive the OTP",
      data: {
        is2fa: true,
        isOtpSend: false,
        telegram_accounts: admin.telegram_accounts.map(
          ({ tg_username, label }) => {
            const token = createPendingLoginToken(
              admin.username,
              password,
              admin.telegram_accounts.find((a) => a.label === label)!.tg_id
            );
            return { tg_username, label, login_token: token };
          }
        ),
      },
    };
  } catch (error: any) {
    return {
      success: false,
      message: error.message || "Login failed",
      error: "LOGIN_FAILED",
    };
  }
};

export const sendAdminOtpToAccount = async (
  payload: { login_token: string }
): Promise<AdminAuthResponse> => {
  try {
    const { login_token } = payload;
    const pending = consumePendingLogin(login_token);
    if (!pending) {
      return {
        success: false,
        message: "Login session expired, please sign in again",
        error: "PENDING_LOGIN_EXPIRED",
      };
    }

    const admins = readAdminData();
    const admin = admins.find((a) => a.username === pending.username);
    if (!admin || pending.password !== admin.password) {
      return {
        success: false,
        message: "Invalid credentials",
        error: "INVALID_CREDENTIALS",
      };
    }

    const account = admin.telegram_accounts.find((a) => a.tg_id === pending.tgId);
    if (!account) {
      return {
        success: false,
        message: "Selected Telegram account not registered for this admin",
        error: "TELEGRAM_ACCOUNT_NOT_FOUND",
      };
    }

    const otp = generateOtp();
    const expiresAt = new Date(Date.now() + 2 * 60 * 1000);
    await prisma.adminOtp.upsert({
      where: { username_tgId: { username: pending.username, tgId: account.tg_id } },
      create: { username: pending.username, tgId: account.tg_id, otp, expiresAt },
      update: { otp, expiresAt },
    });

    const otpSent = await sendTelegramOtp(account.tg_id, otp, account.label);
    if (!otpSent) {
      return {
        success: false,
        message: "Failed to send OTP",
        error: "OTP_SEND_FAILED",
      };
    }

    const verifyToken = createPendingLoginToken(
      pending.username,
      pending.password,
      account.tg_id
    );

    return {
      success: true,
      message: `OTP sent to ${account.label} on Telegram`,
      data: {
        is2fa: true,
        isOtpSend: true,
        login_token: verifyToken,
      },
    };
  } catch (error: any) {
    return {
      success: false,
      message: error.message || "Failed to send OTP",
      error: "OTP_SEND_FAILED",
    };
  }
};

export const verifyAdminOtp = async (
  payload: { login_token: string; otp: string }
): Promise<AdminAuthResponse> => {
  try {

    const { login_token, otp } = payload;
    const pending = consumePendingLogin(login_token);
    if (!pending) {
      return {
        success: false,
        message: "Login session expired, please sign in again",
        error: "PENDING_LOGIN_EXPIRED",
      };
    }

    const admins = readAdminData();
    const admin = admins.find((a) => a.username === pending.username);
    if (!admin) {
      return {
        success: false,
        message: "Admin not found",
        error: "ADMIN_NOT_FOUND",
      };
    }

    const account = admin.telegram_accounts.find((a) => a.tg_id === pending.tgId);
    if (!account) {
      return {
        success: false,
        message: "Selected Telegram account not registered for this admin",
        error: "TELEGRAM_ACCOUNT_NOT_FOUND",
      };
    }

    const otpRecord = await prisma.adminOtp.findUnique({
      where: { username_tgId: { username: pending.username, tgId: account.tg_id } },
    });

    if (!otpRecord) {
      return {
        success: false,
        message: "OTP not found for the selected account",
        error: "OTP_NOT_FOUND",
      };
    }

    if (new Date() > otpRecord.expiresAt) {
      await prisma.adminOtp.delete({
        where: { username_tgId: { username: pending.username, tgId: account.tg_id } },
      });
      return {
        success: false,
        message: "OTP expired",
        error: "OTP_EXPIRED",
      };
    }

    if (otpRecord.otp !== otp) {
      return {
        success: false,
        message: "Invalid OTP",
        error: "INVALID_OTP",
      };
    }
    await prisma.adminOtp.delete({
      where: { username_tgId: { username: pending.username, tgId: account.tg_id } },
    });

    const updatedAdmins = admins.map((a) =>
      a.username === pending.username
        ? { ...a, last_login: new Date().toISOString() }
        : a
    );
    writeAdminData(updatedAdmins);

    const token = generateToken(admin._id);

    const { password: _, telegram_accounts: _accounts, ...adminRest } = admin;
    const adminData = {
      ...adminRest,
      telegram_accounts: admin.telegram_accounts.map(
        ({ tg_username, label }) => ({ tg_username, label })
      ),
    };

    return {
      success: true,
      message: "Login successful",
      data: {
        token,
        admin: adminData,
      },
    };
  } catch (error: any) {
    return {
      success: false,
      message: error.message || "OTP verification failed",
      error: "OTP_VERIFICATION_FAILED",
    };
  }
};

export const validateAdminToken = (token: string): JwtPayload | null => {
  try {
    return verifyToken(token) as JwtPayload;
  } catch (error) {
    return null;
  }
};

// User CRUD Operations
export const createUser = async (
  payload: AdminUserPayload
): Promise<AdminUserResponse> => {
  try {
    const existingUser = await prisma.user.findFirst({
      where: {
        OR: [{ username: payload.username }, { tg_id: payload.tg_id }],
      },
    });

    if (existingUser) {
      return {
        success: false,
        message: "User with this username or Telegram ID already exists",
        error: "USER_EXISTS",
      };
    }

    const newUser = await prisma.user.create({
      data: {
        ...payload,
        last_login: new Date().toISOString(),
        exp_date: new Date(payload.exp_date),
        isTwoFactor: payload.isTwoFactor ?? true,
        isMultiDevice: payload.isMultiDevice ?? false,
        lang: payload.lang ?? "en",
      },
    });

    return {
      success: true,
      message: "User created successfully",
      data: newUser,
    };
  } catch (error: any) {
    console.error("User creation error:", error);
    return {
      success: false,
      message: "Failed to create user",
      error: error.code || "DATABASE_ERROR",
    };
  }
};

export const deleteUser = async (
  userId: string
): Promise<AdminUserResponse> => {
  try {
    // Check if user exists
    const user = await prisma.user.findUnique({
      where: { id: userId },
    });

    if (!user) {
      return {
        success: false,
        message: "User not found",
        error: "USER_NOT_FOUND",
      };
    }

    // Delete related records first
    await prisma.smsMessage.deleteMany({
      where: { userId },
    });

    await prisma.userDevice.deleteMany({
      where: { userId },
    });

    const deletedUser = await prisma.user.delete({
      where: { id: userId },
    });

    return {
      success: true,
      message: "User deleted successfully",
      data: deletedUser,
    };
  } catch (error: any) {
    console.error("User deletion error:", error);
    return {
      success: false,
      message: "Failed to delete user",
      error: error.code || "DATABASE_ERROR",
    };
  }
};

export const disableUser = async (
  userId: string
): Promise<AdminUserResponse> => {
  try {
    const user = await prisma.user.findUnique({
      where: { id: userId },
    });

    if (!user) {
      return {
        success: false,
        message: "User not found",
        error: "USER_NOT_FOUND",
      };
    }

    const updatedUser = await prisma.user.update({
      where: { id: userId },
      data: { isDisabled: !user.isDisabled },
    });

    return {
      success: true,
      message: `User ${updatedUser.isDisabled ? 'disabled' : 'enabled'} successfully`,
      data: updatedUser,
    };
  } catch (error: any) {
    console.error("Toggle user status error:", error);
    return {
      success: false,
      message: "Failed to toggle user status",
      error: error.code || "DATABASE_ERROR",
    };
  }
}

export const getAllUsers = async (): Promise<AdminUserResponse> => {
  try {
    const users = await prisma.user.findMany({
      include: { user_devices: false, client_devices: false },
      orderBy: { registeredOn: "desc" },
    });
    return {
      success: true,
      message: "Users retrieved successfully",
      data: users,
    };
  } catch (error: any) {
    console.error("Get all users error:", error);
    return {
      success: false,
      message: "Failed to retrieve users",
      error: "DATABASE_ERROR",
    };
  }
};

export const getUserById = async (
  userId: string
): Promise<AdminUserResponse> => {
  try {
    const user = await prisma.user.findUnique({
      where: { id: userId },
      include: { user_devices: false, client_devices: false },
    });

    if (!user) {
      return {
        success: false,
        message: "User not found",
        error: "USER_NOT_FOUND",
      };
    }

    return {
      success: true,
      message: "User retrieved successfully",
      data: user,
    };
  } catch (error: any) {
    console.error("Get user by ID error:", error);
    return {
      success: false,
      message: "Failed to retrieve user",
      error: "DATABASE_ERROR",
    };
  }
};

export const updateUserById = async (
  userId: string,
  payload: Partial<AdminUserPayload>
): Promise<AdminUserResponse> => {
  try {
    // Check if user exists
    const existingUser = await prisma.user.findUnique({
      where: { id: userId },
    });

    if (!existingUser) {
      return {
        success: false,
        message: "User not found",
        error: "USER_NOT_FOUND",
      };
    }

    // Check for username or tg_id conflicts with other users
    if (payload.username || payload.tg_id) {
      const conflictUser = await prisma.user.findFirst({
        where: {
          AND: [
            { id: { not: userId } },
            {
              OR: [
                ...(payload.username ? [{ username: payload.username }] : []),
                ...(payload.tg_id ? [{ tg_id: payload.tg_id }] : []),
              ],
            },
          ],
        },
      });

      if (conflictUser) {
        return {
          success: false,
          message: "Username or Telegram ID already in use by another user",
          error: "CONFLICT",
        };
      }
    }

    const updateData: any = { ...payload };

    if (payload.exp_date) {
      updateData.exp_date = new Date(payload.exp_date);
    }

    const updatedUser = await prisma.user.update({
      where: { id: userId },
      data: updateData,
      include: { user_devices: false, client_devices: false },
    });

    return {
      success: true,
      message: "User updated successfully",
      data: updatedUser,
    };
  } catch (error: any) {
    console.error("User update error:", error);
    return {
      success: false,
      message: "Failed to update user",
      error: error.code || "DATABASE_ERROR",
    };
  }
};

export const adminAuthMiddleware = (req: any, res: any, next: any) => {
  const authHeader = req.headers.authorization;

  if (!authHeader) {
    return NextResponse.json(
      {
        success: false,
        message: "Authorization header missing",
        error: "UNAUTHORIZED",
      },
      { status: 401 }
    );
  }

  const token = authHeader.split(" ")[1];
  if (!token) {
    return NextResponse.json(
      { success: false, message: "Token missing", error: "UNAUTHORIZED" },
      { status: 401 }
    );
  }

  const decoded = validateAdminToken(token);
  if (!decoded) {
    return NextResponse.json(
      {
        success: false,
        message: "Invalid or expired token",
        error: "INVALID_TOKEN",
      },
      { status: 401 }
    );
  }

  req.admin = decoded;
  next();
};
