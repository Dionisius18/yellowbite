-- ============================================================
-- YellowBite — Database Schema (Supabase / PostgreSQL)
-- Jalankan di: Supabase Dashboard → SQL Editor → New query
-- ============================================================

-- ---------- 1. INGREDIENTS (master list, shared) ----------
create table public.ingredients (
  name              text primary key,
  base_unit         text not null,
  available_units   jsonb not null,           -- {"Gram": 1, "Kg": 1000}
  is_base           boolean default false,    -- true = bumbu dasar (bypass cek kuantitas)
  emoji             text,
  macros            jsonb                     -- {"kcal":1.65,"protein":0.31,"carbs":0,"fat":0.036}
);

-- ---------- 2. RECIPES (master, shared) ----------
create table public.recipes (
  id              serial primary key,
  recipe_name     text not null,
  meal_type       text not null check (meal_type in ('Sarapan','Siang','Malam')),
  instructions    text not null,
  hero_emoji      text,
  hero_gradient   jsonb                      -- ["#FFE082","#FFB300"]
);

create index recipes_meal_type_idx on public.recipes(meal_type);

-- ---------- 3. RECIPE_INGREDIENTS (junction) ----------
create table public.recipe_ingredients (
  recipe_id         integer references public.recipes(id) on delete cascade,
  ingredient_name   text references public.ingredients(name) on delete cascade,
  required_weight   numeric(10,2) not null,
  primary key (recipe_id, ingredient_name)
);

-- ---------- 4. INVENTORY (per-user, "isi kulkas") ----------
create table public.inventory (
  id                uuid primary key default gen_random_uuid(),
  user_id           uuid references auth.users(id) on delete cascade not null,
  ingredient_name   text references public.ingredients(name) on delete restrict not null,
  weight            numeric(10,2) not null check (weight > 0),  -- selalu dalam base_unit
  created_at        timestamptz default now(),
  updated_at        timestamptz default now(),
  unique (user_id, ingredient_name)    -- satu user hanya satu baris per bahan
);

create index inventory_user_id_idx on public.inventory(user_id);

-- ============================================================
-- Row Level Security (RLS)
-- Wajib: tanpa ini, Supabase Auth tidak melindungi data antar user
-- ============================================================

alter table public.ingredients          enable row level security;
alter table public.recipes              enable row level security;
alter table public.recipe_ingredients   enable row level security;
alter table public.inventory            enable row level security;

-- Master data: bisa dibaca semua user yang sudah login
create policy "ingredients_read_authenticated"
  on public.ingredients for select to authenticated using (true);

create policy "recipes_read_authenticated"
  on public.recipes for select to authenticated using (true);

create policy "recipe_ingredients_read_authenticated"
  on public.recipe_ingredients for select to authenticated using (true);

-- Inventory: user hanya bisa akses datanya sendiri
create policy "inventory_select_own"
  on public.inventory for select to authenticated
  using (auth.uid() = user_id);

create policy "inventory_insert_own"
  on public.inventory for insert to authenticated
  with check (auth.uid() = user_id);

create policy "inventory_update_own"
  on public.inventory for update to authenticated
  using (auth.uid() = user_id);

create policy "inventory_delete_own"
  on public.inventory for delete to authenticated
  using (auth.uid() = user_id);

-- ============================================================
-- Trigger: otomatis update updated_at saat inventory di-edit
-- ============================================================
create or replace function public.update_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger inventory_updated_at
  before update on public.inventory
  for each row execute function public.update_updated_at();

-- ============================================================
-- ✅ Schema selesai. Lanjut jalankan 002_seed.sql
-- ============================================================
