import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import SentenceMissionClient from "@/components/sentences/SentenceMissionClient";
import { getActiveTargetLanguage } from "@/lib/languages";
import type { CardProgress, Concept, Profile, SentencePattern } from "@/types";

const MASTERY_THRESHOLD = 4;

export default async function SentencesPage({
  searchParams,
}: {
  searchParams: Promise<{ profile?: string }>;
}) {
  const { profile: profileId } = await searchParams;
  const supabase = await createClient();

  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    redirect("/login");
  }

  if (!profileId) {
    redirect("/profiles");
  }

  const { data: profile } = await supabase
    .from("profiles")
    .select("*")
    .eq("id", profileId)
    .single<Profile>();

  if (!profile) {
    redirect("/profiles");
  }

  const activeLanguage = await getActiveTargetLanguage(supabase, profile.id);

  const { data: progressRows } = await supabase
    .from("card_progress")
    .select("*")
    .eq("profile_id", profileId)
    .eq("language_code", activeLanguage)
    .returns<CardProgress[]>();

  const masteredConceptIds = new Set(
    (progressRows ?? [])
      .filter((p) => p.mastery_level >= MASTERY_THRESHOLD)
      .map((p) => p.concept_id)
  );

  const { data: concepts } = await supabase
    .from("concepts")
    .select("*")
    .returns<Concept[]>();

  const masteredConceptKeys = new Set(
    (concepts ?? [])
      .filter((c) => masteredConceptIds.has(c.id))
      .map((c) => c.concept_key)
  );

  const { data: allPatterns } = await supabase
    .from("sentence_patterns")
    .select("*")
    .eq("language_code", activeLanguage)
    .returns<SentencePattern[]>();

  const unlockedPatterns = (allPatterns ?? []).filter((p) =>
    masteredConceptKeys.has(p.structure_json.concept_key)
  );

  const totalPatterns = allPatterns?.length ?? 0;

  return (
    <main className="min-h-screen bg-zinc-50 px-6 py-10 dark:bg-black">
      <div className="mx-auto flex w-full max-w-lg flex-col gap-6">
        <div className="flex items-center justify-between">
          <div>
            <h1 className="text-xl font-bold text-zinc-900 dark:text-zinc-50">문장 만들기</h1>
            <p className="text-sm text-zinc-500">
              {profile.avatar ?? "🙂"} {profile.nickname}
            </p>
          </div>
          <div className="flex items-center gap-3">
            <Link
              href={`/words?profile=${profile.id}`}
              className="text-sm text-zinc-500 underline underline-offset-2"
            >
              단어 카드
            </Link>
            <Link
              href="/profiles"
              className="text-sm text-zinc-500 underline underline-offset-2"
            >
              프로필 목록
            </Link>
          </div>
        </div>

        <p className="text-sm text-zinc-500">
          잘 아는 단어 {unlockedPatterns.length} / {totalPatterns}개로 문장 미션을 만들 수 있어요
        </p>

        <SentenceMissionClient profileId={profile.id} patterns={unlockedPatterns} />
      </div>
    </main>
  );
}
