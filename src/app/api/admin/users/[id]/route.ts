import { NextRequest, NextResponse } from 'next/server';
import { deleteUser, disableUser, getUserById, updateUserById, verifyAdmin } from '../../services/admin.service';

export async function GET(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  const isAdmin = verifyAdmin(request.headers.get('authorization'));
  if (!isAdmin || !isAdmin.isValid || !isAdmin.adminId) {
    return NextResponse.json(
      { success: false, message: 'Unauthorized', error: 'UNAUTHORIZED' },
      { status: 401 }
    );
  }

  const result = await getUserById(params.id);
  return NextResponse.json(result, { 
    status: result.success ? 200 : result.error === 'USER_NOT_FOUND' ? 404 : 400 
  });
}

export async function PATCH(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  const isAdmin = verifyAdmin(request.headers.get('authorization'));
  if (!isAdmin || !isAdmin.isValid || !isAdmin.adminId) {
    return NextResponse.json(
      { success: false, message: 'Unauthorized', error: 'UNAUTHORIZED' },
      { status: 401 }
    );
  }

  try {
    const payload = await request.json();
    const result = await updateUserById(params.id, payload);
    return NextResponse.json(result, { 
      status: result.success ? 200 : 
        result.error === 'USER_NOT_FOUND' ? 404 : 
        result.error === 'CONFLICT' ? 409 : 400 
    });
  } catch (error: any) {
    return NextResponse.json(
      { success: false, message: 'Invalid request body', error: 'BAD_REQUEST' },
      { status: 400 }
    );
  }
}

export async function DELETE(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  const isAdmin = verifyAdmin(request.headers.get('authorization'));
  if (!isAdmin || !isAdmin.isValid || !isAdmin.adminId) {
    return NextResponse.json(
      { success: false, message: 'Unauthorized', error: 'UNAUTHORIZED' },
      { status: 401 }
    );
  }

  const result = await deleteUser(params.id);
  return NextResponse.json(result, { 
    status: result.success ? 200 : result.error === 'USER_NOT_FOUND' ? 404 : 400 
  });
}

export async function POST(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  const isAdmin = verifyAdmin(request.headers.get('authorization'));
  if (!isAdmin || !isAdmin.isValid || !isAdmin.adminId) {
    return NextResponse.json(
      { success: false, message: 'Unauthorized', error: 'UNAUTHORIZED' },
      { status: 401 }
    );
  }

  const result = await disableUser(params.id);
  return NextResponse.json(result, { 
    status: result.success ? 200 : result.error === 'USER_NOT_FOUND' ? 404 : 400 
  });
}

export const dynamic = 'force-dynamic';