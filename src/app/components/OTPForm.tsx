'use client';

import { useState } from 'react';
import { motion } from 'framer-motion';
import { FaSpinner, FaTelegram } from 'react-icons/fa';
import { useAuth } from '../../context/AuthContext';
import { getDeviceInfo } from '@/lib/network';

interface OTPFormProps {
  userId: string;
  onSuccess: () => void;
  onError: (message: string) => void;
}

export default function OTPForm({ userId, onSuccess, onError }: OTPFormProps) {
  const [otp, setOtp] = useState<string>('');
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const { verifyOtp } = useAuth();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);

    try {
      const deviceInfo = await getDeviceInfo()

      const response = await verifyOtp({
        userId,
        otp,
        deviceInfo,
      });

      if (response.success) {
        onSuccess();
      } else {
        onError(response.message || 'Invalid OTP code');
      }
    } catch (err) {
      onError('Verification failed. Please try again.');
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="space-y-6">
      <p className="text-sm text-gray-300">
        We've sent a 6-digit code to your Telegram. Please enter it below.
      </p>

      <form onSubmit={handleSubmit} className="space-y-6">
        <div>
          <label htmlFor="otp" className="block text-sm font-medium leading-6">
            OTP Code
          </label>
          <div className="mt-2">
            <input
              id="otp"
              type="text"
              value={otp}
              onChange={(e) => setOtp(e.target.value)}
              maxLength={8}
              pattern="\d{8}"
              required
              className="block w-full rounded-md border-0 bg-gray-700 py-1.5 text-gray-100 shadow-sm ring-1 ring-inset ring-gray-600 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-500 sm:text-sm sm:leading-6 px-3 text-center tracking-widest"
            />
          </div>
        </div>

        <div className="space-y-3">
          <motion.button
            type="submit"
            whileHover={{ scale: 1.02 }}
            whileTap={{ scale: 0.98 }}
            disabled={isLoading}
            className="flex w-full justify-center rounded-md bg-indigo-600 px-3 py-1.5 text-sm font-semibold leading-6 text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600 disabled:opacity-70"
          >
            {isLoading ? (
              <FaSpinner className="animate-spin h-5 w-5" />
            ) : (
              'Verify'
            )}
          </motion.button>

          <a
            href="https://t.me/@XinoShellVerification_bot"
            target="_blank"
            rel="noopener noreferrer"
            className="flex w-full justify-center items-center gap-2 rounded-md bg-gray-700 px-3 py-1.5 text-sm font-semibold leading-6 text-indigo-400 shadow-sm hover:bg-gray-600 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-gray-600"
          >
            <FaTelegram /> Open Telegram Bot
          </a>
        </div>
      </form>
    </div>
  );
}