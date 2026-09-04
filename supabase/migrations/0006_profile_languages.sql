-- STEP 9: 다국어
-- PRD 20장 기준 profile_languages 테이블. 프로필이 지금 배우는 언어(활성 언어)를 관리한다.

create table if not exists public.profile_languages (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles (id) on delete cascade,
  language_code text not null,
  is_active boolean not null default false,
  created_at timestamptz not null default now(),
  unique (profile_id, language_code)
);

create index if not exists profile_languages_profile_id_idx
  on public.profile_languages (profile_id);

alter table public.profile_languages enable row level security;

create policy "profile_languages_select_own"
  on public.profile_languages for select
  using (
    exists (
      select 1 from public.profiles p
      where p.id = profile_languages.profile_id
        and p.owner_user_id = auth.uid()
    )
  );

create policy "profile_languages_insert_own"
  on public.profile_languages for insert
  with check (
    exists (
      select 1 from public.profiles p
      where p.id = profile_languages.profile_id
        and p.owner_user_id = auth.uid()
    )
  );

create policy "profile_languages_update_own"
  on public.profile_languages for update
  using (
    exists (
      select 1 from public.profiles p
      where p.id = profile_languages.profile_id
        and p.owner_user_id = auth.uid()
    )
  )
  with check (
    exists (
      select 1 from public.profiles p
      where p.id = profile_languages.profile_id
        and p.owner_user_id = auth.uid()
    )
  );
