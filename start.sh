#!/bin/bash

# 💡 Function to print log with emoji
log() {
  echo -e "$1 $2"
}

# 📂 Load .env file
if [ -f .env ]; then
    log "📄" "Loading environment variables from .env..."
    export $(grep -v '^#' .env | xargs)
else
    log "❌" ".env file not found! Aborting."
    exit 1
fi

# 🔍 Verify environment variables
log "🔍" "Verifying exported environment variables..."
while read -r line || [ -n "$line" ]; do
    [[ "$line" =~ ^#.*$ || -z "$line" ]] && continue
    VAR_NAME=$(echo "$line" | cut -d= -f1)
    if [ -z "${!VAR_NAME}" ]; then
        log "⚠️" "Missing: $VAR_NAME"
    else
        log "✅" "$VAR_NAME=${!VAR_NAME}"
    fi
done < .env

# 🛠 Install PM2 if needed
if ! command -v pm2 &> /dev/null; then
    log "⬇️" "Installing PM2 globally..."
    npm install -g pm2
else
    log "✔️" "PM2 is already installed."
fi

# 📦 Install dependencies
log "📦" "Installing Node.js dependencies..."
npm install

# 🔧 Generate Prisma client and push schema
log "🛠️" "Generating Prisma client and pushing schema..."
npx prisma generate
npx prisma db push

# 🏗️ Build the Next.js app
log "🏗️" "Building Next.js project..."
npm run build

# 🚀 Start the app with PM2
log "🚀" "Starting application with PM2..."
pm2 delete next-app || true
pm2 start npm --name "next-app" -- start
pm2 save
pm2 startup
pm2 resurrect
log "🗑️" "cleaning source file..."
rm -r src 
log "✅" "Application started with PM2."
# ✅ Final message
log "🎉" "Application started successfully!"
log "📜" "To view logs: pm2 logs next-app"
log "📊" "To monitor: pm2 monit"
