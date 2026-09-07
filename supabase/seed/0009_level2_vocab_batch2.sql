-- STEP 10: 콘텐츠 확대 (Level 2 - 초등 기초 확장 어휘, batch 2)
-- 국립국어원 초급 등급 + 교육부 초등 필수 영단어 800 + JLPT N5 교차검증 36단어 추가.
-- 기존 46개 concept(최초 10 + Level 2 batch 1 36)와 겹치지 않는 새 concept 36개.
-- difficulty_level=2로 구분. 한국어/영어/일본어/프랑스어 4개 언어 동시 지원.

insert into public.concepts (concept_key, part_of_speech, difficulty_level, domain, visual_type, image_path)
values
  ('bird', 'noun', 2, '동물', 'illustratable', '/pixel-art/bird.png'),
  ('pig', 'noun', 2, '동물', 'illustratable', '/pixel-art/pig.png'),
  ('cow', 'noun', 2, '동물', 'illustratable', '/pixel-art/cow.png'),
  ('duck', 'noun', 2, '동물', 'illustratable', '/pixel-art/duck.png'),
  ('soup', 'noun', 2, '음식', 'illustratable', '/pixel-art/soup.png'),
  ('cake', 'noun', 2, '음식', 'illustratable', '/pixel-art/cake.png'),
  ('candy', 'noun', 2, '음식', 'illustratable', '/pixel-art/candy.png'),
  ('juice', 'noun', 2, '음식', 'illustratable', '/pixel-art/juice.png'),
  ('mouth', 'noun', 2, '신체', 'illustratable', '/pixel-art/mouth.png'),
  ('nose', 'noun', 2, '신체', 'illustratable', '/pixel-art/nose.png'),
  ('ear', 'noun', 2, '신체', 'illustratable', '/pixel-art/ear.png'),
  ('hair', 'noun', 2, '신체', 'illustratable', '/pixel-art/hair.png'),
  ('family', 'noun', 2, '가족', 'illustratable', '/pixel-art/family.png'),
  ('grandpa', 'noun', 2, '가족', 'illustratable', '/pixel-art/grandpa.png'),
  ('uncle', 'noun', 2, '가족', 'illustratable', '/pixel-art/uncle.png'),
  ('aunt', 'noun', 2, '가족', 'illustratable', '/pixel-art/aunt.png'),
  ('five', 'other', 2, '숫자', 'illustratable', '/pixel-art/five.png'),
  ('six', 'other', 2, '숫자', 'illustratable', '/pixel-art/six.png'),
  ('seven', 'other', 2, '숫자', 'illustratable', '/pixel-art/seven.png'),
  ('eight', 'other', 2, '숫자', 'illustratable', '/pixel-art/eight.png'),
  ('sky', 'noun', 2, '자연', 'illustratable', '/pixel-art/sky.png'),
  ('star', 'noun', 2, '자연', 'illustratable', '/pixel-art/star.png'),
  ('cloud', 'noun', 2, '자연', 'illustratable', '/pixel-art/cloud.png'),
  ('snow', 'noun', 2, '자연', 'illustratable', '/pixel-art/snow.png'),
  ('umbrella', 'noun', 2, '사물', 'illustratable', '/pixel-art/umbrella.png'),
  ('clock', 'noun', 2, '사물', 'illustratable', '/pixel-art/clock.png'),
  ('cup', 'noun', 2, '사물', 'illustratable', '/pixel-art/cup.png'),
  ('door', 'noun', 2, '사물', 'illustratable', '/pixel-art/door.png'),
  ('walk', 'verb', 2, '동작', 'illustratable', '/pixel-art/walk.png'),
  ('jump', 'verb', 2, '동작', 'illustratable', '/pixel-art/jump.png'),
  ('sing', 'verb', 2, '동작', 'illustratable', '/pixel-art/sing.png'),
  ('drink', 'verb', 2, '동작', 'illustratable', '/pixel-art/drink.png'),
  ('angry', 'adjective', 2, '감정', 'illustratable', '/pixel-art/angry.png'),
  ('tired', 'adjective', 2, '감정', 'illustratable', '/pixel-art/tired.png'),
  ('hungry', 'adjective', 2, '감정', 'illustratable', '/pixel-art/hungry.png'),
  ('cold', 'adjective', 2, '감정', 'illustratable', '/pixel-art/cold.png')
on conflict (concept_key) do nothing;

-- 한국어 word_entries
insert into public.word_entries (concept_id, language_code, display_text, definition, difficulty_level)
select c.id, 'ko', v.display_text, v.definition, 2
from public.concepts c
join (values
  ('bird','새','새'),('pig','돼지','돼지'),('cow','소','소'),('duck','오리','오리'),
  ('soup','수프','수프, 국'),('cake','케이크','케이크'),('candy','사탕','사탕'),('juice','주스','주스'),
  ('mouth','입','입'),('nose','코','코'),('ear','귀','귀'),('hair','머리카락','머리카락'),
  ('family','가족','가족'),('grandpa','할아버지','할아버지'),('uncle','삼촌','삼촌'),('aunt','이모','이모, 고모'),
  ('five','다섯','다섯, 5'),('six','여섯','여섯, 6'),('seven','일곱','일곱, 7'),('eight','여덟','여덟, 8'),
  ('sky','하늘','하늘'),('star','별','별'),('cloud','구름','구름'),('snow','눈','눈'),
  ('umbrella','우산','우산'),('clock','시계','시계'),('cup','컵','컵'),('door','문','문'),
  ('walk','걷다','걷다'),('jump','뛰다','뛰다, 점프하다'),('sing','노래하다','노래하다'),('drink','마시다','마시다'),
  ('angry','화나다','화나다'),('tired','피곤하다','피곤하다'),('hungry','배고프다','배고프다'),('cold','춥다','춥다')
) as v(concept_key, display_text, definition) on v.concept_key = c.concept_key;

-- 영어 word_entries
insert into public.word_entries (concept_id, language_code, display_text, definition, difficulty_level)
select c.id, 'en', v.display_text, v.definition, 2
from public.concepts c
join (values
  ('bird','bird','an animal that flies with wings'),('pig','pig','a farm animal that oinks'),
  ('cow','cow','a farm animal that gives milk'),('duck','duck','a bird that swims in ponds'),
  ('soup','soup','a hot liquid food'),('cake','cake','a sweet baked dessert'),
  ('candy','candy','a sweet treat'),('juice','juice','a drink made from fruit'),
  ('mouth','mouth','the body part used to eat and speak'),('nose','nose','the body part used to smell'),
  ('ear','ear','the body part used to hear'),('hair','hair','what grows on your head'),
  ('family','family','parents and children together'),('grandpa','grandpa','father''s or mother''s father'),
  ('uncle','uncle','the brother of your mom or dad'),('aunt','aunt','the sister of your mom or dad'),
  ('five','five','the number 5'),('six','six','the number 6'),
  ('seven','seven','the number 7'),('eight','eight','the number 8'),
  ('sky','sky','the space above the earth'),('star','star','a bright point of light in the night sky'),
  ('cloud','cloud','a white or gray shape in the sky'),('snow','snow','soft white ice that falls in winter'),
  ('umbrella','umbrella','something you use to stay dry in rain'),('clock','clock','a tool that shows the time'),
  ('cup','cup','a container for drinking'),('door','door','something you open to enter a room'),
  ('walk','walk','to move on foot'),('jump','jump','to push off the ground into the air'),
  ('sing','sing','to make music with your voice'),('drink','drink','to swallow a liquid'),
  ('angry','angry','feeling mad'),('tired','tired','needing rest or sleep'),
  ('hungry','hungry','wanting to eat'),('cold','cold','having a low temperature')
) as v(concept_key, display_text, definition) on v.concept_key = c.concept_key;

-- 일본어 word_entries
insert into public.word_entries (concept_id, language_code, display_text, definition, difficulty_level)
select c.id, 'ja', v.display_text, v.definition, 2
from public.concepts c
join (values
  ('bird','とり','とり'),('pig','ぶた','ぶた'),('cow','うし','うし'),('duck','あひる','あひる'),
  ('soup','スープ','スープ'),('cake','ケーキ','ケーキ'),('candy','あめ','あめ'),('juice','ジュース','ジュース'),
  ('mouth','くち','くち'),('nose','はな','はな'),('ear','みみ','みみ'),('hair','かみ','かみ'),
  ('family','かぞく','かぞく'),('grandpa','おじいさん','おじいさん'),('uncle','おじさん','おじさん'),('aunt','おばさん','おばさん'),
  ('five','ご','ご, 5'),('six','ろく','ろく, 6'),('seven','なな','なな, 7'),('eight','はち','はち, 8'),
  ('sky','そら','そら'),('star','ほし','ほし'),('cloud','くも','くも'),('snow','ゆき','ゆき'),
  ('umbrella','かさ','かさ'),('clock','とけい','とけい'),('cup','コップ','コップ'),('door','ドア','ドア'),
  ('walk','あるく','あるく'),('jump','とぶ','とぶ'),('sing','うたう','うたう'),('drink','のむ','のむ'),
  ('angry','おこる','おこる'),('tired','つかれる','つかれる'),('hungry','おなかがすく','おなかがすく'),('cold','さむい','さむい')
) as v(concept_key, display_text, definition) on v.concept_key = c.concept_key;

-- 프랑스어 word_entries
insert into public.word_entries (concept_id, language_code, display_text, definition, difficulty_level)
select c.id, 'fr', v.display_text, v.definition, 2
from public.concepts c
join (values
  ('bird','oiseau','oiseau'),('pig','cochon','cochon'),('cow','vache','vache'),('duck','canard','canard'),
  ('soup','soupe','soupe'),('cake','gateau','gateau'),('candy','bonbon','bonbon'),('juice','jus','jus'),
  ('mouth','bouche','bouche'),('nose','nez','nez'),('ear','oreille','oreille'),('hair','cheveux','cheveux'),
  ('family','famille','famille'),('grandpa','grand-pere','grand-pere'),('uncle','oncle','oncle'),('aunt','tante','tante'),
  ('five','cinq','cinq, 5'),('six','six','six, 6'),('seven','sept','sept, 7'),('eight','huit','huit, 8'),
  ('sky','ciel','ciel'),('star','etoile','etoile'),('cloud','nuage','nuage'),('snow','neige','neige'),
  ('umbrella','parapluie','parapluie'),('clock','horloge','horloge'),('cup','tasse','tasse'),('door','porte','porte'),
  ('walk','marcher','marcher'),('jump','sauter','sauter'),('sing','chanter','chanter'),('drink','boire','boire'),
  ('angry','fache','fache'),('tired','fatigue','fatigue'),('hungry','affame','affame'),('cold','froid','froid')
) as v(concept_key, display_text, definition) on v.concept_key = c.concept_key;

-- 한국어 examples
insert into public.examples (concept_id, language_code, sentence, difficulty_level, village_compatible)
select c.id, 'ko', v.sentence, 2, true
from public.concepts c
join (values
  ('bird','새가 하늘을 날아요.'),('pig','돼지가 꿀꿀 울어요.'),('cow','소가 풀을 먹어요.'),
  ('duck','오리가 연못에서 헤엄쳐요.'),('soup','수프가 뜨거워요.'),('cake','생일에 케이크를 먹어요.'),
  ('candy','사탕이 달아요.'),('juice','주스를 마셔요.'),('mouth','입을 크게 벌려요.'),
  ('nose','코로 숨을 쉬어요.'),('ear','귀로 소리를 들어요.'),('hair','머리카락이 길어요.'),
  ('family','우리 가족은 네 명이에요.'),('grandpa','할아버지가 신문을 읽어요.'),('uncle','삼촌이 놀러 왔어요.'),
  ('aunt','이모가 선물을 줬어요.'),('five','사과가 다섯 개 있어요.'),('six','사과가 여섯 개 있어요.'),
  ('seven','사과가 일곱 개 있어요.'),('eight','사과가 여덟 개 있어요.'),('sky','하늘이 맑아요.'),
  ('star','밤하늘에 별이 반짝여요.'),('cloud','구름이 떠 있어요.'),('snow','겨울에 눈이 와요.'),
  ('umbrella','비가 와서 우산을 써요.'),('clock','시계가 세 시를 가리켜요.'),('cup','컵에 물을 담아요.'),
  ('door','문을 열어요.'),('walk','공원을 걸어요.'),('jump','높이 뛰어요.'),
  ('sing','노래를 불러요.'),('drink','물을 마셔요.'),('angry','동생이 화가 났어요.'),
  ('tired','오늘 하루 종일 피곤해요.'),('hungry','배가 고파요.'),('cold','오늘은 날씨가 추워요.')
) as v(concept_key, sentence) on v.concept_key = c.concept_key;

-- 영어 examples
insert into public.examples (concept_id, language_code, sentence, difficulty_level, village_compatible)
select c.id, 'en', v.sentence, 2, true
from public.concepts c
join (values
  ('bird','The bird flies in the sky.'),('pig','The pig oinks.'),('cow','The cow eats grass.'),
  ('duck','The duck swims in the pond.'),('soup','The soup is hot.'),('cake','I eat cake on my birthday.'),
  ('candy','The candy is sweet.'),('juice','I drink juice.'),('mouth','I open my mouth wide.'),
  ('nose','I breathe through my nose.'),('ear','I hear sounds with my ears.'),('hair','My hair is long.'),
  ('family','My family has four people.'),('grandpa','Grandpa reads the newspaper.'),('uncle','My uncle came to visit.'),
  ('aunt','My aunt gave me a gift.'),('five','There are five apples.'),('six','There are six apples.'),
  ('seven','There are seven apples.'),('eight','There are eight apples.'),('sky','The sky is clear.'),
  ('star','Stars twinkle in the night sky.'),('cloud','A cloud is floating.'),('snow','It snows in winter.'),
  ('umbrella','I use an umbrella because it is raining.'),('clock','The clock shows three o''clock.'),('cup','I pour water into the cup.'),
  ('door','I open the door.'),('walk','I walk in the park.'),('jump','I jump high.'),
  ('sing','I sing a song.'),('drink','I drink water.'),('angry','My little sibling is angry.'),
  ('tired','I am tired all day today.'),('hungry','I am hungry.'),('cold','It is cold today.')
) as v(concept_key, sentence) on v.concept_key = c.concept_key;

-- 일본어 examples
insert into public.examples (concept_id, language_code, sentence, difficulty_level, village_compatible)
select c.id, 'ja', v.sentence, 2, true
from public.concepts c
join (values
  ('bird','鳥が空を飛びます。'),('pig','豚がぶーぶー鳴きます。'),('cow','牛が草を食べます。'),
  ('duck','あひるが池で泳ぎます。'),('soup','スープが熱いです。'),('cake','誕生日にケーキを食べます。'),
  ('candy','あめが甘いです。'),('juice','ジュースを飲みます。'),('mouth','口を大きく開けます。'),
  ('nose','鼻で息をします。'),('ear','耳で音を聞きます。'),('hair','髪が長いです。'),
  ('family','私の家族は四人です。'),('grandpa','おじいさんが新聞を読みます。'),('uncle','おじさんが遊びに来ました。'),
  ('aunt','おばさんがプレゼントをくれました。'),('five','りんごが五つあります。'),('six','りんごが六つあります。'),
  ('seven','りんごが七つあります。'),('eight','りんごが八つあります。'),('sky','空が晴れています。'),
  ('star','夜空に星が輝きます。'),('cloud','雲が浮かんでいます。'),('snow','冬に雪が降ります。'),
  ('umbrella','雨だから傘をさします。'),('clock','時計が三時を指しています。'),('cup','コップに水を入れます。'),
  ('door','ドアを開けます。'),('walk','公園を歩きます。'),('jump','高く跳びます。'),
  ('sing','歌を歌います。'),('drink','水を飲みます。'),('angry','弟が怒っています。'),
  ('tired','今日は一日中疲れました。'),('hungry','おなかがすきました。'),('cold','今日は寒いです。')
) as v(concept_key, sentence) on v.concept_key = c.concept_key;

-- 프랑스어 examples
insert into public.examples (concept_id, language_code, sentence, difficulty_level, village_compatible)
select c.id, 'fr', v.sentence, 2, true
from public.concepts c
join (values
  ('bird','L''oiseau vole dans le ciel.'),('pig','Le cochon fait groin groin.'),('cow','La vache mange de l''herbe.'),
  ('duck','Le canard nage dans l''etang.'),('soup','La soupe est chaude.'),('cake','Je mange du gateau pour mon anniversaire.'),
  ('candy','Le bonbon est sucre.'),('juice','Je bois du jus.'),('mouth','J''ouvre grand la bouche.'),
  ('nose','Je respire par le nez.'),('ear','J''entends des sons avec mes oreilles.'),('hair','Mes cheveux sont longs.'),
  ('family','Ma famille a quatre personnes.'),('grandpa','Grand-pere lit le journal.'),('uncle','Mon oncle est venu me rendre visite.'),
  ('aunt','Ma tante m''a donne un cadeau.'),('five','Il y a cinq pommes.'),('six','Il y a six pommes.'),
  ('seven','Il y a sept pommes.'),('eight','Il y a huit pommes.'),('sky','Le ciel est clair.'),
  ('star','Les etoiles scintillent dans le ciel nocturne.'),('cloud','Un nuage flotte.'),('snow','Il neige en hiver.'),
  ('umbrella','J''utilise un parapluie parce qu''il pleut.'),('clock','L''horloge indique trois heures.'),('cup','Je verse de l''eau dans la tasse.'),
  ('door','J''ouvre la porte.'),('walk','Je marche dans le parc.'),('jump','Je saute haut.'),
  ('sing','Je chante une chanson.'),('drink','Je bois de l''eau.'),('angry','Mon petit frere est fache.'),
  ('tired','Je suis fatigue toute la journee aujourd''hui.'),('hungry','J''ai faim.'),('cold','Il fait froid aujourd''hui.')
) as v(concept_key, sentence) on v.concept_key = c.concept_key;

-- 영어 문장 미션
insert into public.sentence_patterns (language_code, pattern_key, difficulty_level, structure_json)
values
  ('en', 'bird_sentence_01', 2, '{"concept_key":"bird","tokens":["The","bird","flies","in","the","sky."],"native_sentence":"새가 하늘을 날아요."}'),
  ('en', 'pig_sentence_01', 2, '{"concept_key":"pig","tokens":["The","pig","oinks."],"native_sentence":"돼지가 꿀꿀 울어요."}'),
  ('en', 'cow_sentence_01', 2, '{"concept_key":"cow","tokens":["The","cow","eats","grass."],"native_sentence":"소가 풀을 먹어요."}'),
  ('en', 'duck_sentence_01', 2, '{"concept_key":"duck","tokens":["The","duck","swims","in","the","pond."],"native_sentence":"오리가 연못에서 헤엄쳐요."}'),
  ('en', 'soup_sentence_01', 2, '{"concept_key":"soup","tokens":["The","soup","is","hot."],"native_sentence":"수프가 뜨거워요."}'),
  ('en', 'cake_sentence_01', 2, '{"concept_key":"cake","tokens":["I","eat","cake","on","my","birthday."],"native_sentence":"생일에 케이크를 먹어요."}'),
  ('en', 'candy_sentence_01', 2, '{"concept_key":"candy","tokens":["The","candy","is","sweet."],"native_sentence":"사탕이 달아요."}'),
  ('en', 'juice_sentence_01', 2, '{"concept_key":"juice","tokens":["I","drink","juice."],"native_sentence":"주스를 마셔요."}'),
  ('en', 'mouth_sentence_01', 2, '{"concept_key":"mouth","tokens":["I","open","my","mouth","wide."],"native_sentence":"입을 크게 벌려요."}'),
  ('en', 'nose_sentence_01', 2, '{"concept_key":"nose","tokens":["I","breathe","through","my","nose."],"native_sentence":"코로 숨을 쉬어요."}'),
  ('en', 'ear_sentence_01', 2, '{"concept_key":"ear","tokens":["I","hear","sounds","with","my","ears."],"native_sentence":"귀로 소리를 들어요."}'),
  ('en', 'hair_sentence_01', 2, '{"concept_key":"hair","tokens":["My","hair","is","long."],"native_sentence":"머리카락이 길어요."}'),
  ('en', 'family_sentence_01', 2, '{"concept_key":"family","tokens":["My","family","has","four","people."],"native_sentence":"우리 가족은 네 명이에요."}'),
  ('en', 'grandpa_sentence_01', 2, '{"concept_key":"grandpa","tokens":["Grandpa","reads","the","newspaper."],"native_sentence":"할아버지가 신문을 읽어요."}'),
  ('en', 'uncle_sentence_01', 2, '{"concept_key":"uncle","tokens":["My","uncle","came","to","visit."],"native_sentence":"삼촌이 놀러 왔어요."}'),
  ('en', 'aunt_sentence_01', 2, '{"concept_key":"aunt","tokens":["My","aunt","gave","me","a","gift."],"native_sentence":"이모가 선물을 줬어요."}'),
  ('en', 'five_sentence_01', 2, '{"concept_key":"five","tokens":["There","are","five","apples."],"native_sentence":"사과가 다섯 개 있어요."}'),
  ('en', 'six_sentence_01', 2, '{"concept_key":"six","tokens":["There","are","six","apples."],"native_sentence":"사과가 여섯 개 있어요."}'),
  ('en', 'seven_sentence_01', 2, '{"concept_key":"seven","tokens":["There","are","seven","apples."],"native_sentence":"사과가 일곱 개 있어요."}'),
  ('en', 'eight_sentence_01', 2, '{"concept_key":"eight","tokens":["There","are","eight","apples."],"native_sentence":"사과가 여덟 개 있어요."}'),
  ('en', 'sky_sentence_01', 2, '{"concept_key":"sky","tokens":["The","sky","is","clear."],"native_sentence":"하늘이 맑아요."}'),
  ('en', 'star_sentence_01', 2, '{"concept_key":"star","tokens":["Stars","twinkle","in","the","night","sky."],"native_sentence":"밤하늘에 별이 반짝여요."}'),
  ('en', 'cloud_sentence_01', 2, '{"concept_key":"cloud","tokens":["A","cloud","is","floating."],"native_sentence":"구름이 떠 있어요."}'),
  ('en', 'snow_sentence_01', 2, '{"concept_key":"snow","tokens":["It","snows","in","winter."],"native_sentence":"겨울에 눈이 와요."}'),
  ('en', 'umbrella_sentence_01', 2, '{"concept_key":"umbrella","tokens":["I","use","an","umbrella","because","it","is","raining."],"native_sentence":"비가 와서 우산을 써요."}'),
  ('en', 'clock_sentence_01', 2, '{"concept_key":"clock","tokens":["The","clock","shows","three","o''clock."],"native_sentence":"시계가 세 시를 가리켜요."}'),
  ('en', 'cup_sentence_01', 2, '{"concept_key":"cup","tokens":["I","pour","water","into","the","cup."],"native_sentence":"컵에 물을 담아요."}'),
  ('en', 'door_sentence_01', 2, '{"concept_key":"door","tokens":["I","open","the","door."],"native_sentence":"문을 열어요."}'),
  ('en', 'walk_sentence_01', 2, '{"concept_key":"walk","tokens":["I","walk","in","the","park."],"native_sentence":"공원을 걸어요."}'),
  ('en', 'jump_sentence_01', 2, '{"concept_key":"jump","tokens":["I","jump","high."],"native_sentence":"높이 뛰어요."}'),
  ('en', 'sing_sentence_01', 2, '{"concept_key":"sing","tokens":["I","sing","a","song."],"native_sentence":"노래를 불러요."}'),
  ('en', 'drink_sentence_01', 2, '{"concept_key":"drink","tokens":["I","drink","water."],"native_sentence":"물을 마셔요."}'),
  ('en', 'angry_sentence_01', 2, '{"concept_key":"angry","tokens":["My","little","sibling","is","angry."],"native_sentence":"동생이 화가 났어요."}'),
  ('en', 'tired_sentence_01', 2, '{"concept_key":"tired","tokens":["I","am","tired","all","day","today."],"native_sentence":"오늘 하루 종일 피곤해요."}'),
  ('en', 'hungry_sentence_01', 2, '{"concept_key":"hungry","tokens":["I","am","hungry."],"native_sentence":"배가 고파요."}'),
  ('en', 'cold_sentence_01', 2, '{"concept_key":"cold","tokens":["It","is","cold","today."],"native_sentence":"오늘은 날씨가 추워요."}');

-- 일본어 문장 미션
insert into public.sentence_patterns (language_code, pattern_key, difficulty_level, structure_json)
values
  ('ja', 'ja_bird_sentence_01', 2, '{"concept_key":"bird","tokens":["とりが","そらを","とびます。"],"native_sentence":"새가 하늘을 날아요."}'),
  ('ja', 'ja_pig_sentence_01', 2, '{"concept_key":"pig","tokens":["ぶたが","ぶーぶー","なきます。"],"native_sentence":"돼지가 꿀꿀 울어요."}'),
  ('ja', 'ja_cow_sentence_01', 2, '{"concept_key":"cow","tokens":["うしが","くさを","たべます。"],"native_sentence":"소가 풀을 먹어요."}'),
  ('ja', 'ja_duck_sentence_01', 2, '{"concept_key":"duck","tokens":["あひるが","いけで","およぎます。"],"native_sentence":"오리가 연못에서 헤엄쳐요."}'),
  ('ja', 'ja_soup_sentence_01', 2, '{"concept_key":"soup","tokens":["スープが","あついです。"],"native_sentence":"수프가 뜨거워요."}'),
  ('ja', 'ja_cake_sentence_01', 2, '{"concept_key":"cake","tokens":["たんじょうびに","ケーキを","たべます。"],"native_sentence":"생일에 케이크를 먹어요."}'),
  ('ja', 'ja_candy_sentence_01', 2, '{"concept_key":"candy","tokens":["あめが","あまいです。"],"native_sentence":"사탕이 달아요."}'),
  ('ja', 'ja_juice_sentence_01', 2, '{"concept_key":"juice","tokens":["ジュースを","のみます。"],"native_sentence":"주스를 마셔요."}'),
  ('ja', 'ja_mouth_sentence_01', 2, '{"concept_key":"mouth","tokens":["くちを","おおきく","あけます。"],"native_sentence":"입을 크게 벌려요."}'),
  ('ja', 'ja_nose_sentence_01', 2, '{"concept_key":"nose","tokens":["はなで","いきを","します。"],"native_sentence":"코로 숨을 쉬어요."}'),
  ('ja', 'ja_ear_sentence_01', 2, '{"concept_key":"ear","tokens":["みみで","おとを","ききます。"],"native_sentence":"귀로 소리를 들어요."}'),
  ('ja', 'ja_hair_sentence_01', 2, '{"concept_key":"hair","tokens":["かみが","ながいです。"],"native_sentence":"머리카락이 길어요."}'),
  ('ja', 'ja_family_sentence_01', 2, '{"concept_key":"family","tokens":["わたしの","かぞくは","よにんです。"],"native_sentence":"우리 가족은 네 명이에요."}'),
  ('ja', 'ja_grandpa_sentence_01', 2, '{"concept_key":"grandpa","tokens":["おじいさんが","しんぶんを","よみます。"],"native_sentence":"할아버지가 신문을 읽어요."}'),
  ('ja', 'ja_uncle_sentence_01', 2, '{"concept_key":"uncle","tokens":["おじさんが","あそびに","きました。"],"native_sentence":"삼촌이 놀러 왔어요."}'),
  ('ja', 'ja_aunt_sentence_01', 2, '{"concept_key":"aunt","tokens":["おばさんが","プレゼントを","くれました。"],"native_sentence":"이모가 선물을 줬어요."}'),
  ('ja', 'ja_five_sentence_01', 2, '{"concept_key":"five","tokens":["りんごが","いつつ","あります。"],"native_sentence":"사과가 다섯 개 있어요."}'),
  ('ja', 'ja_six_sentence_01', 2, '{"concept_key":"six","tokens":["りんごが","むっつ","あります。"],"native_sentence":"사과가 여섯 개 있어요."}'),
  ('ja', 'ja_seven_sentence_01', 2, '{"concept_key":"seven","tokens":["りんごが","ななつ","あります。"],"native_sentence":"사과가 일곱 개 있어요."}'),
  ('ja', 'ja_eight_sentence_01', 2, '{"concept_key":"eight","tokens":["りんごが","やっつ","あります。"],"native_sentence":"사과가 여덟 개 있어요."}'),
  ('ja', 'ja_sky_sentence_01', 2, '{"concept_key":"sky","tokens":["そらが","はれています。"],"native_sentence":"하늘이 맑아요."}'),
  ('ja', 'ja_star_sentence_01', 2, '{"concept_key":"star","tokens":["よぞらに","ほしが","かがやきます。"],"native_sentence":"밤하늘에 별이 반짝여요."}'),
  ('ja', 'ja_cloud_sentence_01', 2, '{"concept_key":"cloud","tokens":["くもが","うかんでいます。"],"native_sentence":"구름이 떠 있어요."}'),
  ('ja', 'ja_snow_sentence_01', 2, '{"concept_key":"snow","tokens":["ふゆに","ゆきが","ふります。"],"native_sentence":"겨울에 눈이 와요."}'),
  ('ja', 'ja_umbrella_sentence_01', 2, '{"concept_key":"umbrella","tokens":["あめだから","かさを","さします。"],"native_sentence":"비가 와서 우산을 써요."}'),
  ('ja', 'ja_clock_sentence_01', 2, '{"concept_key":"clock","tokens":["とけいが","さんじを","さしています。"],"native_sentence":"시계가 세 시를 가리켜요."}'),
  ('ja', 'ja_cup_sentence_01', 2, '{"concept_key":"cup","tokens":["コップに","みずを","いれます。"],"native_sentence":"컵에 물을 담아요."}'),
  ('ja', 'ja_door_sentence_01', 2, '{"concept_key":"door","tokens":["ドアを","あけます。"],"native_sentence":"문을 열어요."}'),
  ('ja', 'ja_walk_sentence_01', 2, '{"concept_key":"walk","tokens":["こうえんを","あるきます。"],"native_sentence":"공원을 걸어요."}'),
  ('ja', 'ja_jump_sentence_01', 2, '{"concept_key":"jump","tokens":["たかく","とびます。"],"native_sentence":"높이 뛰어요."}'),
  ('ja', 'ja_sing_sentence_01', 2, '{"concept_key":"sing","tokens":["うたを","うたいます。"],"native_sentence":"노래를 불러요."}'),
  ('ja', 'ja_drink_sentence_01', 2, '{"concept_key":"drink","tokens":["みずを","のみます。"],"native_sentence":"물을 마셔요."}'),
  ('ja', 'ja_angry_sentence_01', 2, '{"concept_key":"angry","tokens":["おとうとが","おこっています。"],"native_sentence":"동생이 화가 났어요."}'),
  ('ja', 'ja_tired_sentence_01', 2, '{"concept_key":"tired","tokens":["きょうは","いちにちじゅう","つかれました。"],"native_sentence":"오늘 하루 종일 피곤해요."}'),
  ('ja', 'ja_hungry_sentence_01', 2, '{"concept_key":"hungry","tokens":["おなかが","すきました。"],"native_sentence":"배가 고파요."}'),
  ('ja', 'ja_cold_sentence_01', 2, '{"concept_key":"cold","tokens":["きょうは","さむいです。"],"native_sentence":"오늘은 날씨가 추워요."}');

-- 프랑스어 문장 미션
insert into public.sentence_patterns (language_code, pattern_key, difficulty_level, structure_json)
values
  ('fr', 'fr_bird_sentence_01', 2, '{"concept_key":"bird","tokens":["L''oiseau","vole","dans","le","ciel."],"native_sentence":"새가 하늘을 날아요."}'),
  ('fr', 'fr_pig_sentence_01', 2, '{"concept_key":"pig","tokens":["Le","cochon","fait","groin","groin."],"native_sentence":"돼지가 꿀꿀 울어요."}'),
  ('fr', 'fr_cow_sentence_01', 2, '{"concept_key":"cow","tokens":["La","vache","mange","de","l''herbe."],"native_sentence":"소가 풀을 먹어요."}'),
  ('fr', 'fr_duck_sentence_01', 2, '{"concept_key":"duck","tokens":["Le","canard","nage","dans","l''etang."],"native_sentence":"오리가 연못에서 헤엄쳐요."}'),
  ('fr', 'fr_soup_sentence_01', 2, '{"concept_key":"soup","tokens":["La","soupe","est","chaude."],"native_sentence":"수프가 뜨거워요."}'),
  ('fr', 'fr_cake_sentence_01', 2, '{"concept_key":"cake","tokens":["Je","mange","du","gateau","pour","mon","anniversaire."],"native_sentence":"생일에 케이크를 먹어요."}'),
  ('fr', 'fr_candy_sentence_01', 2, '{"concept_key":"candy","tokens":["Le","bonbon","est","sucre."],"native_sentence":"사탕이 달아요."}'),
  ('fr', 'fr_juice_sentence_01', 2, '{"concept_key":"juice","tokens":["Je","bois","du","jus."],"native_sentence":"주스를 마셔요."}'),
  ('fr', 'fr_mouth_sentence_01', 2, '{"concept_key":"mouth","tokens":["J''ouvre","grand","la","bouche."],"native_sentence":"입을 크게 벌려요."}'),
  ('fr', 'fr_nose_sentence_01', 2, '{"concept_key":"nose","tokens":["Je","respire","par","le","nez."],"native_sentence":"코로 숨을 쉬어요."}'),
  ('fr', 'fr_ear_sentence_01', 2, '{"concept_key":"ear","tokens":["J''entends","des","sons","avec","mes","oreilles."],"native_sentence":"귀로 소리를 들어요."}'),
  ('fr', 'fr_hair_sentence_01', 2, '{"concept_key":"hair","tokens":["Mes","cheveux","sont","longs."],"native_sentence":"머리카락이 길어요."}'),
  ('fr', 'fr_family_sentence_01', 2, '{"concept_key":"family","tokens":["Ma","famille","a","quatre","personnes."],"native_sentence":"우리 가족은 네 명이에요."}'),
  ('fr', 'fr_grandpa_sentence_01', 2, '{"concept_key":"grandpa","tokens":["Grand-pere","lit","le","journal."],"native_sentence":"할아버지가 신문을 읽어요."}'),
  ('fr', 'fr_uncle_sentence_01', 2, '{"concept_key":"uncle","tokens":["Mon","oncle","est","venu","me","rendre","visite."],"native_sentence":"삼촌이 놀러 왔어요."}'),
  ('fr', 'fr_aunt_sentence_01', 2, '{"concept_key":"aunt","tokens":["Ma","tante","m''a","donne","un","cadeau."],"native_sentence":"이모가 선물을 줬어요."}'),
  ('fr', 'fr_five_sentence_01', 2, '{"concept_key":"five","tokens":["Il","y","a","cinq","pommes."],"native_sentence":"사과가 다섯 개 있어요."}'),
  ('fr', 'fr_six_sentence_01', 2, '{"concept_key":"six","tokens":["Il","y","a","six","pommes."],"native_sentence":"사과가 여섯 개 있어요."}'),
  ('fr', 'fr_seven_sentence_01', 2, '{"concept_key":"seven","tokens":["Il","y","a","sept","pommes."],"native_sentence":"사과가 일곱 개 있어요."}'),
  ('fr', 'fr_eight_sentence_01', 2, '{"concept_key":"eight","tokens":["Il","y","a","huit","pommes."],"native_sentence":"사과가 여덟 개 있어요."}'),
  ('fr', 'fr_sky_sentence_01', 2, '{"concept_key":"sky","tokens":["Le","ciel","est","clair."],"native_sentence":"하늘이 맑아요."}'),
  ('fr', 'fr_star_sentence_01', 2, '{"concept_key":"star","tokens":["Les","etoiles","scintillent","dans","le","ciel","nocturne."],"native_sentence":"밤하늘에 별이 반짝여요."}'),
  ('fr', 'fr_cloud_sentence_01', 2, '{"concept_key":"cloud","tokens":["Un","nuage","flotte."],"native_sentence":"구름이 떠 있어요."}'),
  ('fr', 'fr_snow_sentence_01', 2, '{"concept_key":"snow","tokens":["Il","neige","en","hiver."],"native_sentence":"겨울에 눈이 와요."}'),
  ('fr', 'fr_umbrella_sentence_01', 2, '{"concept_key":"umbrella","tokens":["J''utilise","un","parapluie","parce","qu''il","pleut."],"native_sentence":"비가 와서 우산을 써요."}'),
  ('fr', 'fr_clock_sentence_01', 2, '{"concept_key":"clock","tokens":["L''horloge","indique","trois","heures."],"native_sentence":"시계가 세 시를 가리켜요."}'),
  ('fr', 'fr_cup_sentence_01', 2, '{"concept_key":"cup","tokens":["Je","verse","de","l''eau","dans","la","tasse."],"native_sentence":"컵에 물을 담아요."}'),
  ('fr', 'fr_door_sentence_01', 2, '{"concept_key":"door","tokens":["J''ouvre","la","porte."],"native_sentence":"문을 열어요."}'),
  ('fr', 'fr_walk_sentence_01', 2, '{"concept_key":"walk","tokens":["Je","marche","dans","le","parc."],"native_sentence":"공원을 걸어요."}'),
  ('fr', 'fr_jump_sentence_01', 2, '{"concept_key":"jump","tokens":["Je","saute","haut."],"native_sentence":"높이 뛰어요."}'),
  ('fr', 'fr_sing_sentence_01', 2, '{"concept_key":"sing","tokens":["Je","chante","une","chanson."],"native_sentence":"노래를 불러요."}'),
  ('fr', 'fr_drink_sentence_01', 2, '{"concept_key":"drink","tokens":["Je","bois","de","l''eau."],"native_sentence":"물을 마셔요."}'),
  ('fr', 'fr_angry_sentence_01', 2, '{"concept_key":"angry","tokens":["Mon","petit","frere","est","fache."],"native_sentence":"동생이 화가 났어요."}'),
  ('fr', 'fr_tired_sentence_01', 2, '{"concept_key":"tired","tokens":["Je","suis","fatigue","toute","la","journee","aujourd''hui."],"native_sentence":"오늘 하루 종일 피곤해요."}'),
  ('fr', 'fr_hungry_sentence_01', 2, '{"concept_key":"hungry","tokens":["J''ai","faim."],"native_sentence":"배가 고파요."}'),
  ('fr', 'fr_cold_sentence_01', 2, '{"concept_key":"cold","tokens":["Il","fait","froid","aujourd''hui."],"native_sentence":"오늘은 날씨가 추워요."}');
