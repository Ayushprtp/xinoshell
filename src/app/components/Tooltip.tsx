'use client';

import { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';

interface TooltipProps {
  children: React.ReactNode;
  content: string;
  delay?: number;
  position?: 'top' | 'bottom' | 'left' | 'right';
}

const Tooltip = ({ 
  children, 
  content, 
  delay = 0.3, 
  position = 'top' 
}: TooltipProps) => {
  const [isVisible, setIsVisible] = useState(false);

  // Position classes
  const positionClasses = {
    top: 'bottom-full mb-2 left-1/2 transform -translate-x-1/2',
    bottom: 'top-full mt-2 left-1/2 transform -translate-x-1/2',
    left: 'right-full mr-2 top-1/2 transform -translate-y-1/2',
    right: 'left-full ml-2 top-1/2 transform -translate-y-1/2',
  };

  // Arrow classes
  const arrowClasses = {
    top: 'top-full -translate-x-1/2 border-t-gray-700',
    bottom: 'bottom-full -translate-x-1/2 border-b-gray-700',
    left: 'left-full -translate-y-1/2 border-l-gray-700',
    right: 'right-full -translate-y-1/2 border-r-gray-700',
  };

  return (
    <div 
      className="relative inline-block"
      onMouseEnter={() => setIsVisible(true)}
      onMouseLeave={() => setIsVisible(false)}
      onFocus={() => setIsVisible(true)}
      onBlur={() => setIsVisible(false)}
    >
      {children}
      
      <AnimatePresence>
        {isVisible && (
          <motion.div
            initial={{ opacity: 0, scale: 0.9 }}
            animate={{ opacity: 1, scale: 1 }}
            exit={{ opacity: 0, scale: 0.9 }}
            transition={{ duration: 0.15, delay: delay }}
            className={`absolute ${positionClasses[position]} z-50`}
          >
            <div className="bg-gray-700 text-gray-100 text-xs font-medium px-2 py-1 rounded shadow-lg whitespace-nowrap">
              {content}
              <div 
                className={`absolute w-2 h-2 rotate-45 bg-gray-700 border border-gray-700 ${arrowClasses[position]}`}
                style={{
                  left: position === 'top' || position === 'bottom' ? '50%' : undefined,
                  top: position === 'left' || position === 'right' ? '50%' : undefined,
                }}
              />
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
};

export default Tooltip;