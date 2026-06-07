import prisma from "@/lib/prisma";
import { generateToken } from "./jwt.service";
import { sendOtpToTelegram, validateOTP } from "./otp.service";
import { addUserDevice, checkActiveDevices } from "./device.service";
import {
  AuthResponse,
  LoginPayload,
  OTPPayload,
} from "../../../../../types/auth-types";

export const authenticateUser = async (
  payload: LoginPayload
): Promise<AuthResponse> => {
  try {
    const { username, password, deviceInfo } = payload;
    console.log(deviceInfo);
    if (!deviceInfo?.ipAddress || !deviceInfo?.userAgent) {
      throw new Error("Device info is incomplete");
    }

    const user = await prisma.user.findUnique({
      where: { username },
      include: { user_devices: true },
    });

    if (!user) {
      return {
        success: false,
        message: "User not found",
        error: "USER_NOT_FOUND",
      };
    }

    if (user.password !== password) {
      return {
        success: false,
        message: "Invalid credentials",
        error: "INVALID_CREDENTIALS",
      };
    }

    if (user.isDisabled) {
      return {
        success: false,
        message: "Account is disabled",
        error: "ACCOUNT_DISABLED",
      };
    }

    if (new Date() > new Date(user.exp_date)) {
      return {
        success: false,
        message: "Account has expired",
        error: "ACCOUNT_EXPIRED"
      };
    }

    if (!user.isMultiDevice) {
      const activeDevices = await checkActiveDevices(user.id);
      if (activeDevices >= 1) {
        return {
          success: false,
          message: "Multi-device login is disabled",
          error: "MULTI_DEVICE_RESTRICTED",
        };
      }
    }

    if (user.isTwoFactor) {
      const otpSent = await sendOtpToTelegram(
        user.id,
        deviceInfo.ipAddress,
        deviceInfo.userAgent
      );
      if (!otpSent) {
        return {
          success: false,
          message: "Failed to send OTP",
          error: "OTP_SEND_FAILED",
        };
      }

      return {
        success: true,
        message: "OTP sent to your Telegram",
        data: {
          otpSent: true,
          userId: user.id,
        },
      };
    }

    const token = generateToken(user.id);

    await addUserDevice(user.id, {
      ipAddress: deviceInfo.ipAddress,
      userAgent: deviceInfo.userAgent,
    });

    await prisma.user.update({
      where: { id: user.id },
      data: { last_login: new Date() },
    });

    return {
      success: true,
      message: "Login successful",
      data: {
        user: {
          id: user.id,
          name: user.name,
          username: user.username,
          tg_id: user.tg_id,
          exp_date: user.exp_date,
          tg_username: user.tg_username,
          lang: user.lang,
          amount_paid: user.amount_paid,
          isMultiDevice: user.isMultiDevice,
        },
        token,
        expiresIn: 1 * 24 * 60 * 60,
      },
    };
  } catch (error) {
    console.error("Authentication error:", error);
    return {
      success: false,
      message: "Authentication failed",
      error: "AUTHENTICATION_ERROR",
    };
  }
};

export const verifyTwoFactor = async (
  payload: OTPPayload
): Promise<AuthResponse> => {
  try {
    const { userId, otp, deviceInfo } = payload;

    console.log(deviceInfo);
    if (!deviceInfo?.ipAddress || !deviceInfo?.userAgent) {
      throw new Error("Device info is incomplete");
    }

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

    const isValid = validateOTP(userId, otp);
    if (!isValid) {
      return {
        success: false,
        message: "Invalid or expired OTP",
        error: "INVALID_OTP",
      };
    }

    await addUserDevice(user.id, {
      ipAddress: deviceInfo.ipAddress,
      userAgent: deviceInfo.userAgent,
    });

    const token = generateToken(user.id);

    return {
      success: true,
      message: "Two-factor authentication successful",
      data: {
        user: {
          id: user.id,
          name: user.name,
          username: user.username,
          tg_id: user.tg_id,
          exp_date: user.exp_date,
          amount_paid: user.amount_paid,
          tg_username: user.tg_username,
          lang: user.lang,
          isMultiDevice: user.isMultiDevice,
        },
        token,
        expiresIn: 1 * 24 * 60 * 60,
      },
    };
  } catch (error) {
    console.error("2FA verification error:", error);
    return {
      success: false,
      message: "Two-factor verification failed",
      error: "TWO_FACTOR_ERROR",
    };
  }
};
