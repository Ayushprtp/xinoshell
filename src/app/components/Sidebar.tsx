'use client';

import { useState } from 'react';
import { motion } from 'framer-motion';
import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { 
  FiHome, 
  FiServer, 
  FiUser, 
  FiInfo,
  FiMenu,
} from 'react-icons/fi';
import { BsTools } from 'react-icons/bs';

const Sidebar = () => {
  const [isExpanded, setIsExpanded] = useState(false);
  const [isHovered, setIsHovered] = useState(false);
  const pathname = usePathname();

  const menuItems = [
    { name: 'Dashboard', icon: <FiHome size={20} />, path: '/dashboard' },
    { name: 'Devices', icon: <FiServer size={20} />, path: '/devices' },
    { name: 'Apk Builder', icon: <BsTools size={20} />, path: '/builder' },
    { name: 'Profile', icon: <FiUser size={20} />, path: '/profile' },
    { name: 'About', icon: <FiInfo size={20} />, path: '/about' },
  ];

  return (
    <div className="fixed top-0 left-0 h-full z-50">
      <motion.div
        className="h-full bg-gray-900 text-white flex flex-col border-r border-gray-700"
        onMouseEnter={() => setIsHovered(true)}
        onMouseLeave={() => setIsHovered(false)}
        initial={{ width: 80 }}
        animate={{ width: isExpanded || isHovered ? 220 : 80 }}
        transition={{ duration: 0.2, ease: "easeInOut" }}
      >
        {/* Title Section - Only visible when expanded/hovered */}
        <motion.div
          className="flex items-center justify-center p-4 border-b border-gray-700 h-16"
          initial={{ opacity: 0, height: 0 }}
          animate={{ 
            opacity: isExpanded || isHovered ? 1 : 0,
            height: isExpanded || isHovered ? '4rem' : '0px'
          }}
          transition={{ duration: 0.2 }}
        >
          <span className="text-xl font-bold text-indigo-400 whitespace-nowrap">
            XinoShell
          </span>
        </motion.div>

        {/* Menu Items */}
        <nav className="flex-1 p-2 space-y-1 overflow-y-auto">
          {menuItems.map((item) => {
            const isActive = pathname === item.path || 
                           (pathname === '/' && item.path === '/dashboard');
            return (
              <Link href={item.path} key={item.name} passHref>
                <motion.div
                  whileHover={{ backgroundColor: 'rgba(55, 65, 81, 0.5)' }}
                  className={`flex items-center p-3 rounded-lg cursor-pointer 
                    hover:bg-gray-700 transition-colors
                    ${isExpanded || isHovered ? 'justify-start pl-4' : 'justify-center'}
                    ${isActive ? 'bg-indigo-900/50 border-l-4 border-indigo-400' : ''}`}
                >
                  <div className={`${isActive ? 'text-indigo-400' : 'text-gray-300 hover:text-indigo-400'}`}>
                    {item.icon}
                  </div>
                  <motion.span
                    className={`ml-5 whitespace-nowrap ${isActive ? 'text-white font-medium' : 'text-gray-300 hover:text-white'}`}
                    initial={{ opacity: 0 }}
                    animate={{ 
                      opacity: isExpanded || isHovered ? 1 : 0,
                      width: isExpanded || isHovered ? 'auto' : 0
                    }}
                    transition={{ duration: 0.1 }}
                  >
                    {item.name}
                  </motion.span>
                </motion.div>
              </Link>
            );
          })}
        </nav>

        {/* Mobile Toggle Button */}
        <div className="p-2 border-t border-gray-700 md:hidden">
          <button 
            onClick={() => setIsExpanded(!isExpanded)}
            className="flex items-center justify-center w-full p-2 rounded-lg hover:bg-gray-700"
          >
            <FiMenu size={20} />
            {isExpanded && <span className="ml-3">Collapse</span>}
          </button>
        </div>
      </motion.div>
    </div>
  );
};

export default Sidebar;