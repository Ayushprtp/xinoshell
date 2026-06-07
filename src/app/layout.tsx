import type { Metadata } from 'next';
import { Geist, Geist_Mono, Inter } from 'next/font/google';
import './styles/globals.css';
import { Toaster } from 'sonner';
import Providers from './Provider';

const inter = Inter({ subsets: ['latin'] });

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: "XinoShell | Smart Monitoring Tool",
  description: " XinoShell is a cutting-edge remote management solution designed for security professionals, IT administrators, and ethical users who need to monitor and manage Android devices for legitimate purposes.",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body className={inter.className}>
        <Providers>
          {children}
        </Providers>
        <Toaster position="top-right" richColors />
      </body>
    </html>
  );
}