'use client';
import { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import LoginForm from '../components/LoginForm';
import OTPForm from '../components/OTPForm';
import ErrorPopup from '../components/ErrorPopup';
import ExpirationDialog from '../components/ExpirationDialog';
import { useAuth } from '../../context/AuthContext';
import { AuthResponse } from '../../../types/auth-types';

interface ExpiredUserData {
  id: string;
  name: string;
  tg_username?: string | null;
  username: string;
  exp_date: string;
  amount_paid: string;
  isMultiDevice: boolean;
}

export default function LoginPage() {
  const [showOTP, setShowOTP] = useState<boolean>(false);
  const [error, setError] = useState<string | null>(null);
  const [userId, setUserId] = useState<string | null>(null);
  const [expiredUserData, setExpiredUserData] = useState<ExpiredUserData | null>(null);
  const { user, loading } = useAuth();

  const handleLoginSuccess = (response: AuthResponse) => {
    if (!response.success) {
      if (response.error === 'ACCOUNT_EXPIRED' && response.data?.user) {
        setExpiredUserData({
          id: response.data.user.id,
          name: response.data.user.name,
          tg_username: response.data.user.tg_username,
          username: response.data.user.username,
          exp_date: response.data.user.exp_date.toDateString(),
          amount_paid: response.data.user.amount_paid.valueOf(),
          isMultiDevice: response.data.user.isMultiDevice
        });
        return;
      }
      setError(response.message || 'Login failed');
      return;
    }

    if (response.data?.otpSent && response.data.userId) {
      setUserId(response.data.userId);
      setShowOTP(true);
    } else if (response.data?.token) {
      window.location.href = '/dashboard';
    }
  };

  const handleOtpSuccess = () => {
    window.location.href = '/dashboard';
  };

  const handleExpirationDialogClose = () => {
    setExpiredUserData(null);
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-gray-900 flex items-center justify-center">
        <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-indigo-500"></div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-900 text-gray-100 flex flex-col justify-center px-4 py-12 sm:px-6 lg:px-8">
      <AnimatePresence>
        {error && (
          <ErrorPopup 
            message={error} 
            onClose={() => setError(null)} 
          />
        )}
        {expiredUserData && (
          <ExpirationDialog 
            userData={expiredUserData}
            onClose={handleExpirationDialogClose}
          />
        )}
      </AnimatePresence>

      <motion.div
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
        className="sm:mx-auto sm:w-full sm:max-w-md bg-gray-800 rounded-lg shadow-xl overflow-hidden"
      >
        <div className="px-6 py-8 sm:px-10">
          <h1 className="text-center text-2xl font-bold leading-9 tracking-tight">
            Secure Login
          </h1>

          <div className="mt-8">
            {!showOTP ? (
              <LoginForm 
                onSuccess={handleLoginSuccess} 
                onError={setError} 
              />
            ) : (
              <OTPForm 
                userId={userId || ''}
                onSuccess={handleOtpSuccess} 
                onError={setError} 
              />
            )}
          </div>
        </div>
      </motion.div>
    </div>
  );
}