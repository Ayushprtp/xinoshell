import Dashboard from '../components/Dashboard';
import ProtectedRoute from '../components/ProtectedRoute';
import Sidebar from '../components/Sidebar';

export default function Page() {
  return (
   <>
   <ProtectedRoute>
   <Sidebar/>
   <Dashboard />
   </ProtectedRoute>
   </>

  )
}