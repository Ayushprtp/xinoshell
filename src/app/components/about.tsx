'use client';

import { motion } from 'framer-motion';
import Link from 'next/link';
import { FiAlertTriangle, FiSend } from 'react-icons/fi';

export default function AboutPage() {
  return (
    <div className="min-h-screen bg-gray-900 text-gray-100">
      {/* Main Content */}
      <main className="container mx-auto px-4 py-8">
        {/* Title Section */}
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
          className="text-center mb-12"
        >
          <h1 className="text-4xl font-bold text-indigo-400 mb-4">About Us</h1>
          <div className="w-24 h-1 bg-indigo-500 mx-auto mb-6"></div>
        </motion.div>

        {/* App Information Card */}
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.2, duration: 0.5 }}
          className="bg-gray-800 rounded-xl shadow-lg overflow-hidden max-w-4xl mx-auto mb-12 border border-gray-700"
        >
          <div className="p-8">
            <div className="flex flex-col items-center mb-8">
              <div className="w-20 h-20 bg-indigo-900 rounded-full flex items-center justify-center mb-4">
                <span className="text-2xl font-bold text-indigo-400">XS</span>
              </div>
              <h2 className="text-2xl font-bold text-white mb-2">XinoShell</h2>
              <p className="text-gray-400 text-center max-w-md">
                Advanced Android Remote Management & Security Tool
              </p>
            </div>

            <div className="space-y-4 text-gray-300 mb-6 text-center">
              <p>
                ExoSpy is a cutting-edge remote management solution designed for security professionals, 
                IT administrators, and ethical users who need to monitor and manage Android devices 
                for legitimate purposes.
              </p>
              <p>
                Our platform provides comprehensive tools for device monitoring, security management, 
                and remote assistance while maintaining strict ethical guidelines.
              </p>
            </div>

            <div className="flex flex-wrap justify-center gap-4 mt-6">
              <a
                href="https://t.me/@EZYNIPZZZ"
                target="_blank"
                rel="noopener noreferrer"
                className="bg-indigo-600 hover:bg-indigo-700 text-white font-medium py-3 px-6 rounded-lg flex items-center transition-colors"
              >
                <FiSend className="mr-2" />
                Contact on Telegram
              </a>
              
            </div>
          </div>
        </motion.div>

        {/* Warning Section */}
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.4, duration: 0.5 }}
          className="bg-red-900/20 border border-red-700 rounded-xl p-6 max-w-4xl mx-auto mb-12"
        >
          <div className="flex items-start">
            <FiAlertTriangle className="text-red-400 text-2xl mr-4 mt-1 flex-shrink-0" />
            <div>
              <h3 className="text-xl font-bold text-red-400 mb-3">Important Legal Notice</h3>
              <p className="text-red-200 mb-3">
                ExoSpy is designed strictly for legal, ethical purposes including:
              </p>
              <ul className="list-disc pl-5 space-y-2 text-red-200 mb-4">
                <li>Parental monitoring of minor children</li>
                <li>Company device management with employee consent</li>
                <li>Personal device security tracking</li>
                <li>Educational and research purposes</li>
              </ul>
              <p className="text-red-100 font-medium">
                We explicitly prohibit and do not condone any illegal surveillance activities. 
                Users are solely responsible for ensuring their usage complies with all applicable laws.
              </p>
            </div>
          </div>
        </motion.div>

        {/* Action Buttons */}
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.8, duration: 0.5 }}
          className="flex flex-wrap justify-center gap-4 max-w-4xl mx-auto mb-12"
        >   
          <Link
            href="#"
            className="bg-gray-700 hover:bg-gray-600 text-white font-medium py-3 px-6 rounded-lg flex items-center transition-colors"
          >
            Privacy Policy
          </Link>
          <Link
            href="#"
            className="bg-gray-700 hover:bg-gray-600 text-white font-medium py-3 px-6 rounded-lg flex items-center transition-colors"
          >
            Terms & Conditions
          </Link>
        </motion.div>


        {/* Footer Note */}
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 1, duration: 0.5 }}
          className="text-center text-gray-500 text-sm max-w-2xl mx-auto"
        >
          <p>
            © {new Date().getFullYear()} ExoSpy. All rights reserved. This software is provided "as-is" 
            without warranties. Use responsibly and in compliance with all applicable laws.
          </p>
        </motion.div>
      </main>
    </div>
  );
}