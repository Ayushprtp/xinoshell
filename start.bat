@echo off
SETLOCAL

npm list -g pm2 || (
    echo Installing PM2 globally...
    npm install -g pm2
)

echo Installing dependencies...
npm install

echo Generating Prisma client and pushing schema...
npx prisma generate
npx prisma db push

echo Building Next.js project...
npm run build

echo Starting application with PM2...
pm2 delete next-app || echo No existing next-app process found
pm2 start npm --name "next-app" -- start
pm2 save
pm2 startup

echo Application started successfully!
echo To view logs: pm2 logs next-app
echo To monitor: pm2 monit

ENDLOCAL