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
