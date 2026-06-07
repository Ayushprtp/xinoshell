import { NextResponse } from 'next/server';
import { adminLogin } from '../services/admin.service';


export async function POST(request: Request) {
  try {
    const payload = await request.json();
    const result = await adminLogin(payload);
    return NextResponse.json(result, { 
      status: result.success ? 200 : result.error === 'INVALID_CREDENTIALS' ? 401 : 400 
    });
  } catch (error) {
    return NextResponse.json(
      { success: false, message: 'Invalid request body', error: 'BAD_REQUEST' },
      { status: 400 }
    );
  }
}

export const dynamic = 'force-dynamic';