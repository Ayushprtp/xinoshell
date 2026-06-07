import 'dotenv/config';
import { createServer } from 'http';
import { parse } from 'url';
import next from 'next';
import cors from 'cors';
import { initSocketServer } from './socketServer.js';

const port = parseInt(process.env.PORT || '3000', 10);
const dev = process.env.NODE_ENV !== 'production';
const app = next({ dev });
const handle = app.getRequestHandler();

app.prepare().then(() => {
  const corsMiddleware = cors({
    origin: '*',
    methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['*'],
    credentials: true,
  });

  const server = createServer((req, res) => {
    corsMiddleware(req, res, () => {
      const parsedUrl = parse(req.url, true);
      handle(req, res, parsedUrl);
    });
  });

  initSocketServer(server);

  server.listen(port, () => {
    console.log(`> Ready on http://localhost:${port}`);
  });
});