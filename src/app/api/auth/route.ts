import { NextRequest, NextResponse } from 'next/server';
import { authenticateUser, verifyTwoFactor } from './services/auth.service';

export async function POST(request: NextRequest) {
  try {
    const payload = await request.json();
    if (payload.logout) {
      const response = NextResponse.json(
        { success: true, message: 'Logged out successfully' },
        { status: 200 }
      );
      return response;
    }

    const loginPayload = {
      ...payload,
      deviceInfo: {
        status: true,
        ipAddress: payload.deviceInfo?.ipAddress || 'Unknown',
        userAgent: payload.deviceInfo?.userAgent || 'Unknown',
      },
    };

    let result;

    if (payload.otp && payload.userId) {
      result = await verifyTwoFactor(loginPayload);
    } else {
      result = await authenticateUser(loginPayload);
    }

    if (result.success && result.data?.token) {
      const token = result.data.token;
      if (!token) {
        return NextResponse.json(
          {
            success: false,
            message: 'Authentication failed - no token provided',
          },
          { status: 401 }
        );
      }

      const response = NextResponse.json(
        {
          success: true,
          message: result.message,
          data: result.data,
        },
        { status: 200 }
      );

      return response;
    }

    return NextResponse.json(result, { status: 401 });
  } catch (error) {
    return NextResponse.json(
      {
        success: false,
        message: 'Internal server error',
        error: 'INTERNAL_SERVER_ERROR',
      },
      { status: 500 }
    );
  }
}