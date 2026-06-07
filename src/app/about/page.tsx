import AboutPage from '../components/about';
import ProtectedRoute from '../components/ProtectedRoute';
import Sidebar from '../components/Sidebar';

export default function ProfilePage() {
  return (
   <>
   <ProtectedRoute>
   <Sidebar/>
   <AboutPage />
   </ProtectedRoute>
   </>
  )
}