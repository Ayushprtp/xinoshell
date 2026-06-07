'use client';

import { IpInfo } from '@/lib/network';
import { useEffect, useState } from 'react';
import dynamic from 'next/dynamic';
import { FiX } from 'react-icons/fi';

const MapContainer = dynamic(
  () => import('react-leaflet').then((mod) => mod.MapContainer),
  { ssr: false }
);
const TileLayer = dynamic(
  () => import('react-leaflet').then((mod) => mod.TileLayer),
  { ssr: false }
);
const Marker = dynamic(
  () => import('react-leaflet').then((mod) => mod.Marker),
  { ssr: false }
);
const Popup = dynamic(
  () => import('react-leaflet').then((mod) => mod.Popup),
  { ssr: false }
);

interface DeviceLocationPopupProps {
  ipInfo: IpInfo | null;
  onClose: () => void;
}

export const DeviceLocationPopup = ({ ipInfo, onClose }: DeviceLocationPopupProps) => {
  const [isClient, setIsClient] = useState(false);

  useEffect(() => {
    setIsClient(true);
  }, []);

  if (!ipInfo || !ipInfo.latitude || !ipInfo.longitude) {
    return (
      <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
        <div className="bg-gray-800 rounded-lg p-6 w-full max-w-md border border-gray-700">
          <div className="flex justify-between items-center mb-4">
            <h3 className="text-xl font-bold">Device Location</h3>
            <button onClick={onClose} className="text-gray-400 hover:text-white">
              <FiX size={24} />
            </button>
          </div>
          <p className="text-gray-300">Location data not available for this device</p>
        </div>
      </div>
    );
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
      <div className="bg-gray-800 rounded-lg p-6 w-full max-w-4xl border border-gray-700">
        <div className="flex justify-between items-center mb-4">
          <h3 className="text-xl font-bold">Device Location</h3>
          <button onClick={onClose} className="text-gray-400 hover:text-white">
            <FiX size={24} />
          </button>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div className="md:col-span-2 h-96 rounded-lg overflow-hidden">
            {isClient && (
              <MapContainer
                center={[ipInfo.latitude, ipInfo.longitude]}
                zoom={13}
                style={{ height: '100%', width: '100%' }}
              >
                <TileLayer
                  url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
                  attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
                />
                <Marker position={[ipInfo.latitude, ipInfo.longitude]}>
                  <Popup>
                    <div className="text-gray-800">
                      <p className="font-bold">{ipInfo.city || 'Unknown city'}, {ipInfo.country_name || 'Unknown country'}</p>
                      <p>IP: {ipInfo.ip}</p>
                    </div>
                  </Popup>
                </Marker>
              </MapContainer>
            )}
          </div>

          <div className="bg-gray-700 p-4 rounded-lg">
            <h4 className="font-bold text-lg mb-4 border-b border-gray-600 pb-2">Device Details</h4>
            <div className="space-y-3">
              <div>
                <p className="text-gray-400 text-sm">IP Address</p>
                <p className="font-medium">{ipInfo.ip || 'Unknown'}</p>
              </div>
              <div>
                <p className="text-gray-400 text-sm">Location</p>
                <p className="font-medium">
                  {ipInfo.city || 'Unknown city'}, {ipInfo.region || 'Unknown region'}, {ipInfo.country_name || 'Unknown country'}
                </p>
              </div>
              <div>
                <p className="text-gray-400 text-sm">Coordinates</p>
                <p className="font-medium">
                  {ipInfo.latitude?.toFixed(4)}, {ipInfo.longitude?.toFixed(4)}
                </p>
              </div>
              <div>
                <p className="text-gray-400 text-sm">ISP</p>
                <p className="font-medium">{ipInfo.org || 'Unknown'}</p>
              </div>
              <div>
                <p className="text-gray-400 text-sm">Timezone</p>
                <p className="font-medium">{ipInfo.timezone || 'Unknown'}</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};