'use client';
import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import Head from 'next/head';
import toast, { Toaster } from 'react-hot-toast';

interface TelegramAccount {
  label: string;
  tg_username: string;
  login_token: string;
}

interface LoginData {
  username: string;
  password: string;
}

interface OTPData {
  login_token: string;
  otp: string;
}

interface LoginResponse {
  success: boolean;
  message: string;
  data?: {
    is2fa: boolean;
    isOtpSend: boolean;
    telegram_accounts?: TelegramAccount[];
    login_token?: string;
  };
  error?: string;
}

interface VerifyOtpResponse {
  success: boolean;
  message: string;
  data?: {
    token: string;
    admin: {
      _id: string;
      username: string;
      telegram_accounts: TelegramAccount[];
      last_login: string;
    };
  };
  error?: string;
}

export default function AdminLogin() {
  const router = useRouter();
  const [step, setStep] = useState<'login' | 'otp'>('login');
  const [loginData, setLoginData] = useState<LoginData>({
    username: '',
    password: '',
  });
  const [otpData, setOtpData] = useState<OTPData>({
    login_token: '',
    otp: '',
  });
  const [isLoading, setIsLoading] = useState(false);
  const [telegramAccounts, setTelegramAccounts] = useState<TelegramAccount[]>([]);
  const [selectedLoginToken, setSelectedLoginToken] = useState<string | null>(null);
  const [otpSentToken, setOtpSentToken] = useState<string | null>(null);

  // Check if already logged in
  useEffect(() => {
    const token = localStorage.getItem('adminToken');
    if (token) {
      router.push('/admin/dashboard');
    }
  }, [router]);

  const handleLoginChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setLoginData(prev => ({ ...prev, [name]: value }));
  };

  const handleOtpChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setOtpData(prev => ({ ...prev, [name]: value }));
  };

  const handleLoginSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);

    try {
      const response = await fetch('/api/admin/login', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(loginData),
      });

      const data: LoginResponse = await response.json();

      if (!data.success) {
        throw new Error(data.message || 'Login failed');
      }

      const accounts = data.data?.telegram_accounts || [];
      if (accounts.length === 0) {
        throw new Error('No Telegram accounts configured');
      }

      setTelegramAccounts(accounts);
      setSelectedLoginToken(accounts[0].login_token);
      setOtpSentToken(null);
      setOtpData({ login_token: '', otp: '' });
      setStep('otp');
      toast.success(data.message);
    } catch (error) {
      toast.error(error instanceof Error ? error.message : 'Login failed');
    } finally {
      setIsLoading(false);
    }
  };

  const handleSendOtp = async (loginToken: string) => {
    setIsLoading(true);
    try {
      const response = await fetch('/api/admin/send-otp', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ login_token: loginToken }),
      });

      const data: LoginResponse = await response.json();

      if (!data.success || !data.data?.isOtpSend || !data.data.login_token) {
        throw new Error(data.message || 'Failed to send OTP');
      }

      setOtpSentToken(loginToken);
      setOtpData({ login_token: data.data.login_token, otp: '' });
      toast.success(data.message);
    } catch (error) {
      toast.error(error instanceof Error ? error.message : 'Failed to send OTP');
    } finally {
      setIsLoading(false);
    }
  };

  const handleOtpSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!otpSentToken) {
      toast.error('Please send the OTP to one of your Telegram accounts first');
      return;
    }
    setIsLoading(true);

    try {
      const response = await fetch('/api/admin/verify-otp', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          login_token: otpData.login_token,
          otp: otpData.otp,
        }),
      });

      const data: VerifyOtpResponse = await response.json();

      if (!data.success || !data.data) {
        throw new Error(data.message || 'OTP verification failed');
      }

      localStorage.setItem('adminToken', data.data.token);
      localStorage.setItem('adminData', JSON.stringify(data.data.admin));

      router.push('/admin/dashboard');
      toast.success(data.message);
    } catch (error) {
      toast.error(error instanceof Error ? error.message : 'OTP verification failed');
    } finally {
      setIsLoading(false);
    }
  };

  const handleResendOtp = async () => {
    if (selectedLoginToken === null) return;
    await handleSendOtp(selectedLoginToken);
  };

  return (
    <div className="min-h-screen bg-gray-900 text-gray-100 flex flex-col justify-center py-12 sm:px-6 lg:px-8">
      <Head>
        <title>Admin Login</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
      </Head>

      <Toaster
        position="top-center"
        toastOptions={{
          style: {
            background: '#1F2937',
            color: '#F3F4F6',
            border: '1px solid #374151',
          },
        }}
      />

      <div className="sm:mx-auto sm:w-full sm:max-w-md">
        <h2 className="mt-6 text-center text-3xl font-extrabold">
          Admin Portal
        </h2>
      </div>

      <div className="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
        <div className="bg-gray-800 py-8 px-4 shadow sm:rounded-lg sm:px-10 border border-gray-700">
          {step === 'login' ? (
            <form className="space-y-6" onSubmit={handleLoginSubmit}>
              <div>
                <label htmlFor="username" className="block text-sm font-medium">
                  Username
                </label>
                <div className="mt-1">
                  <input
                    id="username"
                    name="username"
                    type="text"
                    required
                    value={loginData.username}
                    onChange={handleLoginChange}
                    className="appearance-none block w-full px-3 py-2 border border-gray-600 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 bg-gray-700 sm:text-sm"
                  />
                </div>
              </div>

              <div>
                <label htmlFor="password" className="block text-sm font-medium">
                  Password
                </label>
                <div className="mt-1">
                  <input
                    id="password"
                    name="password"
                    type="password"
                    required
                    value={loginData.password}
                    onChange={handleLoginChange}
                    className="appearance-none block w-full px-3 py-2 border border-gray-600 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 bg-gray-700 sm:text-sm"
                  />
                </div>
              </div>

              <div>
                <button
                  type="submit"
                  disabled={isLoading}
                  className={`w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 ${isLoading ? 'opacity-70 cursor-not-allowed' : ''}`}
                >
                  {isLoading ? (
                    <span className="flex items-center">
                      <svg className="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                        <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                        <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                      </svg>
                      Signing in...
                    </span>
                  ) : 'Sign in'}
                </button>
              </div>
            </form>
          ) : (
            <form className="space-y-6" onSubmit={handleOtpSubmit}>
              <div className="text-center">
                <p className="text-sm text-gray-300">
                  Select which Telegram account should receive the OTP
                </p>
              </div>

              <div className="space-y-2">
                {telegramAccounts.map((account) => {
                  const isSelected = selectedLoginToken === account.login_token;
                  const isSentHere = otpSentToken === account.login_token;
                  return (
                    <label
                      key={account.login_token}
                      className={`flex items-center justify-between px-3 py-2 rounded-md border cursor-pointer transition-colors ${
                        isSelected
                          ? 'border-indigo-500 bg-gray-700'
                          : 'border-gray-600 bg-gray-750 hover:bg-gray-700'
                      }`}
                    >
                      <div className="flex items-center gap-3">
                        <input
                          type="radio"
                          name="telegram_account"
                          value={account.login_token}
                          checked={isSelected}
                          onChange={() => setSelectedLoginToken(account.login_token)}
                          className="h-4 w-4 text-indigo-600 focus:ring-indigo-500 border-gray-500"
                        />
                        <div className="flex flex-col">
                          <span className="text-sm font-medium text-gray-100">
                            {account.label}
                          </span>
                          <span className="text-xs text-gray-400">
                            @{account.tg_username}
                          </span>
                        </div>
                      </div>
                      {isSentHere && (
                        <span className="text-xs text-green-400">OTP sent</span>
                      )}
                    </label>
                  );
                })}
              </div>

              <div>
                <button
                  type="button"
                  onClick={() => selectedLoginToken !== null && handleSendOtp(selectedLoginToken)}
                  disabled={isLoading || selectedLoginToken === null}
                  className={`w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 ${isLoading ? 'opacity-70 cursor-not-allowed' : ''}`}
                >
                  {isLoading && otpSentToken === null ? 'Sending...' : 'Send OTP to selected account'}
                </button>
              </div>

              <div>
                <label htmlFor="otp" className="block text-sm font-medium">
                  OTP Code
                </label>
                <div className="mt-1">
                  <input
                    id="otp"
                    name="otp"
                    type="text"
                    inputMode="numeric"
                    pattern="[0-9]{6}"
                    maxLength={6}
                    required
                    value={otpData.otp}
                    onChange={handleOtpChange}
                    disabled={otpSentToken === null}
                    className="appearance-none block w-full px-3 py-2 border border-gray-600 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 bg-gray-700 sm:text-sm text-center tracking-widest disabled:opacity-50"
                    placeholder="••••••"
                  />
                </div>
              </div>

              <div className="flex items-center justify-between">
                <button
                  type="button"
                  onClick={handleResendOtp}
                  disabled={isLoading || selectedLoginToken === null}
                  className="text-sm text-indigo-400 hover:text-indigo-300 focus:outline-none"
                >
                  Resend OTP
                </button>
                <button
                  type="submit"
                  disabled={isLoading || otpSentToken === null}
                  className={`py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 ${isLoading || otpSentToken === null ? 'opacity-70 cursor-not-allowed' : ''}`}
                >
                  {isLoading ? 'Verifying...' : 'Verify'}
                </button>
              </div>
            </form>
          )}
        </div>
      </div>
    </div>
  );
}