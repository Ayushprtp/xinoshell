export interface IpInfo {
  ip: string | null;
  version?: string;
  city?: string;
  region?: string;
  region_code?: string;
  country_code?: string;
  country_name?: string;
  country_capital?: string;
  continent_code?: string;
  in_eu?: boolean;
  postal?: string;
  latitude?: number;
  longitude?: number;
  timezone?: string;
  utc_offset?: string;
  country_calling_code?: string;
  currency?: string;
  currency_name?: string;
  languages?: string;
  country_area?: number;
  country_population?: number;
  asn?: string;
  org?: string;
  hostname?: string;
}

export const getPublicIp = async (): Promise<string> => {
  try {
    const response = await fetch('https://api.ipify.org?format=json');
    if (!response.ok) throw new Error('Failed to fetch IP from ipify');
    
    const data = await response.json();
    return data.ip;
  } catch (error) {
    console.error('Failed to get public IP:', error);
    throw error;
  }
};

export const getIpInfo = async (ip?: string): Promise<IpInfo> => {
  const targetIp = ip || (await getPublicIp());
  const url = `https://ipapi.co/${targetIp}/json/`;

  try {
    const response = await fetch(url);
    
    if (!response.ok) {
      throw new Error(`IP lookup failed with status ${response.status}`);
    }

    const data: IpInfo = await response.json();
    
    return data;
  } catch (error) {
    console.error('Error fetching IP info:', error);
    throw new Error(`Could not retrieve information for IP ${targetIp}`);
  }
};

export const getDeviceInfo = async (): Promise<{
  ipAddress: string | null;
  userAgent: string;
}> => {
  try {
    const ipInfo = await getIpInfo();
    return {
      ipAddress: ipInfo.ip,
      userAgent: typeof window !== 'undefined' ? navigator.userAgent : 'Server',
    };
  } catch (error) {
    console.error('Error getting device info:', error);
    try {
      const ip = await getPublicIp();
      return {
        ipAddress: ip,
        userAgent: typeof window !== 'undefined' ? navigator.userAgent : 'Server',
      };
    } catch (e) {
      console.error('Failed to get public IP as fallback:', e);
      return {
        ipAddress: "0.0.0.0",
        userAgent: typeof window !== 'undefined' ? navigator.userAgent : 'Server',
      };
    }
  }
};