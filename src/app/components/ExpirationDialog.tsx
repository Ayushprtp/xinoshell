'use client';

import { motion } from 'framer-motion';
import { FaTimes } from 'react-icons/fa';

interface ExpirationDialogProps {
  userData: {
    id: string;
    name: string;
    tg_username?: string | null;
    username: string;
    exp_date: string;
    amount_paid: string;
    isMultiDevice: boolean;
  };
  onClose: () => void;
}

export default function ExpirationDialog({ userData, onClose }: ExpirationDialogProps) {
  return (
    <motion.div
      initial={{ opacity: 0, y: -20 }}
      animate={{ opacity: 1, y: 0 }}
      exit={{ opacity: 0 }}
      className="fixed top-4 left-1/2 -translate-x-1/2 z-50 w-full max-w-md"
    >
      <div className="bg-gray-800 rounded-lg shadow-xl overflow-hidden border border-red-700">
        <div className="px-6 py-4">
          <div className="flex justify-between items-start">
            <h2 className="text-xl font-bold text-red-400">Account Expired</h2>
            <button 
              onClick={onClose}
              className="text-gray-400 hover:text-white"
            >
              <FaTimes />
            </button>
          </div>
          
          <div className="mt-4 space-y-3 text-sm">
            <p>Your account expired on: {new Date(userData.exp_date).toLocaleDateString()}</p>
            <p>Amount paid: ${userData.amount_paid}</p>
            <p>Multi-device: {userData.isMultiDevice ? 'Enabled' : 'Disabled'}</p>
            
            {userData.tg_username && (
              <p>Telegram: @{userData.tg_username}</p>
            )}

            <div className="pt-4">
              <p className="text-red-400">Please renew your subscription to continue using the service.</p>
            </div>
          </div>
        </div>
      </div>
    </motion.div>
  );
}