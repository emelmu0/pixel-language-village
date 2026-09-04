# Pixel Language Village

카드로 단어를 익히고, 문장을 조합하며, 배운 말이 픽셀 마을의 성장으로
나타나는 웹 기반 언어학습 앱입니다.

기획 문서: [`docs/PRD.md`](./docs/PRD.md)

## 스택

- Next.js (App Router) + TypeScript
- Tailwind CSS
- Supabase (PostgreSQL, Auth, Storage, RLS)
- GitHub + Vercel

## 개발 시작하기

```bash
npm install
cp .env.local.example .env.local   # 값 채우기
npm run dev
```

## 진행 상태

- [x] STEP 1 — 프로젝트 기반 (Next.js + TypeScript, 폴더 구조, 환경변수 템플릿)
- [x] STEP 2 — 인증과 프로필
- [x] STEP 3 — 카드 DB (concepts / word_entries / examples / card_progress + 테스트 단어 10개)
- [x] STEP 4 — 단어 카드 UI (프로필별 카드 뒤집기 + 자가평가 저장)
- [x] STEP 5 — 학습 기록 (오늘의 기록 / 누적 기록 / 언어별 기록)
- [ ] STEP 6 — 첫 픽셀 마을
- [ ] STEP 7 — 문장 모드
- [ ] STEP 8 — 마을 예문
- [ ] STEP 9 — 다국어
- [ ] STEP 10 — 콘텐츠 확대

전체 로드맵은 `docs/PRD.md` 28장(개발 단계)을 참고하세요.
