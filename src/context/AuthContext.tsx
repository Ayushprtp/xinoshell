"use client";

import { createContext, useContext, useEffect, useState } from "react";
import { useRouter, usePathname } from "next/navigation";
import { AuthResponse } from "../../types/auth-types";

interface AuthContextType {
  user: any;
  loading: boolean;
  login: (payload: any) => Promise<AuthResponse>;
  verifyOtp: (payload: any) => Promise<AuthResponse>;
  logout: () => Promise<void>;
}

const AuthContext = createContext<AuthContextType>({} as AuthContextType);

export const AuthProvider = ({ children }: { children: React.ReactNode }) => {
  const [user, setUser] = useState<any>(null);
  const [loading, setLoading] = useState(true);
  const router = useRouter();
  const pathname = usePathname();

  useEffect(() => {
    const checkAuth = async () => {
      try {
        const localData = localStorage.getItem("userData");

        if (!localData) {
          if (pathname !== "/login") {
            router.push("/login");
          }
          setLoading(false);
          return;
        }

        const parsedData = JSON.parse(localData);
        const response = await fetch("/api/auth/check", {
          headers: {
            Authorization: `Bearer ${parsedData.token}`,
          },
        });

        if (response.ok) {
          const data = await response.json();
          setUser(data.user);
          if (pathname === "/login") {
            router.push("/dashboard");
          }
        } else {
          localStorage.removeItem("userData");
          if (pathname !== "/login") {
            router.push("/login");
          }
        }
      } catch (error) {
        console.error("Auth check failed:", error);
        localStorage.removeItem("userData");
        if (pathname !== "/login") {
          router.push("/login");
        }
      } finally {
        setLoading(false);
      }
    };

    checkAuth();
  }, [pathname, router]);

  const login = async (payload: any): Promise<AuthResponse> => {
    try {
      const response = await fetch("/api/auth", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(payload),
        credentials: "include",
      });

      const data = await response.json();
      if (data.success && data.data?.token) {
        localStorage.setItem("userData", JSON.stringify(data.data));
        setUser(data.data.user);
        setTimeout(() => router.push("/dashboard"), 100);
      }
      return data;
    } catch (error) {
      console.error("Login failed:", error);
      return {
        success: false,
        message: "Login failed",
        error: "LOGIN_FAILED",
      };
    }
  };

  const verifyOtp = async (payload: any): Promise<AuthResponse> => {
    try {
      const response = await fetch("/api/auth", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          ...payload,
          otp: payload.otp,
          userId: payload.userId,
        }),
        credentials: "include",
      });

      const data = await response.json();
      if (data.success && data.data?.token) {
        localStorage.setItem("userData", JSON.stringify(data.data));
        setUser(data.data.user);
        setTimeout(() => router.push("/dashboard"), 100);
      }
      return data;
    } catch (error) {
      console.error("OTP verification failed:", error);
      return {
        success: false,
        message: "OTP verification failed",
        error: "OTP_VERIFICATION_FAILED",
      };
    }
  };

  const logout = async () => {
    try {
      await fetch("/api/auth", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ logout: true }),
        credentials: "include",
      });
      setUser(null);
      localStorage.removeItem("userData");
      router.push("/login");
    } catch (error) {
      console.error("Logout failed:", error);
    }
  };

  return (
    <AuthContext.Provider value={{ user, loading, login, verifyOtp, logout }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => useContext(AuthContext);
