"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import { createClient } from "@/lib/supabase/client";

export default function LoginPage() {
  const router = useRouter();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setError(null);
    setLoading(true);

    const supabase = createClient();
    const { error } = await supabase.auth.signInWithPassword({ email, password });

    if (error) {
      setError(error.message);
      setLoading(false);
      return;
    }

    router.push("/dashboard");
    router.refresh();
  }

  return (
    <main className="min-h-screen flex items-center justify-center px-4">
      <div className="w-full max-w-md">
        <div className="text-center mb-8">
          <div className="inline-flex items-center gap-2 mb-3">
            <span className="text-3xl">🟡</span>
            <h1 className="text-3xl font-bold tracking-tight">YellowBite</h1>
          </div>
          <p className="text-ink-muted italic font-display">Masuk ke dapurmu.</p>
        </div>

        <form
          onSubmit={handleSubmit}
          className="bg-white border border-amber-100 rounded-2xl p-7 shadow-sm space-y-4"
        >
          <div>
            <label htmlFor="email" className="block text-xs font-bold uppercase tracking-wider text-ink-muted mb-1.5">
              Email
            </label>
            <input
              id="email"
              type="email"
              required
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="w-full px-4 py-2.5 border-2 border-amber-100 rounded-lg focus:border-primary focus:ring-2 focus:ring-primary/25 outline-none transition"
              placeholder="kamu@email.com"
            />
          </div>

          <div>
            <label htmlFor="password" className="block text-xs font-bold uppercase tracking-wider text-ink-muted mb-1.5">
              Password
            </label>
            <input
              id="password"
              type="password"
              required
              minLength={6}
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className="w-full px-4 py-2.5 border-2 border-amber-100 rounded-lg focus:border-primary focus:ring-2 focus:ring-primary/25 outline-none transition"
              placeholder="••••••••"
            />
          </div>

          {error && (
            <div className="bg-red-50 border-l-4 border-red-500 text-red-700 text-sm p-3 rounded">
              {error}
            </div>
          )}

          <button
            type="submit"
            disabled={loading}
            className="w-full bg-primary hover:bg-primary-dark text-ink font-bold py-3 rounded-lg shadow-sm transition disabled:opacity-50"
          >
            {loading ? "Sedang masuk…" : "Masuk"}
          </button>
        </form>

        <p className="text-center text-sm text-ink-muted mt-5">
          Belum punya akun?{" "}
          <Link href="/register" className="text-accent font-semibold hover:underline">
            Daftar di sini
          </Link>
        </p>
      </div>
    </main>
  );
}
