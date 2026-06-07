export class EventStreamResponse {
  private controller: ReadableStreamDefaultController | undefined;
  private stream: ReadableStream;
  private heartbeatInterval: NodeJS.Timeout | undefined;

  constructor() {
    this.stream = new ReadableStream({
      start: (controller) => {
        this.controller = controller;
        this.heartbeatInterval = setInterval(() => {
          this.send({ 
            type: 'heartbeat', 
            message: 'keepalive',
            timestamp: new Date().toISOString() 
          });
        }, 25000);
      },
      cancel: () => {
        this.close();
      }
    });
  }

  send(data: Record<string, any>) {
    try {
      if (!data.type) data.type = 'log';
      if (!data.message) data.message = '';
      if (!data.timestamp) data.timestamp = new Date().toISOString();
      
      const payload = `data: ${JSON.stringify(data)}\n\n`;
      this.controller?.enqueue(new TextEncoder().encode(payload));
    } catch (error) {
      console.error('SSE send error:', error);
    }
  }

  close() {
    clearInterval(this.heartbeatInterval);
    try {
      this.controller?.close();
    } catch (error) {
      console.error('SSE close error:', error);
    }
  }

  get response() {
    return new Response(this.stream, {
      headers: {
        'Content-Type': 'text/event-stream',
        'Cache-Control': 'no-cache',
        'Connection': 'keep-alive'
      }
    });
  }
}