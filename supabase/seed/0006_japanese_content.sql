-- STEP 9 시드: 일본어 콘텐츠 (기존 concept_key 10개에 대해 word_entries/examples 추가)
-- 스키마 변경 없이 concept_id + language_code 행만 추가한다 (PRD 6.2, STEP 9 원칙)

insert into public.word_entries (concept_id, language_code, display_text, definition)
select id, 'ja', v.display_text, v.definition
from public.concepts c
join (values
  ('apple', 'りんご', '赤くて丸い果物'),
  ('water', 'みず', '飲むための透明な液体'),
  ('dog', 'いぬ', '人と一緒に暮らす動物'),
  ('school', 'がっこう', '勉強をするところ'),
  ('friend', 'ともだち', '仲良く遊ぶ人'),
  ('run', 'はしる', '足を速く動かして進む'),
  ('like', 'すき', '好きだと感じること'),
  ('big', 'おおきい', 'サイズが大きいこと'),
  ('fast', 'はやい', '速く動くこと'),
  ('hello', 'こんにちは', '会ったときのあいさつ')
) as v(concept_key, display_text, definition) on v.concept_key = c.concept_key;

insert into public.examples (concept_id, language_code, sentence)
select id, 'ja', v.sentence
from public.concepts c
join (values
  ('apple', 'わたしはりんごがすきです。'),
  ('big', 'わたしのいぬはおおきいです。'),
  ('dog', 'いぬがはしってきます。'),
  ('fast', 'うさぎははやいです。'),
  ('friend', 'ともだちとあそびました。'),
  ('hello', 'ともだちにこんにちはといいました。'),
  ('like', 'わたしはえをかくことがすきです。'),
  ('run', 'ともだちがこうていではしります。'),
  ('school', 'がっこうにいきました。'),
  ('water', 'みずがのみたいです。')
) as v(concept_key, sentence) on v.concept_key = c.concept_key;

-- 일본어 문장 미션 (STEP 7 sentence_patterns에 언어만 추가, 스키마 변경 없음)
insert into public.sentence_patterns (language_code, pattern_key, difficulty_level, structure_json)
values
  ('ja', 'ja_apple_sentence_01', 1, '{"concept_key":"apple","tokens":["わたしは","りんごが","すきです。"],"native_sentence":"나는 사과를 좋아해요."}'),
  ('ja', 'ja_big_sentence_01', 1, '{"concept_key":"big","tokens":["わたしの","いぬは","おおきいです。"],"native_sentence":"우리 집 강아지는 커요."}'),
  ('ja', 'ja_dog_sentence_01', 1, '{"concept_key":"dog","tokens":["いぬが","はしってきます。"],"native_sentence":"강아지가 뛰어와요."}'),
  ('ja', 'ja_fast_sentence_01', 1, '{"concept_key":"fast","tokens":["うさぎは","はやいです。"],"native_sentence":"토끼는 빨라요."}'),
  ('ja', 'ja_friend_sentence_01', 1, '{"concept_key":"friend","tokens":["ともだちと","あそびました。"],"native_sentence":"친구와 놀았어요."}'),
  ('ja', 'ja_hello_sentence_01', 1, '{"concept_key":"hello","tokens":["ともだちに","こんにちはと","いいました。"],"native_sentence":"친구에게 안녕하세요라고 말했어요."}'),
  ('ja', 'ja_like_sentence_01', 1, '{"concept_key":"like","tokens":["わたしは","えをかくことが","すきです。"],"native_sentence":"나는 그림 그리기를 좋아해요."}'),
  ('ja', 'ja_run_sentence_01', 1, '{"concept_key":"run","tokens":["ともだちが","こうていで","はしります。"],"native_sentence":"친구가 운동장을 달려요."}'),
  ('ja', 'ja_school_sentence_01', 1, '{"concept_key":"school","tokens":["がっこうに","いきました。"],"native_sentence":"학교에 갔어요."}'),
  ('ja', 'ja_water_sentence_01', 1, '{"concept_key":"water","tokens":["みずが","のみたいです。"],"native_sentence":"물을 마시고 싶어요."}');
