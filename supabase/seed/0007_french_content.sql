-- STEP 9 확장: 프랑스어(fr) 콘텐츠 (기존 concept_key 10개에 대해 word_entries/examples/sentence_patterns 추가)
-- 스키마 변경 없이 concept_id + language_code 조인 방식 그대로 사용.

insert into public.word_entries (concept_id, language_code, display_text, definition, difficulty_level)
select c.id, 'fr', v.display_text, v.definition, 1
from public.concepts c
join (values
  ('apple', 'pomme', 'un fruit rond, souvent rouge'),
  ('water', 'eau', 'un liquide transparent que l''on boit'),
  ('dog', 'chien', 'un animal ami de l''homme'),
  ('school', 'école', 'un endroit où les enfants apprennent'),
  ('friend', 'ami', 'une personne que l''on aime bien'),
  ('run', 'courir', 'se déplacer vite à pied'),
  ('like', 'aimer', 'trouver quelque chose agréable'),
  ('big', 'grand', 'de grande taille'),
  ('fast', 'rapide', 'qui se déplace vite'),
  ('hello', 'bonjour', 'salutation quand on rencontre quelqu''un')
) as v(concept_key, display_text, definition) on v.concept_key = c.concept_key
on conflict (concept_id, language_code) do nothing;

insert into public.examples (concept_id, language_code, sentence, difficulty_level, village_compatible)
select c.id, 'fr', v.sentence, 1, true
from public.concepts c
join (values
  ('apple', 'J''aime les pommes.'),
  ('water', 'Je veux boire de l''eau.'),
  ('dog', 'Le chien court vers moi.'),
  ('school', 'Je suis allé à l''école.'),
  ('friend', 'J''ai joué avec mon ami.'),
  ('run', 'Mon ami court dans la cour.'),
  ('like', 'J''aime dessiner.'),
  ('big', 'Notre chien est grand.'),
  ('fast', 'Le lapin est rapide.'),
  ('hello', 'J''ai dit bonjour à mon ami.')
) as v(concept_key, sentence) on v.concept_key = c.concept_key;

insert into public.sentence_patterns (language_code, pattern_key, difficulty_level, structure_json)
values
  ('fr', 'fr_apple_sentence_01', 1, '{"concept_key":"apple","tokens":["J''aime","les","pommes."],"native_sentence":"나는 사과를 좋아해요."}'),
  ('fr', 'fr_big_sentence_01', 1, '{"concept_key":"big","tokens":["Notre","chien","est","grand."],"native_sentence":"우리 집 강아지는 커요."}'),
  ('fr', 'fr_dog_sentence_01', 1, '{"concept_key":"dog","tokens":["Le","chien","court","vers","moi."],"native_sentence":"강아지가 뛰어와요."}'),
  ('fr', 'fr_fast_sentence_01', 1, '{"concept_key":"fast","tokens":["Le","lapin","est","rapide."],"native_sentence":"토끼는 빨라요."}'),
  ('fr', 'fr_friend_sentence_01', 1, '{"concept_key":"friend","tokens":["J''ai","joué","avec","mon","ami."],"native_sentence":"친구와 놀았어요."}'),
  ('fr', 'fr_hello_sentence_01', 1, '{"concept_key":"hello","tokens":["J''ai","dit","bonjour","à","mon","ami."],"native_sentence":"친구에게 안녕하세요라고 말했어요."}'),
  ('fr', 'fr_like_sentence_01', 1, '{"concept_key":"like","tokens":["J''aime","dessiner."],"native_sentence":"나는 그림 그리기를 좋아해요."}'),
  ('fr', 'fr_run_sentence_01', 1, '{"concept_key":"run","tokens":["Mon","ami","court","dans","la","cour."],"native_sentence":"친구가 운동장을 달려요."}'),
  ('fr', 'fr_school_sentence_01', 1, '{"concept_key":"school","tokens":["Je","suis","allé","à","l''école."],"native_sentence":"학교에 갔어요."}'),
  ('fr', 'fr_water_sentence_01', 1, '{"concept_key":"water","tokens":["Je","veux","boire","de","l''eau."],"native_sentence":"물을 마시고 싶어요."}');
