// types/auth-types.d.ts
import { User, UserDevice } from '@prisma/client';

export interface AuthResponse {
  success: boolean;
  message: string;
  error?: string;
  data?: {
    user?: {
      id: string;
      name: string;
      username: string;
      tg_id: number;
      tg_username?: string;
      exp_date: Date;
      amount_paid: string;
      lang?: string;
      isMultiDevice: boolean;
    };
    token?: string;
    expiresIn?: number;
    otpSent?: boolean;
    userId?: string;
  };
}

export type LoginPayload = {
  username: string;
  password: string;
  deviceInfo: {
    ipAddress: string;
    userAgent: string;
    deviceType?: string;
  };
};

export type OTPPayload = {
  userId: string;
  otp: string;
  deviceInfo: {
    ipAddress: string;
    userAgent: string;
    deviceType?: string;
  };
};

export type AdminUserPayload = {
  name: string;
  tg_username: string;
  tg_id: number;
  password: string;
  username: string;
  exp_date: string;
  amount_paid: string;
  isDisabled?: boolean;
  isTwoFactor?: boolean;
  isMultiDevice?: boolean;
  lang?: string;
};

export type AdminUserResponse = {
  success: boolean;
  message: string;
  data?: User | User[];
  error?: string;
};

export interface ActiveConnection {
  socketId: string;
  userId: string;
  type: string;
  ipAddress: string;
  connectedAt: Date;
}

export interface TelegramAccount {
  label: string;
  tg_username: string;
  login_token: string;
}

export interface AdminUser {
  _id: string;
  name: string;
  password: string;
  username: string;
  telegram_accounts: TelegramAccount[];
  last_login: string | null;
  registeredOn: string;
}

export interface AdminLoginPayload {
  username: string;
  password: string;
}

export interface AdminVerifyOtpPayload {
  login_token: string;
  otp: string;
}

export interface AdminAuthResponse {
  success: boolean;
  message: string;
  data?: {
    token?: string;
    admin?: Omit<AdminUser, 'password'>;
    is2fa?: boolean;
    isOtpSend?: boolean;
    telegram_accounts?: TelegramAccount[];
    login_token?: string;
  };
  error?: string;
}

export interface JwtPayload {
  adminId: string;
  username: string;
  tg_id: number;
  iat: number;
  exp: number;
}