// 공용 타입 정의 위치.
// STEP 3(카드 DB) 진행 시 concepts / word_entries / examples / card_progress 등의
// 타입을 이곳에 추가합니다. (PRD 20장 데이터베이스 초안 참고)

export type Profile = {
  id: string;
  owner_user_id: string;
  nickname: string;
  avatar: string | null;
  current_level: number;
  primary_language: string;
  created_at: string;
};

export type Concept = {
  id: string;
  concept_key: string;
  part_of_speech: string;
  difficulty_level: number;
  domain: string | null;
  visual_type: string;
  image_path: string | null;
  created_at: string;
};

export type WordEntry = {
  id: string;
  concept_id: string;
  language_code: string;
  display_text: string;
  reading: string | null;
  pronunciation_hint: string | null;
  definition: string | null;
  difficulty_level: number;
  created_at: string;
};

export type Example = {
  id: string;
  concept_id: string;
  language_code: string;
  sentence: string;
  difficulty_level: number;
  village_compatible: boolean;
  created_at: string;
};

export type CardProgress = {
  id: string;
  profile_id: string;
  concept_id: string;
  language_code: string;
  mastery_level: number;
  correct_count: number;
  review_count: number;
  last_reviewed_at: string | null;
  updated_at: string;
};

export type VillageProfile = {
  id: string;
  profile_id: string;
  theme_key: string;
  village_level: number;
  xp: number;
  created_at: string;
  updated_at: string;
};

export type SentencePattern = {
  id: string;
  language_code: string;
  pattern_key: string;
  difficulty_level: number;
  structure_json: {
    concept_key: string;
    tokens: string[];
    native_sentence: string;
  };
  created_at: string;
};

export type LearnedSentence = {
  id: string;
  profile_id: string;
  language_code: string;
  sentence_pattern_id: string;
  sentence_text: string;
  created_at: string;
};

export type VillageEvent = {
  id: string;
  profile_id: string;
  concept_id: string;
  example_id: string | null;
  event_type: string;
  shown_at: string;
  completed_at: string | null;
};
