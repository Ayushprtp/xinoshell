import Dashboard from "./components/Dashboard";
import ProtectedRoute from "./components/ProtectedRoute";
import Sidebar from "./components/Sidebar";

export default function Home() {
  return (
    <>
      <ProtectedRoute>
        <Sidebar />
        <Dashboard />
      </ProtectedRoute>
    </>
  );
}
