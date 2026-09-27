create extension if not exists pgcrypto;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text unique not null check (username ~ '^[A-Za-z0-9_]{3,24}$'),
  display_name text,
  bio text,
  avatar_url text,
  is_public boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.trades (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  market text not null,
  setup text,
  result_r numeric,
  entry numeric,
  exit numeric,
  risk_usd numeric,
  tags text[] not null default '{}',
  notes text,
  traded_at timestamptz not null default now(),
  is_private boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists public.strategies (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  description text,
  rules jsonb not null default '[]'::jsonb,
  is_public boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.social_connections (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  provider text not null check (provider in ('discord','instagram','x')),
  provider_user_id text not null,
  provider_username text,
  created_at timestamptz not null default now(),
  unique(user_id, provider),
  unique(provider, provider_user_id)
);

alter table public.profiles enable row level security;
alter table public.trades enable row level security;
alter table public.strategies enable row level security;
alter table public.social_connections enable row level security;

create policy "public profiles readable"
on public.profiles for select using (is_public or id = auth.uid());

create policy "users manage own profile"
on public.profiles for all using (id = auth.uid()) with check (id = auth.uid());

create policy "users read own trades"
on public.trades for select using (user_id = auth.uid());

create policy "users write own trades"
on public.trades for insert with check (user_id = auth.uid());

create policy "users update own trades"
on public.trades for update using (user_id = auth.uid()) with check (user_id = auth.uid());

create policy "users delete own trades"
on public.trades for delete using (user_id = auth.uid());

create policy "public strategies readable"
on public.strategies for select using (is_public or user_id = auth.uid());

create policy "users manage own strategies"
on public.strategies for all using (user_id = auth.uid()) with check (user_id = auth.uid());

create policy "users manage own social connections"
on public.social_connections for all using (user_id = auth.uid()) with check (user_id = auth.uid());

create index if not exists trades_user_id_traded_at_idx on public.trades(user_id, traded_at desc);
create index if not exists strategies_public_idx on public.strategies(is_public) where is_public = true;

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles(id, username, display_name)
  values (
    new.id,
    'user_' || substr(replace(new.id::text, '-', ''), 1, 10),
    coalesce(new.raw_user_meta_data->>'full_name', '')
  )
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
after insert on auth.users
for each row execute procedure public.handle_new_user();
