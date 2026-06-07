"use client";

import {
  createContext,
  useContext,
  useEffect,
  useState,
  ReactNode,
} from "react";
import { io, Socket, ManagerOptions, SocketOptions } from "socket.io-client";

interface SocketContextValue {
  socket: Socket | null;
  isConnected: boolean;
}
const SocketContext = createContext<SocketContextValue | null>(null);

interface SocketProviderProps {
  children: ReactNode;
  options?: Partial<ManagerOptions & SocketOptions>;
}

export function SocketProvider({ children, options }: SocketProviderProps) {
  const [socket, setSocket] = useState<Socket | null>(null);
  const [isConnected, setIsConnected] = useState(false);
  const [userId, setUserId] = useState<string | null>(null);

  useEffect(() => {
    const userData = localStorage.getItem("userData");
    if (userData) {
      console.log("User data found in localStorage:", userData);
      const { user } = JSON.parse(userData);
      if (user && user.id) {
        console.log("Setting user ID from localStorage:", user.id);
        setUserId(user.id);
      } else {
        console.warn("No token found in localStorage.");
      }
    }
  }, []);

  useEffect(() => {

    if (!userId) {
      console.log("No user ID found - skipping socket connection");
      return;
    }

    const s = io({
      path: "/socket.io",
      transports: ["websocket"],
      autoConnect: true,
      reconnectionAttempts: 5,
      reconnectionDelay: 1000,
      query: { type: "frontend", userId: userId },
      ...options,
    });

    const onConnect = () => {
      setIsConnected(true);
      console.log("Socket connected:", s.id);
    };
    const onDisconnect = () => {
      setIsConnected(false);
      console.log("Socket disconnected");
    };

    s.on("connect", onConnect);
    s.on("disconnect", onDisconnect);
    setSocket(s);

    return () => {
      s.off("connect", onConnect);
      s.off("disconnect", onDisconnect);
      s.disconnect();
    };
  }, [userId, options]);

  return (
    <SocketContext.Provider value={{ socket, isConnected }}>
      {children}
    </SocketContext.Provider>
  );
}

export function useSocket() {
  const ctx = useContext(SocketContext);
  if (!ctx) throw new Error("useSocket must be used within a SocketProvider");
  return ctx;
}
