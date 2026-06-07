'use client';

import { useState } from 'react';
import { motion } from 'framer-motion';
import { FaSpinner } from 'react-icons/fa';
import { useAuth } from '../../context/AuthContext';
import { AuthResponse } from '../../../types/auth-types';
import { getDeviceInfo } from '@/lib/network';

interface LoginFormProps {
  onSuccess: (response: AuthResponse) => void;
  onError: (message: string) => void;
}

export default function LoginForm({ onSuccess, onError }: LoginFormProps) {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const { login } = useAuth();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);

    try {
      const deviceInfo = await getDeviceInfo()

      const response = await login({
        username,
        password,
        deviceInfo,
      });

      if (response.success) {
        onSuccess(response);
      } else {
        onError(response.message || 'Login failed');
      }
    } catch (err) {
      onError('Login failed. Please try again.');
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-6">
      <div>
        <label htmlFor="username" className="block text-sm font-medium leading-6">
          Username
        </label>
        <div className="mt-2">
          <input
            id="username"
            type="text"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
            required
            className="block w-full rounded-md border-0 bg-gray-700 py-1.5 text-gray-100 shadow-sm ring-1 ring-inset ring-gray-600 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-500 sm:text-sm sm:leading-6 px-3"
          />
        </div>
      </div>

      <div>
        <label htmlFor="password" className="block text-sm font-medium leading-6">
          Password
        </label>
        <div className="mt-2">
          <input
            id="password"
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
            className="block w-full rounded-md border-0 bg-gray-700 py-1.5 text-gray-100 shadow-sm ring-1 ring-inset ring-gray-600 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-500 sm:text-sm sm:leading-6 px-3"
          />
        </div>
      </div>

      <div>
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
            'Sign in'
          )}
        </motion.button>
      </div>
    </form>
  );
}