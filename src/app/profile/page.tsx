import Profile from '../components/profile';
import Sidebar from '../components/Sidebar';
import ProtectedRoute from '../components/ProtectedRoute';

export default function ProfilePage() {
  return (
   <>
   <ProtectedRoute>
   <Sidebar/>
   <Profile />
   </ProtectedRoute>
   </>
  )
}