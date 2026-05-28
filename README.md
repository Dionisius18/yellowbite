# 🟡 YellowBite

> Aplikasi web rencana makan multi-hari dari isi kulkasmu. Built with Next.js + Supabase.

## 🛠 Tech Stack

- **Frontend**: Next.js 14 (App Router) + TypeScript + Tailwind CSS
- **Backend**: Supabase (PostgreSQL + Auth + Row Level Security)
- **Deploy**: Vercel (frontend) + Supabase (database)

## 📁 Struktur Proyek

```
yellowbite/
├── sql/                          # Database setup
│   ├── 001_schema.sql            # Tables + RLS + triggers
│   └── 002_seed.sql              # 53 bahan + 24 resep
├── src/
│   ├── app/
│   │   ├── layout.tsx            # Root layout + fonts
│   │   ├── page.tsx              # Redirect login/dashboard
│   │   ├── globals.css           # Tailwind imports
│   │   ├── login/page.tsx        # Halaman login
│   │   ├── register/page.tsx     # Halaman register
│   │   ├── dashboard/page.tsx    # Dashboard utama (protected)
│   │   └── auth/callback/route.ts # Handler konfirmasi email
│   ├── lib/supabase/
│   │   ├── client.ts             # Browser client
│   │   ├── server.ts             # Server client
│   │   └── middleware.ts         # Session refresher
│   ├── components/
│   │   └── LogoutButton.tsx
│   └── middleware.ts             # Route protection
├── .env.local                    # Kredensial Supabase (jangan di-commit!)
├── .env.example                  # Template kredensial
├── package.json
├── next.config.mjs
├── tailwind.config.ts
├── postcss.config.mjs
└── tsconfig.json
```

## 🚀 Setup Lokal

### 1. Install Dependencies
```bash
cd yellowbite
npm install
```

### 2. Pastikan `.env.local` Sudah Ada
File `.env.local` harus berisi:
```env
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
```

### 3. Setup Supabase Database
Sudah dijalankan di Fase 1. Kalau perlu reset:
1. Buka Supabase Dashboard → SQL Editor
2. Jalankan `sql/001_schema.sql`
3. Jalankan `sql/002_seed.sql`

### 4. Konfigurasi Email Provider (Supabase Auth)
Default Supabase mengirim email konfirmasi. Untuk development, di Supabase Dashboard:
- **Authentication → Sign In / Up → Email** → pastikan **"Confirm email"** aktif
- Untuk testing tanpa email: bisa di-nonaktifkan ("Confirm email" off → user langsung aktif)

### 5. Jalankan Dev Server
```bash
npm run dev
```

Buka [http://localhost:3000](http://localhost:3000).

## 🔐 Auth Flow

1. **Belum login** → redirect ke `/login`
2. **Klik "Daftar"** → masuk ke `/register` → input email + password
3. **Submit** → Supabase kirim email konfirmasi (kalau `Confirm email` aktif)
4. **Klik link di email** → redirect ke `/auth/callback` → session aktif → `/dashboard`
5. **Login berikutnya** → email + password di `/login` → `/dashboard`
6. **Logout** → tombol di header dashboard

## 🧱 Database Schema

| Tabel | Isi | Akses (RLS) |
|-------|-----|-------------|
| `ingredients` | 53 master bahan + satuan + makro | Read for `authenticated` |
| `recipes` | 24 resep + meal_type + hero | Read for `authenticated` |
| `recipe_ingredients` | Komposisi tiap resep | Read for `authenticated` |
| `inventory` | Isi kulkas per user | CRUD untuk pemilik (`auth.uid() = user_id`) |

## 🚢 Deploy ke Vercel

(Akan dilakukan di Fase 4)

1. Push ke GitHub
2. Connect repo di [vercel.com](https://vercel.com)
3. Set env vars (`NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_ANON_KEY`)
4. Deploy otomatis dari `main` branch

## 📜 Lisensi

MIT
