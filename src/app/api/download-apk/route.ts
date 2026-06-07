import { NextResponse } from 'next/server';
import fs from 'fs';
import path from 'path';

const filesToDelete = new Map<string, NodeJS.Timeout>();

export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const filename = searchParams.get('filename');
  if (!filename || filename.includes('..') || filename.includes('/') || filename.includes('\\')) {
    return new NextResponse('Invalid filename', { status: 400 });
  }
  const publicDir = path.join(process.cwd(), 'public', 'apks');
  const filePath = path.join(publicDir, filename);

  try {
    if (!fs.existsSync(filePath)) {
      return new NextResponse('File not found', { status: 404 });
    }
    const fileBuffer = fs.readFileSync(filePath);
    const fileStats = fs.statSync(filePath);
    scheduleFileDeletion(filePath);
    const response = new NextResponse(fileBuffer);
    response.headers.set('Content-Type', 'application/vnd.android.package-archive');
    response.headers.set('Content-Length', fileStats.size.toString());
    response.headers.set('Content-Disposition', `attachment; filename="${filename}"`);
    
    return response;
  } catch (error) {
    console.error('Download error:', error);
    return new NextResponse('Download failed', { status: 500 });
  }
}

function scheduleFileDeletion(filePath: string) {
  const existingTimeout = filesToDelete.get(filePath);
  if (existingTimeout) {
    clearTimeout(existingTimeout);
  }
  const timeout = setTimeout(() => {
    try {
      if (fs.existsSync(filePath)) {
        fs.unlinkSync(filePath);
        console.log(`Deleted file: ${filePath}`);
      }
    } catch (err) {
      console.error(`Error deleting file ${filePath}:`, err);
    } finally {
      filesToDelete.delete(filePath);
    }
  }, 5 * 60 * 1000);

  filesToDelete.set(filePath, timeout);
}