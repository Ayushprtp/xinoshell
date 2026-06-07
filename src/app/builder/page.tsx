'use client';
import Builder from '../components/Builder';
import ProtectedRoute from '../components/ProtectedRoute';
import Sidebar from '../components/Sidebar';

export default function BuilderPage() {
  return (
   <>
   <ProtectedRoute>
   <Sidebar/>
   <Builder />
   </ProtectedRoute>
   </>
  )
}