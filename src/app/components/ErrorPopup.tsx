'use client';

import { motion } from 'framer-motion';
import { FaExclamationTriangle, FaTimes } from 'react-icons/fa';

interface ErrorPopupProps {
  message: string;
  onClose: () => void;
}

export default function ErrorPopup({ message, onClose }: ErrorPopupProps) {
  return (
    <motion.div
      initial={{ opacity: 0, y: -20 }}
      animate={{ opacity: 1, y: 0 }}
      exit={{ opacity: 0 }}
      className="fixed top-4 left-1/2 -translate-x-1/2 z-50 w-full max-w-md"
    >
      <div className="flex items-center gap-3 bg-red-900/80 text-red-100 px-4 py-3 rounded-lg shadow-lg border border-red-700 text-sm">
        <FaExclamationTriangle className="flex-shrink-0" />
        <span className="flex-grow">{message}</span>
        <button 
          onClick={onClose} 
          className="text-red-300 hover:text-white"
          aria-label="Close error"
        >
          <FaTimes />
        </button>
      </div>
    </motion.div>
  );
}