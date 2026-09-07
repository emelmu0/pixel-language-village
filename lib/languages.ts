// STEP 9: 다국어
// 콘텐츠(word_entries/examples 등)는 concept_id + language_code 조인 방식이라
// 언어를 추가해도 스키마 변경이 필요 없다(PRD 6.2, STEP 9 원칙).
// 이 파일은 "지금 배우는 언어(활성 언어)"를 프로필별로 관리하는 헬퍼다.

import type { SupabaseClient } from "@supabase/supabase-js";

export const NATIVE_LANGUAGE = "ko";

export const TARGET_LANGUAGES: { code: string; label: string }[] = [
  { code: "en", label: "영어" },
  { code: "ja", label: "일본어" },
  { code: "fr", label: "프랑스어" },
];

export const LANGUAGE_LABEL: Record<string, string> = {
  ko: "한국어",
  en: "영어",
  ja: "일본어",
  fr: "프랑스어",
  es: "스페인어",
};

const DEFAULT_TARGET_LANGUAGE = "en";

// 프로필의 활성 학습 언어를 가져온다. 아직 선택한 적이 없으면 영어를 기본값으로
// profile_languages에 만들어 준다(get-or-create).
export async function getActiveTargetLanguage(
  supabase: SupabaseClient,
  profileId: string
): Promise<string> {
  const { data: active } = await supabase
    .from("profile_languages")
    .select("language_code")
    .eq("profile_id", profileId)
    .eq("is_active", true)
    .maybeSingle<{ language_code: string }>();

  if (active) {
    return active.language_code;
  }

  const { data: created } = await supabase
    .from("profile_languages")
    .upsert(
      { profile_id: profileId, language_code: DEFAULT_TARGET_LANGUAGE, is_active: true },
      { onConflict: "profile_id,language_code" }
    )
    .select("language_code")
    .single<{ language_code: string }>();

  return created?.language_code ?? DEFAULT_TARGET_LANGUAGE;
}
