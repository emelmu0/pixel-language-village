-- STEP 10: 콘텐츠 확대 (Level 2 - 초등 기초 확장 어휘, 국립국어원 초급 등급 +
-- 교육부 초등 필수 영단어 800 + JLPT N5 교차검증 36단어)
-- 기존 10개 concept와 겹치지 않는 새 concept 36개 추가.
-- difficulty_level=2로 구분(1=최초 10단어). 한국어/영어/일본어/프랑스어 4개 언어 동시 지원.

insert into public.concepts (concept_key, part_of_speech, difficulty_level, domain, visual_type, image_path)
values
  ('cat', 'noun', 2, '동물', 'illustratable', '/pixel-art/cat.png'),
  ('rabbit', 'noun', 2, '동물', 'illustratable', '/pixel-art/rabbit.png'),
  ('bear', 'noun', 2, '동물', 'illustratable', '/pixel-art/bear.png'),
  ('fish', 'noun', 2, '동물', 'illustratable', '/pixel-art/fish.png'),
  ('rice', 'noun', 2, '음식', 'illustratable', '/pixel-art/rice.png'),
  ('bread', 'noun', 2, '음식', 'illustratable', '/pixel-art/bread.png'),
  ('milk', 'noun', 2, '음식', 'illustratable', '/pixel-art/milk.png'),
  ('egg', 'noun', 2, '음식', 'illustratable', '/pixel-art/egg.png'),
  ('eye', 'noun', 2, '신체', 'illustratable', '/pixel-art/eye.png'),
  ('hand', 'noun', 2, '신체', 'illustratable', '/pixel-art/hand.png'),
  ('foot', 'noun', 2, '신체', 'illustratable', '/pixel-art/foot.png'),
  ('head', 'noun', 2, '신체', 'illustratable', '/pixel-art/head.png'),
  ('mom', 'noun', 2, '가족', 'illustratable', '/pixel-art/mom.png'),
  ('dad', 'noun', 2, '가족', 'illustratable', '/pixel-art/dad.png'),
  ('baby', 'noun', 2, '가족', 'illustratable', '/pixel-art/baby.png'),
  ('grandma', 'noun', 2, '가족', 'illustratable', '/pixel-art/grandma.png'),
  ('red', 'adjective', 2, '색깔', 'illustratable', '/pixel-art/red.png'),
  ('blue', 'adjective', 2, '색깔', 'illustratable', '/pixel-art/blue.png'),
  ('yellow', 'adjective', 2, '색깔', 'illustratable', '/pixel-art/yellow.png'),
  ('green', 'adjective', 2, '색깔', 'illustratable', '/pixel-art/green.png'),
  ('one', 'other', 2, '숫자', 'illustratable', '/pixel-art/one.png'),
  ('two', 'other', 2, '숫자', 'illustratable', '/pixel-art/two.png'),
  ('three', 'other', 2, '숫자', 'illustratable', '/pixel-art/three.png'),
  ('four', 'other', 2, '숫자', 'illustratable', '/pixel-art/four.png'),
  ('sun', 'noun', 2, '자연', 'illustratable', '/pixel-art/sun.png'),
  ('moon', 'noun', 2, '자연', 'illustratable', '/pixel-art/moon.png'),
  ('rain', 'noun', 2, '자연', 'illustratable', '/pixel-art/rain.png'),
  ('tree', 'noun', 2, '자연', 'illustratable', '/pixel-art/tree.png'),
  ('book', 'noun', 2, '사물', 'illustratable', '/pixel-art/book.png'),
  ('pencil', 'noun', 2, '사물', 'illustratable', '/pixel-art/pencil.png'),
  ('chair', 'noun', 2, '사물', 'illustratable', '/pixel-art/chair.png'),
  ('ball', 'noun', 2, '사물', 'illustratable', '/pixel-art/ball.png'),
  ('eat', 'verb', 2, '동작', 'illustratable', '/pixel-art/eat.png'),
  ('sleep', 'verb', 2, '동작', 'illustratable', '/pixel-art/sleep.png'),
  ('happy', 'adjective', 2, '감정', 'illustratable', '/pixel-art/happy.png'),
  ('sad', 'adjective', 2, '감정', 'illustratable', '/pixel-art/sad.png')
on conflict (concept_key) do nothing;

-- 한국어 word_entries
insert into public.word_entries (concept_id, language_code, display_text, definition, difficulty_level)
select c.id, 'ko', v.display_text, v.definition, 2
from public.concepts c
join (values
  ('cat','고양이','고양이'),('rabbit','토끼','토끼'),('bear','곰','곰'),('fish','물고기','물고기'),
  ('rice','밥','밥, 쌀밥'),('bread','빵','빵'),('milk','우유','우유'),('egg','달걀','달걀'),
  ('eye','눈','눈'),('hand','손','손'),('foot','발','발'),('head','머리','머리'),
  ('mom','엄마','엄마'),('dad','아빠','아빠'),('baby','아기','아기'),('grandma','할머니','할머니'),
  ('red','빨간색','빨간색'),('blue','파란색','파란색'),('yellow','노란색','노란색'),('green','초록색','초록색'),
  ('one','하나','하나, 1'),('two','둘','둘, 2'),('three','셋','셋, 3'),('four','넷','넷, 4'),
  ('sun','해','해, 태양'),('moon','달','달'),('rain','비','비'),('tree','나무','나무'),
  ('book','책','책'),('pencil','연필','연필'),('chair','의자','의자'),('ball','공','공'),
  ('eat','먹다','먹다'),('sleep','자다','자다'),('happy','기쁘다','기쁘다'),('sad','슬프다','슬프다')
) as v(concept_key, display_text, definition) on v.concept_key = c.concept_key;

-- 영어 word_entries
insert into public.word_entries (concept_id, language_code, display_text, definition, difficulty_level)
select c.id, 'en', v.display_text, v.definition, 2
from public.concepts c
join (values
  ('cat','cat','a small furry pet animal'),('rabbit','rabbit','a small hopping animal'),
  ('bear','bear','a large furry wild animal'),('fish','fish','an animal that swims in water'),
  ('rice','rice','a staple food grain'),('bread','bread','baked food made from flour'),
  ('milk','milk','a white drink from cows'),('egg','egg','food laid by birds'),
  ('eye','eye','the body part used to see'),('hand','hand','the body part at the end of the arm'),
  ('foot','foot','the body part used to walk'),('head','head','the top part of the body'),
  ('mom','mom','a female parent'),('dad','dad','a male parent'),
  ('baby','baby','a very young child'),('grandma','grandma','a mother''s or father''s mother'),
  ('red','red','the color of blood'),('blue','blue','the color of the sky'),
  ('yellow','yellow','the color of a banana'),('green','green','the color of grass'),
  ('one','one','the number 1'),('two','two','the number 2'),
  ('three','three','the number 3'),('four','four','the number 4'),
  ('sun','sun','the star that gives us light'),('moon','moon','the object seen in the night sky'),
  ('rain','rain','water falling from the sky'),('tree','tree','a tall plant with a trunk'),
  ('book','book','pages bound together to read'),('pencil','pencil','a tool used to write'),
  ('chair','chair','furniture used to sit on'),('ball','ball','a round object used in games'),
  ('eat','eat','to put food in your mouth and swallow it'),('sleep','sleep','to rest with closed eyes'),
  ('happy','happy','feeling joy'),('sad','sad','feeling unhappy')
) as v(concept_key, display_text, definition) on v.concept_key = c.concept_key;

-- 일본어 word_entries
insert into public.word_entries (concept_id, language_code, display_text, definition, difficulty_level)
select c.id, 'ja', v.display_text, v.definition, 2
from public.concepts c
join (values
  ('cat','ねこ','ねこ'),('rabbit','うさぎ','うさぎ'),('bear','くま','くま'),('fish','さかな','さかな'),
  ('rice','ごはん','ごはん'),('bread','パン','パン'),('milk','ぎゅうにゅう','ぎゅうにゅう'),('egg','たまご','たまご'),
  ('eye','め','め'),('hand','て','て'),('foot','あし','あし'),('head','あたま','あたま'),
  ('mom','おかあさん','おかあさん'),('dad','おとうさん','おとうさん'),('baby','あかちゃん','あかちゃん'),('grandma','おばあさん','おばあさん'),
  ('red','あか','あか'),('blue','あお','あお'),('yellow','きいろ','きいろ'),('green','みどり','みどり'),
  ('one','いち','いち, 1'),('two','に','に, 2'),('three','さん','さん, 3'),('four','よん','よん, 4'),
  ('sun','たいよう','たいよう'),('moon','つき','つき'),('rain','あめ','あめ'),('tree','き','き'),
  ('book','ほん','ほん'),('pencil','えんぴつ','えんぴつ'),('chair','いす','いす'),('ball','ボール','ボール'),
  ('eat','たべる','たべる'),('sleep','ねる','ねる'),('happy','うれしい','うれしい'),('sad','かなしい','かなしい')
) as v(concept_key, display_text, definition) on v.concept_key = c.concept_key;

-- 프랑스어 word_entries
insert into public.word_entries (concept_id, language_code, display_text, definition, difficulty_level)
select c.id, 'fr', v.display_text, v.definition, 2
from public.concepts c
join (values
  ('cat','chat','chat'),('rabbit','lapin','lapin'),('bear','ours','ours'),('fish','poisson','poisson'),
  ('rice','riz','riz'),('bread','pain','pain'),('milk','lait','lait'),('egg','oeuf','oeuf'),
  ('eye','oeil','oeil'),('hand','main','main'),('foot','pied','pied'),('head','tete','tete'),
  ('mom','maman','maman'),('dad','papa','papa'),('baby','bebe','bebe'),('grandma','grand-mere','grand-mere'),
  ('red','rouge','rouge'),('blue','bleu','bleu'),('yellow','jaune','jaune'),('green','vert','vert'),
  ('one','un','un, 1'),('two','deux','deux, 2'),('three','trois','trois, 3'),('four','quatre','quatre, 4'),
  ('sun','soleil','soleil'),('moon','lune','lune'),('rain','pluie','pluie'),('tree','arbre','arbre'),
  ('book','livre','livre'),('pencil','crayon','crayon'),('chair','chaise','chaise'),('ball','ballon','ballon'),
  ('eat','manger','manger'),('sleep','dormir','dormir'),('happy','content','content'),('sad','triste','triste')
) as v(concept_key, display_text, definition) on v.concept_key = c.concept_key;

-- 한국어 examples
insert into public.examples (concept_id, language_code, sentence, difficulty_level, village_compatible)
select c.id, 'ko', v.sentence, 2, true
from public.concepts c
join (values
  ('cat','고양이가 나무 위에 있어요.'),('rabbit','토끼가 깡충깡충 뛰어요.'),('bear','곰이 숲속에서 자요.'),
  ('fish','물고기가 강에서 헤엄쳐요.'),('rice','저녁에 밥을 먹어요.'),('bread','아침에 빵을 먹어요.'),
  ('milk','우유를 마셔요.'),('egg','아침에 달걀을 먹어요.'),('eye','눈을 크게 떠요.'),
  ('hand','손을 씻어요.'),('foot','발이 아파요.'),('head','머리에 모자를 써요.'),
  ('mom','엄마가 요리를 해요.'),('dad','아빠가 운전을 해요.'),('baby','아기가 울어요.'),
  ('grandma','할머니가 이야기를 해줘요.'),('red','사과는 빨간색이에요.'),('blue','하늘이 파래요.'),
  ('yellow','바나나는 노란색이에요.'),('green','풀이 초록색이에요.'),('one','사과가 하나 있어요.'),
  ('two','사과가 둘 있어요.'),('three','사과가 셋 있어요.'),('four','사과가 넷 있어요.'),
  ('sun','해가 밝게 빛나요.'),('moon','밤에 달이 떠요.'),('rain','비가 내려요.'),
  ('tree','나무가 높이 자라요.'),('book','책을 읽어요.'),('pencil','연필로 글씨를 써요.'),
  ('chair','의자에 앉아요.'),('ball','공을 던져요.'),('eat','밥을 먹어요.'),
  ('sleep','밤에 자요.'),('happy','선물을 받아서 기뻐요.'),('sad','장난감이 망가져서 슬퍼요.')
) as v(concept_key, sentence) on v.concept_key = c.concept_key;

-- 영어 examples
insert into public.examples (concept_id, language_code, sentence, difficulty_level, village_compatible)
select c.id, 'en', v.sentence, 2, true
from public.concepts c
join (values
  ('cat','The cat is on the tree.'),('rabbit','The rabbit is hopping.'),('bear','The bear is sleeping in the forest.'),
  ('fish','The fish is swimming in the river.'),('rice','I eat rice for dinner.'),('bread','I eat bread in the morning.'),
  ('milk','I drink milk.'),('egg','I eat an egg in the morning.'),('eye','I open my eyes wide.'),
  ('hand','I wash my hands.'),('foot','My foot hurts.'),('head','I wear a hat on my head.'),
  ('mom','Mom is cooking.'),('dad','Dad is driving.'),('baby','The baby is crying.'),
  ('grandma','Grandma tells a story.'),('red','The apple is red.'),('blue','The sky is blue.'),
  ('yellow','The banana is yellow.'),('green','The grass is green.'),('one','There is one apple.'),
  ('two','There are two apples.'),('three','There are three apples.'),('four','There are four apples.'),
  ('sun','The sun shines brightly.'),('moon','The moon rises at night.'),('rain','It is raining.'),
  ('tree','The tree grows tall.'),('book','I read a book.'),('pencil','I write with a pencil.'),
  ('chair','I sit on the chair.'),('ball','I throw the ball.'),('eat','I eat rice.'),
  ('sleep','I sleep at night.'),('happy','I am happy because I got a gift.'),('sad','I am sad because my toy broke.')
) as v(concept_key, sentence) on v.concept_key = c.concept_key;

-- 일본어 examples
insert into public.examples (concept_id, language_code, sentence, difficulty_level, village_compatible)
select c.id, 'ja', v.sentence, 2, true
from public.concepts c
join (values
  ('cat','猫が木の上にいます。'),('rabbit','うさぎが跳ねています。'),('bear','くまが森で寝ています。'),
  ('fish','魚が川で泳いでいます。'),('rice','夜にご飯を食べます。'),('bread','朝にパンを食べます。'),
  ('milk','牛乳を飲みます。'),('egg','朝に卵を食べます。'),('eye','目を大きく開けます。'),
  ('hand','手を洗います。'),('foot','足が痛いです。'),('head','頭に帽子をかぶります。'),
  ('mom','お母さんが料理をします。'),('dad','お父さんが運転をします。'),('baby','赤ちゃんが泣いています。'),
  ('grandma','おばあさんが話をしてくれます。'),('red','りんごは赤いです。'),('blue','空は青いです。'),
  ('yellow','バナナは黄色いです。'),('green','草は緑色です。'),('one','りんごが一つあります。'),
  ('two','りんごが二つあります。'),('three','りんごが三つあります。'),('four','りんごが四つあります。'),
  ('sun','太陽が明るく輝きます。'),('moon','夜に月が出ます。'),('rain','雨が降っています。'),
  ('tree','木が高く育ちます。'),('book','本を読みます。'),('pencil','鉛筆で字を書きます。'),
  ('chair','椅子に座ります。'),('ball','ボールを投げます。'),('eat','ご飯を食べます。'),
  ('sleep','夜に寝ます。'),('happy','プレゼントをもらって嬉しいです。'),('sad','おもちゃが壊れて悲しいです。')
) as v(concept_key, sentence) on v.concept_key = c.concept_key;

-- 프랑스어 examples
insert into public.examples (concept_id, language_code, sentence, difficulty_level, village_compatible)
select c.id, 'fr', v.sentence, 2, true
from public.concepts c
join (values
  ('cat','Le chat est sur l''arbre.'),('rabbit','Le lapin saute.'),('bear','L''ours dort dans la foret.'),
  ('fish','Le poisson nage dans la riviere.'),('rice','Je mange du riz le soir.'),('bread','Je mange du pain le matin.'),
  ('milk','Je bois du lait.'),('egg','Je mange un oeuf le matin.'),('eye','J''ouvre grand les yeux.'),
  ('hand','Je me lave les mains.'),('foot','J''ai mal au pied.'),('head','Je porte un chapeau sur la tete.'),
  ('mom','Maman cuisine.'),('dad','Papa conduit.'),('baby','Le bebe pleure.'),
  ('grandma','Grand-mere raconte une histoire.'),('red','La pomme est rouge.'),('blue','Le ciel est bleu.'),
  ('yellow','La banane est jaune.'),('green','L''herbe est verte.'),('one','Il y a une pomme.'),
  ('two','Il y a deux pommes.'),('three','Il y a trois pommes.'),('four','Il y a quatre pommes.'),
  ('sun','Le soleil brille fort.'),('moon','La lune se leve la nuit.'),('rain','Il pleut.'),
  ('tree','L''arbre pousse haut.'),('book','Je lis un livre.'),('pencil','J''ecris avec un crayon.'),
  ('chair','Je m''assois sur la chaise.'),('ball','Je lance le ballon.'),('eat','Je mange du riz.'),
  ('sleep','Je dors la nuit.'),('happy','Je suis content parce que j''ai recu un cadeau.'),
  ('sad','Je suis triste parce que mon jouet est casse.')
) as v(concept_key, sentence) on v.concept_key = c.concept_key;

-- 영어 문장 미션
insert into public.sentence_patterns (language_code, pattern_key, difficulty_level, structure_json)
values
  ('en', 'cat_sentence_01', 2, '{"concept_key":"cat","tokens":["The","cat","is","on","the","tree."],"native_sentence":"고양이가 나무 위에 있어요."}'),
  ('en', 'rabbit_sentence_01', 2, '{"concept_key":"rabbit","tokens":["The","rabbit","is","hopping."],"native_sentence":"토끼가 깡충깡충 뛰어요."}'),
  ('en', 'bear_sentence_01', 2, '{"concept_key":"bear","tokens":["The","bear","is","sleeping","in","the","forest."],"native_sentence":"곰이 숲속에서 자요."}'),
  ('en', 'fish_sentence_01', 2, '{"concept_key":"fish","tokens":["The","fish","is","swimming","in","the","river."],"native_sentence":"물고기가 강에서 헤엄쳐요."}'),
  ('en', 'rice_sentence_01', 2, '{"concept_key":"rice","tokens":["I","eat","rice","for","dinner."],"native_sentence":"저녁에 밥을 먹어요."}'),
  ('en', 'bread_sentence_01', 2, '{"concept_key":"bread","tokens":["I","eat","bread","in","the","morning."],"native_sentence":"아침에 빵을 먹어요."}'),
  ('en', 'milk_sentence_01', 2, '{"concept_key":"milk","tokens":["I","drink","milk."],"native_sentence":"우유를 마셔요."}'),
  ('en', 'egg_sentence_01', 2, '{"concept_key":"egg","tokens":["I","eat","an","egg","in","the","morning."],"native_sentence":"아침에 달걀을 먹어요."}'),
  ('en', 'eye_sentence_01', 2, '{"concept_key":"eye","tokens":["I","open","my","eyes","wide."],"native_sentence":"눈을 크게 떠요."}'),
  ('en', 'hand_sentence_01', 2, '{"concept_key":"hand","tokens":["I","wash","my","hands."],"native_sentence":"손을 씻어요."}'),
  ('en', 'foot_sentence_01', 2, '{"concept_key":"foot","tokens":["My","foot","hurts."],"native_sentence":"발이 아파요."}'),
  ('en', 'head_sentence_01', 2, '{"concept_key":"head","tokens":["I","wear","a","hat","on","my","head."],"native_sentence":"머리에 모자를 써요."}'),
  ('en', 'mom_sentence_01', 2, '{"concept_key":"mom","tokens":["Mom","is","cooking."],"native_sentence":"엄마가 요리를 해요."}'),
  ('en', 'dad_sentence_01', 2, '{"concept_key":"dad","tokens":["Dad","is","driving."],"native_sentence":"아빠가 운전을 해요."}'),
  ('en', 'baby_sentence_01', 2, '{"concept_key":"baby","tokens":["The","baby","is","crying."],"native_sentence":"아기가 울어요."}'),
  ('en', 'grandma_sentence_01', 2, '{"concept_key":"grandma","tokens":["Grandma","tells","a","story."],"native_sentence":"할머니가 이야기를 해줘요."}'),
  ('en', 'red_sentence_01', 2, '{"concept_key":"red","tokens":["The","apple","is","red."],"native_sentence":"사과는 빨간색이에요."}'),
  ('en', 'blue_sentence_01', 2, '{"concept_key":"blue","tokens":["The","sky","is","blue."],"native_sentence":"하늘이 파래요."}'),
  ('en', 'yellow_sentence_01', 2, '{"concept_key":"yellow","tokens":["The","banana","is","yellow."],"native_sentence":"바나나는 노란색이에요."}'),
  ('en', 'green_sentence_01', 2, '{"concept_key":"green","tokens":["The","grass","is","green."],"native_sentence":"풀이 초록색이에요."}'),
  ('en', 'one_sentence_01', 2, '{"concept_key":"one","tokens":["There","is","one","apple."],"native_sentence":"사과가 하나 있어요."}'),
  ('en', 'two_sentence_01', 2, '{"concept_key":"two","tokens":["There","are","two","apples."],"native_sentence":"사과가 둘 있어요."}'),
  ('en', 'three_sentence_01', 2, '{"concept_key":"three","tokens":["There","are","three","apples."],"native_sentence":"사과가 셋 있어요."}'),
  ('en', 'four_sentence_01', 2, '{"concept_key":"four","tokens":["There","are","four","apples."],"native_sentence":"사과가 넷 있어요."}'),
  ('en', 'sun_sentence_01', 2, '{"concept_key":"sun","tokens":["The","sun","shines","brightly."],"native_sentence":"해가 밝게 빛나요."}'),
  ('en', 'moon_sentence_01', 2, '{"concept_key":"moon","tokens":["The","moon","rises","at","night."],"native_sentence":"밤에 달이 떠요."}'),
  ('en', 'rain_sentence_01', 2, '{"concept_key":"rain","tokens":["It","is","raining."],"native_sentence":"비가 내려요."}'),
  ('en', 'tree_sentence_01', 2, '{"concept_key":"tree","tokens":["The","tree","grows","tall."],"native_sentence":"나무가 높이 자라요."}'),
  ('en', 'book_sentence_01', 2, '{"concept_key":"book","tokens":["I","read","a","book."],"native_sentence":"책을 읽어요."}'),
  ('en', 'pencil_sentence_01', 2, '{"concept_key":"pencil","tokens":["I","write","with","a","pencil."],"native_sentence":"연필로 글씨를 써요."}'),
  ('en', 'chair_sentence_01', 2, '{"concept_key":"chair","tokens":["I","sit","on","the","chair."],"native_sentence":"의자에 앉아요."}'),
  ('en', 'ball_sentence_01', 2, '{"concept_key":"ball","tokens":["I","throw","the","ball."],"native_sentence":"공을 던져요."}'),
  ('en', 'eat_sentence_01', 2, '{"concept_key":"eat","tokens":["I","eat","rice."],"native_sentence":"밥을 먹어요."}'),
  ('en', 'sleep_sentence_01', 2, '{"concept_key":"sleep","tokens":["I","sleep","at","night."],"native_sentence":"밤에 자요."}'),
  ('en', 'happy_sentence_01', 2, '{"concept_key":"happy","tokens":["I","am","happy","because","I","got","a","gift."],"native_sentence":"선물을 받아서 기뻐요."}'),
  ('en', 'sad_sentence_01', 2, '{"concept_key":"sad","tokens":["I","am","sad","because","my","toy","broke."],"native_sentence":"장난감이 망가져서 슬퍼요."}');

-- 일본어 문장 미션
insert into public.sentence_patterns (language_code, pattern_key, difficulty_level, structure_json)
values
  ('ja', 'ja_cat_sentence_01', 2, '{"concept_key":"cat","tokens":["ねこが","きの","うえに","います。"],"native_sentence":"고양이가 나무 위에 있어요."}'),
  ('ja', 'ja_rabbit_sentence_01', 2, '{"concept_key":"rabbit","tokens":["うさぎが","はねて","います。"],"native_sentence":"토끼가 깡충깡충 뛰어요."}'),
  ('ja', 'ja_bear_sentence_01', 2, '{"concept_key":"bear","tokens":["くまが","もりで","ねて","います。"],"native_sentence":"곰이 숲속에서 자요."}'),
  ('ja', 'ja_fish_sentence_01', 2, '{"concept_key":"fish","tokens":["さかなが","かわで","およいで","います。"],"native_sentence":"물고기가 강에서 헤엄쳐요."}'),
  ('ja', 'ja_rice_sentence_01', 2, '{"concept_key":"rice","tokens":["よるに","ごはんを","たべます。"],"native_sentence":"저녁에 밥을 먹어요."}'),
  ('ja', 'ja_bread_sentence_01', 2, '{"concept_key":"bread","tokens":["あさに","パンを","たべます。"],"native_sentence":"아침에 빵을 먹어요."}'),
  ('ja', 'ja_milk_sentence_01', 2, '{"concept_key":"milk","tokens":["ぎゅうにゅうを","のみます。"],"native_sentence":"우유를 마셔요."}'),
  ('ja', 'ja_egg_sentence_01', 2, '{"concept_key":"egg","tokens":["あさに","たまごを","たべます。"],"native_sentence":"아침에 달걀을 먹어요."}'),
  ('ja', 'ja_eye_sentence_01', 2, '{"concept_key":"eye","tokens":["めを","おおきく","あけます。"],"native_sentence":"눈을 크게 떠요."}'),
  ('ja', 'ja_hand_sentence_01', 2, '{"concept_key":"hand","tokens":["てを","あらいます。"],"native_sentence":"손을 씻어요."}'),
  ('ja', 'ja_foot_sentence_01', 2, '{"concept_key":"foot","tokens":["あしが","いたいです。"],"native_sentence":"발이 아파요."}'),
  ('ja', 'ja_head_sentence_01', 2, '{"concept_key":"head","tokens":["あたまに","ぼうしを","かぶります。"],"native_sentence":"머리에 모자를 써요."}'),
  ('ja', 'ja_mom_sentence_01', 2, '{"concept_key":"mom","tokens":["おかあさんが","りょうりを","します。"],"native_sentence":"엄마가 요리를 해요."}'),
  ('ja', 'ja_dad_sentence_01', 2, '{"concept_key":"dad","tokens":["おとうさんが","うんてんを","します。"],"native_sentence":"아빠가 운전을 해요."}'),
  ('ja', 'ja_baby_sentence_01', 2, '{"concept_key":"baby","tokens":["あかちゃんが","ないて","います。"],"native_sentence":"아기가 울어요."}'),
  ('ja', 'ja_grandma_sentence_01', 2, '{"concept_key":"grandma","tokens":["おばあさんが","はなしを","してくれます。"],"native_sentence":"할머니가 이야기를 해줘요."}'),
  ('ja', 'ja_red_sentence_01', 2, '{"concept_key":"red","tokens":["りんごは","あかいです。"],"native_sentence":"사과는 빨간색이에요."}'),
  ('ja', 'ja_blue_sentence_01', 2, '{"concept_key":"blue","tokens":["そらは","あおいです。"],"native_sentence":"하늘이 파래요."}'),
  ('ja', 'ja_yellow_sentence_01', 2, '{"concept_key":"yellow","tokens":["バナナは","きいろいです。"],"native_sentence":"바나나는 노란색이에요."}'),
  ('ja', 'ja_green_sentence_01', 2, '{"concept_key":"green","tokens":["くさは","みどりいろです。"],"native_sentence":"풀이 초록색이에요."}'),
  ('ja', 'ja_one_sentence_01', 2, '{"concept_key":"one","tokens":["りんごが","ひとつ","あります。"],"native_sentence":"사과가 하나 있어요."}'),
  ('ja', 'ja_two_sentence_01', 2, '{"concept_key":"two","tokens":["りんごが","ふたつ","あります。"],"native_sentence":"사과가 둘 있어요."}'),
  ('ja', 'ja_three_sentence_01', 2, '{"concept_key":"three","tokens":["りんごが","みっつ","あります。"],"native_sentence":"사과가 셋 있어요."}'),
  ('ja', 'ja_four_sentence_01', 2, '{"concept_key":"four","tokens":["りんごが","よっつ","あります。"],"native_sentence":"사과가 넷 있어요."}'),
  ('ja', 'ja_sun_sentence_01', 2, '{"concept_key":"sun","tokens":["たいようが","あかるく","かがやきます。"],"native_sentence":"해가 밝게 빛나요."}'),
  ('ja', 'ja_moon_sentence_01', 2, '{"concept_key":"moon","tokens":["よるに","つきが","でます。"],"native_sentence":"밤에 달이 떠요."}'),
  ('ja', 'ja_rain_sentence_01', 2, '{"concept_key":"rain","tokens":["あめが","ふって","います。"],"native_sentence":"비가 내려요."}'),
  ('ja', 'ja_tree_sentence_01', 2, '{"concept_key":"tree","tokens":["きが","たかく","そだちます。"],"native_sentence":"나무가 높이 자라요."}'),
  ('ja', 'ja_book_sentence_01', 2, '{"concept_key":"book","tokens":["ほんを","よみます。"],"native_sentence":"책을 읽어요."}'),
  ('ja', 'ja_pencil_sentence_01', 2, '{"concept_key":"pencil","tokens":["えんぴつで","じを","かきます。"],"native_sentence":"연필로 글씨를 써요."}'),
  ('ja', 'ja_chair_sentence_01', 2, '{"concept_key":"chair","tokens":["いすに","すわります。"],"native_sentence":"의자에 앉아요."}'),
  ('ja', 'ja_ball_sentence_01', 2, '{"concept_key":"ball","tokens":["ボールを","なげます。"],"native_sentence":"공을 던져요."}'),
  ('ja', 'ja_eat_sentence_01', 2, '{"concept_key":"eat","tokens":["ごはんを","たべます。"],"native_sentence":"밥을 먹어요."}'),
  ('ja', 'ja_sleep_sentence_01', 2, '{"concept_key":"sleep","tokens":["よるに","ねます。"],"native_sentence":"밤에 자요."}'),
  ('ja', 'ja_happy_sentence_01', 2, '{"concept_key":"happy","tokens":["プレゼントを","もらって","うれしいです。"],"native_sentence":"선물을 받아서 기뻐요."}'),
  ('ja', 'ja_sad_sentence_01', 2, '{"concept_key":"sad","tokens":["おもちゃが","こわれて","かなしいです。"],"native_sentence":"장난감이 망가져서 슬퍼요."}');

-- 프랑스어 문장 미션
insert into public.sentence_patterns (language_code, pattern_key, difficulty_level, structure_json)
values
  ('fr', 'fr_cat_sentence_01', 2, '{"concept_key":"cat","tokens":["Le","chat","est","sur","l''arbre."],"native_sentence":"고양이가 나무 위에 있어요."}'),
  ('fr', 'fr_rabbit_sentence_01', 2, '{"concept_key":"rabbit","tokens":["Le","lapin","saute."],"native_sentence":"토끼가 깡충깡충 뛰어요."}'),
  ('fr', 'fr_bear_sentence_01', 2, '{"concept_key":"bear","tokens":["L''ours","dort","dans","la","foret."],"native_sentence":"곰이 숲속에서 자요."}'),
  ('fr', 'fr_fish_sentence_01', 2, '{"concept_key":"fish","tokens":["Le","poisson","nage","dans","la","riviere."],"native_sentence":"물고기가 강에서 헤엄쳐요."}'),
  ('fr', 'fr_rice_sentence_01', 2, '{"concept_key":"rice","tokens":["Je","mange","du","riz","le","soir."],"native_sentence":"저녁에 밥을 먹어요."}'),
  ('fr', 'fr_bread_sentence_01', 2, '{"concept_key":"bread","tokens":["Je","mange","du","pain","le","matin."],"native_sentence":"아침에 빵을 먹어요."}'),
  ('fr', 'fr_milk_sentence_01', 2, '{"concept_key":"milk","tokens":["Je","bois","du","lait."],"native_sentence":"우유를 마셔요."}'),
  ('fr', 'fr_egg_sentence_01', 2, '{"concept_key":"egg","tokens":["Je","mange","un","oeuf","le","matin."],"native_sentence":"아침에 달걀을 먹어요."}'),
  ('fr', 'fr_eye_sentence_01', 2, '{"concept_key":"eye","tokens":["J''ouvre","grand","les","yeux."],"native_sentence":"눈을 크게 떠요."}'),
  ('fr', 'fr_hand_sentence_01', 2, '{"concept_key":"hand","tokens":["Je","me","lave","les","mains."],"native_sentence":"손을 씻어요."}'),
  ('fr', 'fr_foot_sentence_01', 2, '{"concept_key":"foot","tokens":["J''ai","mal","au","pied."],"native_sentence":"발이 아파요."}'),
  ('fr', 'fr_head_sentence_01', 2, '{"concept_key":"head","tokens":["Je","porte","un","chapeau","sur","la","tete."],"native_sentence":"머리에 모자를 써요."}'),
  ('fr', 'fr_mom_sentence_01', 2, '{"concept_key":"mom","tokens":["Maman","cuisine."],"native_sentence":"엄마가 요리를 해요."}'),
  ('fr', 'fr_dad_sentence_01', 2, '{"concept_key":"dad","tokens":["Papa","conduit."],"native_sentence":"아빠가 운전을 해요."}'),
  ('fr', 'fr_baby_sentence_01', 2, '{"concept_key":"baby","tokens":["Le","bebe","pleure."],"native_sentence":"아기가 울어요."}'),
  ('fr', 'fr_grandma_sentence_01', 2, '{"concept_key":"grandma","tokens":["Grand-mere","raconte","une","histoire."],"native_sentence":"할머니가 이야기를 해줘요."}'),
  ('fr', 'fr_red_sentence_01', 2, '{"concept_key":"red","tokens":["La","pomme","est","rouge."],"native_sentence":"사과는 빨간색이에요."}'),
  ('fr', 'fr_blue_sentence_01', 2, '{"concept_key":"blue","tokens":["Le","ciel","est","bleu."],"native_sentence":"하늘이 파래요."}'),
  ('fr', 'fr_yellow_sentence_01', 2, '{"concept_key":"yellow","tokens":["La","banane","est","jaune."],"native_sentence":"바나나는 노란색이에요."}'),
  ('fr', 'fr_green_sentence_01', 2, '{"concept_key":"green","tokens":["L''herbe","est","verte."],"native_sentence":"풀이 초록색이에요."}'),
  ('fr', 'fr_one_sentence_01', 2, '{"concept_key":"one","tokens":["Il","y","a","une","pomme."],"native_sentence":"사과가 하나 있어요."}'),
  ('fr', 'fr_two_sentence_01', 2, '{"concept_key":"two","tokens":["Il","y","a","deux","pommes."],"native_sentence":"사과가 둘 있어요."}'),
  ('fr', 'fr_three_sentence_01', 2, '{"concept_key":"three","tokens":["Il","y","a","trois","pommes."],"native_sentence":"사과가 셋 있어요."}'),
  ('fr', 'fr_four_sentence_01', 2, '{"concept_key":"four","tokens":["Il","y","a","quatre","pommes."],"native_sentence":"사과가 넷 있어요."}'),
  ('fr', 'fr_sun_sentence_01', 2, '{"concept_key":"sun","tokens":["Le","soleil","brille","fort."],"native_sentence":"해가 밝게 빛나요."}'),
  ('fr', 'fr_moon_sentence_01', 2, '{"concept_key":"moon","tokens":["La","lune","se","leve","la","nuit."],"native_sentence":"밤에 달이 떠요."}'),
  ('fr', 'fr_rain_sentence_01', 2, '{"concept_key":"rain","tokens":["Il","pleut."],"native_sentence":"비가 내려요."}'),
  ('fr', 'fr_tree_sentence_01', 2, '{"concept_key":"tree","tokens":["L''arbre","pousse","haut."],"native_sentence":"나무가 높이 자라요."}'),
  ('fr', 'fr_book_sentence_01', 2, '{"concept_key":"book","tokens":["Je","lis","un","livre."],"native_sentence":"책을 읽어요."}'),
  ('fr', 'fr_pencil_sentence_01', 2, '{"concept_key":"pencil","tokens":["J''ecris","avec","un","crayon."],"native_sentence":"연필로 글씨를 써요."}'),
  ('fr', 'fr_chair_sentence_01', 2, '{"concept_key":"chair","tokens":["Je","m''assois","sur","la","chaise."],"native_sentence":"의자에 앉아요."}'),
  ('fr', 'fr_ball_sentence_01', 2, '{"concept_key":"ball","tokens":["Je","lance","le","ballon."],"native_sentence":"공을 던져요."}'),
  ('fr', 'fr_eat_sentence_01', 2, '{"concept_key":"eat","tokens":["Je","mange","du","riz."],"native_sentence":"밥을 먹어요."}'),
  ('fr', 'fr_sleep_sentence_01', 2, '{"concept_key":"sleep","tokens":["Je","dors","la","nuit."],"native_sentence":"밤에 자요."}'),
  ('fr', 'fr_happy_sentence_01', 2, '{"concept_key":"happy","tokens":["Je","suis","content","parce","que","j''ai","recu","un","cadeau."],"native_sentence":"선물을 받아서 기뻐요."}'),
  ('fr', 'fr_sad_sentence_01', 2, '{"concept_key":"sad","tokens":["Je","suis","triste","parce","que","mon","jouet","est","casse."],"native_sentence":"장난감이 망가져서 슬퍼요."}');
