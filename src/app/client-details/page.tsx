import { Suspense } from "react";
import Sidebar from "../components/Sidebar";
import DevicePage from "./DevicePage";

export default function DetailsPage() {
  return (
    <>
      <Sidebar />
      <Suspense fallback={<div>Loading client details...</div>}>
        <DevicePage />
      </Suspense>
    </>
  );
}
