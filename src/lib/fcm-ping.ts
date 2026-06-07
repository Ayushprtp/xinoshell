import { toast } from 'sonner';

export async function sendNotification(token: string, title: string, body: string) {
  try {
    const response = await fetch('/api/fcm-send', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ token, title, body }),
    });

    if (!response.ok) {
      throw new Error('Failed to send notification');
    }

    return await response.json();
  } catch (error) {
    console.error('Notification error:', error);
    throw error;
  }
}

type FcmResponse = {
  status: 'success' | 'error';
  message: string;
  data?: any;
  code?: string;
};

export async function sendFcmNotification(token: string, title: string, body: string): Promise<FcmResponse> {
  const defaultOptions = {
    showToast: true,
    successMessage: 'Notification sent successfully!',
    errorMessage: 'Failed to send notification',
    ...Option,
  };

  try {
    const response = await fetch('/api/fcm-ping', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ token, title, body }),
    });

    const data: FcmResponse = await response.json();

    if (!response.ok) {
      throw new Error(data.message || defaultOptions.errorMessage);
    }

    if (defaultOptions.showToast) {
      toast.success(defaultOptions.successMessage);
    }

    return data;
  } catch (error: any) {
    console.error('FCM Error:', error);

    if (defaultOptions.showToast) {
      toast.error(error.message || defaultOptions.errorMessage);
    }

    return {
      status: 'error',
      message: error.message,
      code: error.code,
    };
  }
}