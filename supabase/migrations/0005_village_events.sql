-- STEP 8: 마을 예문
-- PRD 15장, 20장 기준 village_events 테이블

create table if not exists public.village_events (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles (id) on delete cascade,
  concept_id uuid not null references public.concepts (id) on delete cascade,
  example_id uuid references public.examples (id) on delete set null,
  event_type text not null default 'resident_dialogue',
  shown_at timestamptz not null default now(),
  completed_at timestamptz
);

create index if not exists village_events_profile_id_idx
  on public.village_events (profile_id);

create index if not exists village_events_profile_concept_idx
  on public.village_events (profile_id, concept_id);

alter table public.village_events enable row level security;

create policy "village_events_select_own"
  on public.village_events for select
  using (
    exists (
      select 1 from public.profiles p
      where p.id = village_events.profile_id
        and p.owner_user_id = auth.uid()
    )
  );

create policy "village_events_insert_own"
  on public.village_events for insert
  with check (
    exists (
      select 1 from public.profiles p
      where p.id = village_events.profile_id
        and p.owner_user_id = auth.uid()
    )
  );

create policy "village_events_update_own"
  on public.village_events for update
  using (
    exists (
      select 1 from public.profiles p
      where p.id = village_events.profile_id
        and p.owner_user_id = auth.uid()
    )
  )
  with check (
    exists (
      select 1 from public.profiles p
      where p.id = village_events.profile_id
        and p.owner_user_id = auth.uid()
    )
  );
