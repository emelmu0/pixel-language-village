-- STEP 3: 테스트용 단어 10개
-- concept 1개당 ko/en word_entries + 간단한 예문(ko/en)을 넣는다.
-- 난이도는 PRD 9.1 "기초 생활어" 수준 = difficulty_level 1.

insert into public.concepts (concept_key, part_of_speech, difficulty_level, domain, visual_type)
values
  ('apple', 'noun', 1, '음식', 'illustratable'),
  ('water', 'noun', 1, '음식', 'illustratable'),
  ('dog', 'noun', 1, '동물', 'illustratable'),
  ('school', 'noun', 1, '장소', 'illustratable'),
  ('friend', 'noun', 1, '사람', 'illustratable'),
  ('run', 'verb', 1, '동작', 'illustratable'),
  ('like', 'verb', 1, '감정', 'illustratable'),
  ('big', 'adjective', 1, '상태', 'illustratable'),
  ('fast', 'adjective', 1, '상태', 'illustratable'),
  ('hello', 'other', 1, '인사', 'illustratable')
on conflict (concept_key) do nothing;

insert into public.word_entries (concept_id, language_code, display_text, reading, definition, difficulty_level)
select c.id, w.language_code, w.display_text, w.reading, w.definition, 1
from public.concepts c
join (
  values
    ('apple', 'ko', '사과', null, '빨갛고 동그란 과일'),
    ('apple', 'en', 'apple', null, 'a round fruit, usually red or green'),
    ('water', 'ko', '물', null, '마실 수 있는 투명한 액체'),
    ('water', 'en', 'water', null, 'a clear liquid we drink'),
    ('dog', 'ko', '강아지', null, '사람과 친한 동물'),
    ('dog', 'en', 'dog', null, 'a friendly animal often kept as a pet'),
    ('school', 'ko', '학교', null, '공부를 배우는 곳'),
    ('school', 'en', 'school', null, 'a place where children learn'),
    ('friend', 'ko', '친구', null, '나와 가깝게 지내는 사람'),
    ('friend', 'en', 'friend', null, 'a person you like and know well'),
    ('run', 'ko', '달리다', null, '빠르게 발을 움직여 가다'),
    ('run', 'en', 'run', null, 'to move quickly on foot'),
    ('like', 'ko', '좋아하다', null, '무언가를 마음에 들어하다'),
    ('like', 'en', 'like', null, 'to enjoy or feel positive about something'),
    ('big', 'ko', '크다', null, '크기가 큰 상태'),
    ('big', 'en', 'big', null, 'large in size'),
    ('fast', 'ko', '빠르다', null, '속도가 빠른 상태'),
    ('fast', 'en', 'fast', null, 'moving quickly'),
    ('hello', 'ko', '안녕하세요', null, '만났을 때 하는 인사말'),
    ('hello', 'en', 'hello', null, 'a greeting used when meeting someone')
) as w(concept_key, language_code, display_text, reading, definition)
  on w.concept_key = c.concept_key
on conflict (concept_id, language_code) do nothing;

insert into public.examples (concept_id, language_code, sentence, difficulty_level, village_compatible)
select c.id, e.language_code, e.sentence, 1, true
from public.concepts c
join (
  values
    ('apple', 'ko', '나는 사과를 좋아해요.'),
    ('apple', 'en', 'I like apples.'),
    ('water', 'ko', '물을 마시고 싶어요.'),
    ('water', 'en', 'I want to drink water.'),
    ('dog', 'ko', '강아지가 뛰어와요.'),
    ('dog', 'en', 'The dog is running to me.'),
    ('school', 'ko', '학교에 갔어요.'),
    ('school', 'en', 'I went to school.'),
    ('friend', 'ko', '친구와 놀았어요.'),
    ('friend', 'en', 'I played with my friend.'),
    ('run', 'ko', '친구가 운동장을 달려요.'),
    ('run', 'en', 'My friend runs on the playground.'),
    ('like', 'ko', '나는 그림 그리기를 좋아해요.'),
    ('like', 'en', 'I like drawing pictures.'),
    ('big', 'ko', '우리 집 강아지는 커요.'),
    ('big', 'en', 'Our dog is big.'),
    ('fast', 'ko', '토끼는 빨라요.'),
    ('fast', 'en', 'The rabbit is fast.'),
    ('hello', 'ko', '친구에게 안녕하세요라고 말했어요.'),
    ('hello', 'en', 'I said hello to my friend.')
) as e(concept_key, language_code, sentence)
  on e.concept_key = c.concept_key;
