import { NextResponse } from 'next/server';
import fs from 'fs';
import path from 'path';
import sharp from 'sharp';
import prisma from '@/lib/prisma';

const ALLOWED_FILE_TYPES = [
  'image/jpeg', 'image/png', 'image/gif', 'image/webp',
  'application/json',
  'text/plain'
];
const MAX_FILE_SIZE = 5 * 1024 * 1024;
const UPLOAD_DIR = path.join(process.cwd(), 'public/uploads');

if (!fs.existsSync(UPLOAD_DIR)) {
  fs.mkdirSync(UPLOAD_DIR, { recursive: true });
}

export async function POST(request: Request) {
  try {
    const formData = await request.formData();
    const file = formData.get('file');
    const userId = formData.get('userId');
    const deviceId = formData.get('deviceId');
    const fileType = formData.get('fileType');

    if (!deviceId || typeof deviceId !== 'string') {
      return NextResponse.json(
        { error: 'Valid device ID is required' },
        { status: 400 }
      );
    }
    if (!userId || typeof userId !== 'string') {
      return NextResponse.json(
        { error: 'Valid user ID is required' },
        { status: 400 }
      );
    }

    const existingDevice = await prisma.clientDevice.findUnique({
      where: { userId: userId, deviceId: deviceId },
      select: { id: true }
    });

    if (!existingDevice) {
      return NextResponse.json(
        { error: 'Device not found in database' },
        { status: 404 }
      );
    }

    if (!file || typeof file === 'string') {
      return NextResponse.json(
        { error: 'No file uploaded' },
        { status: 400 }
      );
    }
    if (!ALLOWED_FILE_TYPES.includes(file.type)) {
      return NextResponse.json(
        { error: 'Invalid file type' },
        { status: 400 }
      );
    }

    if (file.size > MAX_FILE_SIZE) {
      return NextResponse.json(
        { error: `File too large. Max size is ${MAX_FILE_SIZE/1024/1024}MB` },
        { status: 413 }
      );
    }

    const buffer = Buffer.from(await file.arrayBuffer());
    let finalFilename = '';
    let finalPath = '';
    let publicUrl = '';
    let updateData = {};

    if (file.type.startsWith('image/')) {
      finalFilename = `image_${deviceId}.png`;
      finalPath = path.join(UPLOAD_DIR, finalFilename);
      publicUrl = `/uploads/${finalFilename}`;
      
      await sharp(buffer)
        .png()
        .toFile(finalPath);
      
      updateData = { imgUrl: publicUrl };
    } 
    else if (file.type === 'application/json') {
      if (!fileType || (fileType !== 'logs' && fileType !== 'contacts')) {
        return NextResponse.json(
          { error: 'For JSON files, fileType must be either "logs" or "contacts"' },
          { status: 400 }
        );
      }
    

      const timestamp = Date.now();
      finalFilename = `${fileType}_${deviceId}_${timestamp}.json`;
      finalPath = path.join(UPLOAD_DIR, finalFilename);
      publicUrl = `/uploads/${finalFilename}`;
      
      fs.writeFileSync(finalPath, buffer);
      
      updateData = fileType === 'logs' 
        ? { callLogsUri: publicUrl } 
        : { contactsUri: publicUrl };
    }
    else if (file.type === 'text/plain') {
      const timestamp = Date.now();
      finalFilename = `text_${deviceId}_${timestamp}.txt`;
      finalPath = path.join(UPLOAD_DIR, finalFilename);
      publicUrl = `/uploads/${finalFilename}`;
      
      fs.writeFileSync(finalPath, buffer);
      
    
    }

    if (Object.keys(updateData).length > 0) {
      try {
        await prisma.clientDevice.update({
          where: { deviceId },
          data: updateData
        });
      } catch (updateError) {
        console.error('Failed to update device:', updateError);
        return NextResponse.json(
          { error: 'Failed to update device information' },
          { status: 500 }
        );
      }
    }

    return NextResponse.json({ 
      success: true,
      filename: finalFilename,
      path: publicUrl,
      size: fs.statSync(finalPath).size,
      mimetype: file.type
    });

  } catch (error) {
    console.error('Upload error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

const scheduleFileDeletion = (filePath: string, deviceId: string, urlType: 'imgUrl' | 'callLogsUri' | 'contactsUri') => {
  setTimeout(async () => {
    try {
      if (fs.existsSync(filePath)) {
        fs.unlinkSync(filePath);
        console.log(`Deleted file: ${filePath}`);
        
        // Clear the URL in database
        await prisma.clientDevice.update({
          where: { deviceId },
          data: { [urlType]: null }
        });
      }
    } catch (error) {
      console.error('Error deleting file:', error);
    }
  }, 60000); // 1 minute = 60,000 ms
};

export async function GET(request: Request) {
  try {
    const { searchParams } = new URL(request.url);
    const fileUrl = searchParams.get('url');
    const userId = searchParams.get('userId');
    const deviceId = searchParams.get('deviceId');

    if (!fileUrl || !userId || !deviceId) {
      return NextResponse.json(
        { error: 'Missing required parameters (url, userId, deviceId)' },
        { status: 400 }
      );
    }

    const device = await prisma.clientDevice.findUnique({
      where: { deviceId, userId }
    });

    if (!device) {
      return NextResponse.json(
        { error: 'Device not found for this user' },
        { status: 404 }
      );
    }

    let urlType: 'imgUrl' | 'callLogsUri' | 'contactsUri' | null = null;
    if (device.imgUrl === fileUrl) {
      urlType = 'imgUrl';
    } else if (device.callLogsUri === fileUrl) {
      urlType = 'callLogsUri';
    } else if (device.contactsUri === fileUrl) {
      urlType = 'contactsUri';
    }

    if (!urlType) {
      return NextResponse.json(
        { error: 'File not associated with this device' },
        { status: 403 }
      );
    }

    // Extract filename from URL
    const filename = fileUrl.split('/').pop();
    if (!filename) {
      return NextResponse.json(
        { error: 'Invalid file URL' },
        { status: 400 }
      );
    }

    const filePath = path.join(UPLOAD_DIR, filename);

    if (!fs.existsSync(filePath)) {
      return NextResponse.json(
        { error: 'File not found on server' },
        { status: 404 }
      );
    }

    // Read file data
    const fileData = fs.readFileSync(filePath);
    const fileStats = fs.statSync(filePath);

    // Determine content type based on file extension
    let contentType = 'application/octet-stream';
    if (filename.endsWith('.png')) {
      contentType = 'image/png';
    } else if (filename.endsWith('.json')) {
      contentType = 'application/json';
    } else if (filename.endsWith('.txt')) {
      contentType = 'text/plain';
    }

    // Schedule file deletion after 1 minute
    scheduleFileDeletion(filePath, deviceId, urlType);

    // Create response with file data
    const response = new NextResponse(fileData, {
      status: 200,
      headers: {
        'Content-Type': contentType,
        'Content-Length': fileStats.size.toString(),
        'Content-Disposition': `attachment; filename="${filename}"`
      }
    });

    return response;

  } catch (error) {
    console.error('File download error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

export const config = {
  api: {
    bodyParser: false
  }
};