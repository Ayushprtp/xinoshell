'use client';

import { AuthProvider } from '../context/AuthContext';
import { SocketProvider } from '../context/SocketContext';
import { usePathname } from 'next/navigation';

export default function Providers({ children }: { children: React.ReactNode }) {
  const pathname = usePathname();
  const isAdminRoute = pathname?.includes('/admin');

  if (isAdminRoute) {
    return <>{children}</>;
  }

  return (
    <AuthProvider>
      <SocketProvider>
        {children}
      </SocketProvider>
    </AuthProvider>
  );
}