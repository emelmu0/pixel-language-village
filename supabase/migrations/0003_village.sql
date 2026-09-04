-- STEP 6: 첫 픽셀 마을
-- PRD 14장 픽셀 마을 시스템 기준 village_profiles 테이블

create table if not exists public.village_profiles (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null unique references public.profiles (id) on delete cascade,
  theme_key text not null,
  village_level smallint not null default 1,
  xp int not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.village_profiles enable row level security;

create policy "village_profiles_select_own"
  on public.village_profiles for select
  using (
    exists (
      select 1 from public.profiles p
      where p.id = village_profiles.profile_id
        and p.owner_user_id = auth.uid()
    )
  );

create policy "village_profiles_insert_own"
  on public.village_profiles for insert
  with check (
    exists (
      select 1 from public.profiles p
      where p.id = village_profiles.profile_id
        and p.owner_user_id = auth.uid()
    )
  );

create policy "village_profiles_update_own"
  on public.village_profiles for update
  using (
    exists (
      select 1 from public.profiles p
      where p.id = village_profiles.profile_id
        and p.owner_user_id = auth.uid()
    )
  )
  with check (
    exists (
      select 1 from public.profiles p
      where p.id = village_profiles.profile_id
        and p.owner_user_id = auth.uid()
    )
  );
