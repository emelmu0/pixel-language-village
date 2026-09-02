-- STEP 3: 카드 DB
-- PRD 20장 데이터베이스 초안 기준 concepts / word_entries / examples / card_progress
-- PRD 18장: 공개 학습 콘텐츠(concepts/word_entries/examples)와
-- 개인 학습기록(card_progress)을 분리한다.

-- concepts: 언어와 무관한 "의미" 단위 (PRD 6.2, 7장)
create table if not exists public.concepts (
  id uuid primary key default gen_random_uuid(),
  concept_key text not null unique,
  part_of_speech text not null,
  difficulty_level smallint not null default 1,
  domain text,
  visual_type text not null default 'illustratable',
  image_path text,
  created_at timestamptz not null default now(),
  constraint concepts_difficulty_level_check
    check (difficulty_level between 1 and 7)
);

-- word_entries: concept의 언어별 표기 (PRD 6.2 language_code 설계 원칙)
create table if not exists public.word_entries (
  id uuid primary key default gen_random_uuid(),
  concept_id uuid not null references public.concepts (id) on delete cascade,
  language_code text not null,
  display_text text not null,
  reading text,
  pronunciation_hint text,
  definition text,
  difficulty_level smallint not null default 1,
  created_at timestamptz not null default now(),
  constraint word_entries_concept_language_unique
    unique (concept_id, language_code)
);

create index if not exists word_entries_concept_id_idx
  on public.word_entries (concept_id);

-- examples: concept의 언어별 예문
create table if not exists public.examples (
  id uuid primary key default gen_random_uuid(),
  concept_id uuid not null references public.concepts (id) on delete cascade,
  language_code text not null,
  sentence text not null,
  difficulty_level smallint not null default 1,
  village_compatible boolean not null default false,
  created_at timestamptz not null default now()
);

create index if not exists examples_concept_id_idx
  on public.examples (concept_id);

-- card_progress: 아이 프로필별 카드 숙련도 (PRD 9.2)
create table if not exists public.card_progress (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles (id) on delete cascade,
  concept_id uuid not null references public.concepts (id) on delete cascade,
  language_code text not null,
  mastery_level smallint not null default 0,
  correct_count int not null default 0,
  review_count int not null default 0,
  last_reviewed_at timestamptz,
  updated_at timestamptz not null default now(),
  constraint card_progress_mastery_level_check
    check (mastery_level between 0 and 4),
  constraint card_progress_profile_concept_language_unique
    unique (profile_id, concept_id, language_code)
);

create index if not exists card_progress_profile_id_idx
  on public.card_progress (profile_id);

-- RLS ---------------------------------------------------------------------

alter table public.concepts enable row level security;
alter table public.word_entries enable row level security;
alter table public.examples enable row level security;
alter table public.card_progress enable row level security;

-- 공개 학습 콘텐츠: 로그인한 사용자는 누구나 읽을 수 있다.
-- 콘텐츠 등록/수정은 서비스 롤(관리자)로만 하며, 클라이언트용 쓰기 정책은 두지 않는다.
create policy "concepts_select_authenticated"
  on public.concepts for select
  to authenticated
  using (true);

create policy "word_entries_select_authenticated"
  on public.word_entries for select
  to authenticated
  using (true);

create policy "examples_select_authenticated"
  on public.examples for select
  to authenticated
  using (true);

-- 개인 학습기록: 보호자는 자신의 child_profile에 속한 기록만 접근 가능 (PRD 18장 Security)
create policy "card_progress_select_own"
  on public.card_progress for select
  using (
    exists (
      select 1 from public.profiles p
      where p.id = card_progress.profile_id
        and p.owner_user_id = auth.uid()
    )
  );

create policy "card_progress_insert_own"
  on public.card_progress for insert
  with check (
    exists (
      select 1 from public.profiles p
      where p.id = card_progress.profile_id
        and p.owner_user_id = auth.uid()
    )
  );

create policy "card_progress_update_own"
  on public.card_progress for update
  using (
    exists (
      select 1 from public.profiles p
      where p.id = card_progress.profile_id
        and p.owner_user_id = auth.uid()
    )
  )
  with check (
    exists (
      select 1 from public.profiles p
      where p.id = card_progress.profile_id
        and p.owner_user_id = auth.uid()
    )
  );

create policy "card_progress_delete_own"
  on public.card_progress for delete
  using (
    exists (
      select 1 from public.profiles p
      where p.id = card_progress.profile_id
        and p.owner_user_id = auth.uid()
    )
  );
