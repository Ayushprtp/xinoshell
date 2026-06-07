# xinoshell — securityguard

Private control panel for the **securityguard** Android remote-management app. Builds customized APKs from a web UI, manages users, and brokers socket connections to installed devices.

> Originally developed under `securityguard`, this repo is the home of the admin panel and build pipeline.

---

## What it does

- **APK Builder** — `/builder` UI lets an admin pick permissions (camera, SMS, location, call logs, contacts, etc.) and emits a signed, customized APK.
- **User management** — admins manage client users, set expiry, toggle 2FA, ban/enable.
- **Live device session** — Socket.IO bridge relays commands and events between the panel and devices that have registered the build.
- **Multi-account Telegram 2FA** — admin login uses Telegram OTPs delivered to any of the admin's registered Telegram accounts (selector in the login UI).

---

## Stack

- **Next.js 15** (custom server via `server.js`) + **React 19** + **TypeScript**
- **Prisma** with **MongoDB**
- **Socket.IO** for live device communication
- **Telegram Bot API** for OTP delivery
- **Firebase Cloud Messaging** for push notifications
- **apktool** + **apksigner** for APK repackaging/signing (in `apk-resources/`)

---

## Project layout

```
.
├── server.js                    # Custom Next.js server (port from .env, default 3000)
├── socketServer.js              # Socket.IO server attached to the http server
├── start.sh / start.bat         # Production bootstrap (npm install → build → pm2)
├── src/
│   ├── app/                     # Next.js app router (UI + API routes)
│   │   ├── admin/               # Admin login + dashboard
│   │   ├── builder/             # APK builder UI
│   │   └── api/                 # REST endpoints
│   │       ├── admin/           # Admin auth + user CRUD
│   │       ├── auth/            # Client user auth
│   │       ├── build-apk/       # APK build pipeline
│   │       ├── client/          # Client-side device APIs
│   │       └── ...
│   ├── components/              # Shared React components
│   ├── context/                 # React context providers
│   └── lib/                     # Prisma client, constants, utilities
├── prisma/
│   └── schema.prisma            # MongoDB models (User, Device, SmsMessage, adminOtp, ...)
├── apk-resources/               # apktool.jar, apksigner.jar, template manifest
├── types/                       # TypeScript type definitions
├── public/                      # Static assets
├── scripts/                     # Helper scripts
├── admin.json                   # Admin credentials (see Security)
└── .env                         # Environment variables (see Configuration)
```

---

## Local development

```bash
# 1. Install
npm install

# 2. Configure
cp .env.example .env   # then fill in MONGODB_URI, TELEGRAM_BOT_TOKEN, JWT_SECRET, ...
# Also create admin.json with at least one admin entry (see admin.json.example if present)

# 3. Database
npx prisma generate
npx prisma db push

# 4. Run
npm run dev           # Next.js dev server (hot reload)
```

The dev server reads `PORT` from `.env` (defaults to 3000). The custom server attaches Socket.IO on the same port.

---

## Production

```bash
npm run build
pm2 start npm --name "securityguard" -- start
pm2 save
pm2 startup           # follow the printed sudo command to enable boot autostart
```

Or use the bundled `start.sh` which does the above in one shot.

---

## Configuration

All configuration is environment-driven via `.env`. Required variables:

| Variable | Purpose |
|----------|---------|
| `MONGODB_URI` | MongoDB connection string (e.g. `mongodb://127.0.0.1:27017/securityguard?replicaSet=rs0`) |
| `TELEGRAM_BOT_TOKEN` | Bot token for OTP delivery |
| `JWT_SECRET` | Secret for signing admin session tokens |
| `PORT` | HTTP port (default 3000) |
| `NODE_ENV` | `production` for prod runs |

### `admin.json` shape

```json
[
  {
    "_id": "uuid-v4",
    "name": "Display Name",
    "username": "login-name",
    "password": "plaintext-not-hashed",
    "telegram_accounts": [
      { "label": "ProAyu",  "tg_id": 8016964972, "tg_username": "ProAyu" }
    ],
    "last_login": "ISO-8601 or null",
    "registeredOn": "ISO-8601"
  }
]
```

Each admin can have multiple `telegram_accounts`. The login flow shows a radio selector; OTPs are locked to the chosen account.

---

## Admin login flow (Telegram 2FA)

1. **POST `/api/admin/login`** with `{username, password}` — returns a list of `telegram_accounts` and a per-account `login_token`. The `tg_id` never crosses the wire.
2. **POST `/api/admin/send-otp`** with `{login_token}` — server looks up the account, generates an OTP, sends it via Telegram, returns a fresh `login_token` for the verify step.
3. **POST `/api/admin/verify-otp`** with `{login_token, otp}` — server validates the OTP against the (username, tg_id) pair, issues a JWT, returns the admin record (with `tg_id` stripped).

`login_token`s are 24 random bytes, single-use, 5-minute TTL. The server keeps an in-memory map; server restart invalidates all in-flight logins (acceptable — clients see "session expired" and re-auth).

---

## API surface (high level)

| Path | Purpose |
|------|---------|
| `POST /api/admin/login` | Step 1 of admin login (returns account list) |
| `POST /api/admin/send-otp` | Step 2: send OTP to a chosen account |
| `POST /api/admin/verify-otp` | Step 3: verify OTP, issue JWT |
| `GET  /api/admin/users` | List client users |
| `POST /api/admin/users` | Create client user |
| `PATCH /api/admin/users/:id` | Update client user |
| `POST /api/build-apk` | Build a customized APK |
| `POST /api/auth` | Client user login (password) |
| `POST /api/auth/user` | Client user OTP verify |
| `GET  /api/client/devices` | List a user's devices |
| `GET  /api/client/devices/:id/media` | List a device's media |
| Socket.IO | Real-time device ↔ panel events (see `socketServer.js`) |

---

## Security notes

- Admin passwords in `admin.json` are **plaintext** — rotate by editing the file directly and restarting the process.
- `tg_id` is never sent to the client (the login flow uses opaque `login_token`s).
- OTPs are 6 digits, 2-minute TTL, single-use. No rate limiting on the login endpoints (a known gap — fix before public exposure).
- `.env` contains the Telegram bot token, JWT secret, MongoDB URI, and FCM credentials. **Do not commit `.env` to a public repo.**

---

## License

Private / unlicensed.
