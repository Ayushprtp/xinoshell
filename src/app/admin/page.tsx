'use client';

import { useRouter } from 'next/navigation';
import { useEffect } from 'react';

export default function AdminRootPage() {
  const router = useRouter();

  useEffect(() => {
    const token = localStorage.getItem('adminToken');
    
    if (token) {
      router.push('/admin/dashboard');
    } else {
      router.push('/admin/login');
    }
  }, [router]);

  return (
    <div className="flex items-center justify-center min-h-screen">
      <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-indigo-500"></div>
    </div>
  );
}