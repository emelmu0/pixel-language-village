-- STEP 7 시드: 기존 examples 문장을 문장 미션(sentence_patterns)으로 변환

insert into public.sentence_patterns (language_code, pattern_key, difficulty_level, structure_json)
values
  ('en', 'apple_sentence_01', 1, '{"concept_key":"apple","tokens":["I","like","apples."],"native_sentence":"나는 사과를 좋아해요."}'),
  ('en', 'big_sentence_01', 1, '{"concept_key":"big","tokens":["Our","dog","is","big."],"native_sentence":"우리 집 강아지는 커요."}'),
  ('en', 'dog_sentence_01', 1, '{"concept_key":"dog","tokens":["The","dog","is","running","to","me."],"native_sentence":"강아지가 뛰어와요."}'),
  ('en', 'fast_sentence_01', 1, '{"concept_key":"fast","tokens":["The","rabbit","is","fast."],"native_sentence":"토끼는 빨라요."}'),
  ('en', 'friend_sentence_01', 1, '{"concept_key":"friend","tokens":["I","played","with","my","friend."],"native_sentence":"친구와 놀았어요."}'),
  ('en', 'hello_sentence_01', 1, '{"concept_key":"hello","tokens":["I","said","hello","to","my","friend."],"native_sentence":"친구에게 안녕하세요라고 말했어요."}'),
  ('en', 'like_sentence_01', 1, '{"concept_key":"like","tokens":["I","like","drawing","pictures."],"native_sentence":"나는 그림 그리기를 좋아해요."}'),
  ('en', 'run_sentence_01', 1, '{"concept_key":"run","tokens":["My","friend","runs","on","the","playground."],"native_sentence":"친구가 운동장을 달려요."}'),
  ('en', 'school_sentence_01', 1, '{"concept_key":"school","tokens":["I","went","to","school."],"native_sentence":"학교에 갔어요."}'),
  ('en', 'water_sentence_01', 1, '{"concept_key":"water","tokens":["I","want","to","drink","water."],"native_sentence":"물을 마시고 싶어요."}');
