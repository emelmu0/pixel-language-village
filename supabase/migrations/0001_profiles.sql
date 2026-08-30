-- STEP 2: 인증과 프로필
-- PRD 20장 데이터베이스 초안 기준 profiles 테이블 + RLS

create table if not exists public.profiles (
  id uuid primary key default gen_random_uuid(),
  owner_user_id uuid not null references auth.users (id) on delete cascade,
  nickname text not null,
  avatar text,
  current_level int not null default 1,
  primary_language text not null default 'ko',
  created_at timestamptz not null default now()
);

create index if not exists profiles_owner_user_id_idx
  on public.profiles (owner_user_id);

alter table public.profiles enable row level security;

-- 보호자는 자신의 child_profile만 조회/수정/삭제할 수 있다.
create policy "profiles_select_own"
  on public.profiles for select
  using (auth.uid() = owner_user_id);

create policy "profiles_insert_own"
  on public.profiles for insert
  with check (auth.uid() = owner_user_id);

create policy "profiles_update_own"
  on public.profiles for update
  using (auth.uid() = owner_user_id)
  with check (auth.uid() = owner_user_id);

create policy "profiles_delete_own"
  on public.profiles for delete
  using (auth.uid() = owner_user_id);
