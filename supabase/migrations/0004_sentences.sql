-- STEP 7: 문장 모드
-- PRD 11장, 20장 기준 sentence_patterns / learned_sentences 테이블

create table if not exists public.sentence_patterns (
  id uuid primary key default gen_random_uuid(),
  language_code text not null,
  pattern_key text not null unique,
  difficulty_level smallint not null default 1,
  structure_json jsonb not null,
  created_at timestamptz not null default now()
);

create index if not exists sentence_patterns_language_code_idx
  on public.sentence_patterns (language_code);

create table if not exists public.learned_sentences (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles (id) on delete cascade,
  language_code text not null,
  sentence_pattern_id uuid not null references public.sentence_patterns (id) on delete cascade,
  sentence_text text not null,
  created_at timestamptz not null default now()
);

create index if not exists learned_sentences_profile_id_idx
  on public.learned_sentences (profile_id);

alter table public.sentence_patterns enable row level security;
alter table public.learned_sentences enable row level security;

create policy "sentence_patterns_select_authenticated"
  on public.sentence_patterns for select
  to authenticated
  using (true);

create policy "learned_sentences_select_own"
  on public.learned_sentences for select
  using (
    exists (
      select 1 from public.profiles p
      where p.id = learned_sentences.profile_id
        and p.owner_user_id = auth.uid()
    )
  );

create policy "learned_sentences_insert_own"
  on public.learned_sentences for insert
  with check (
    exists (
      select 1 from public.profiles p
      where p.id = learned_sentences.profile_id
        and p.owner_user_id = auth.uid()
    )
  );
