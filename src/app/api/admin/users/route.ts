import { NextRequest, NextResponse } from 'next/server';
import { createUser, getAllUsers, verifyAdmin } from '../services/admin.service';

export async function GET(request: NextRequest) {
  const isAdmin = verifyAdmin(request.headers.get('authorization'));
  if (!isAdmin || !isAdmin.isValid || !isAdmin.adminId) {
    return NextResponse.json(
      { success: false, message: 'Unauthorized', error: 'UNAUTHORIZED' },
      { status: 401 }
    );
  }

  const result = await getAllUsers();
  return NextResponse.json(result, { status: result.success ? 200 : 400 });
}

export async function POST(request: NextRequest) {
  const isAdmin = verifyAdmin(request.headers.get('authorization'));
  if (!isAdmin || !isAdmin.isValid || !isAdmin.adminId) {
    return NextResponse.json(
      { success: false, message: 'Unauthorized', error: 'UNAUTHORIZED' },
      { status: 401 }
    );
  }
  
  try {
    const payload = await request.json();
    const result = await createUser(payload);
    return NextResponse.json(result, { 
      status: result.success ? 201 : 
        result.error === 'USER_EXISTS' ? 409 : 400 
    });
  } catch (error) {
    return NextResponse.json(
      { success: false, message: 'Invalid request body', error: 'BAD_REQUEST' },
      { status: 400 }
    );
  }
}

export const dynamic = 'force-dynamic';