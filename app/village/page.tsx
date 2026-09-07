import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { calcVillageLevel, getThemeByKey, pickRandomTheme, WORDS_PER_LEVEL } from "@/lib/village/themes";
import VillagerDialogueClient from "@/components/village/VillagerDialogueClient";
import { getActiveTargetLanguage, NATIVE_LANGUAGE } from "@/lib/languages";
import LanguageSwitcher from "@/components/languages/LanguageSwitcher";
import type { CardProgress, Concept, Example, Profile, VillageEvent, VillageProfile, WordEntry } from "@/types";

const MASTERY_THRESHOLD = 4;

export default async function VillagePage({
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

  let { data: village } = await supabase
    .from("village_profiles")
    .select("*")
    .eq("profile_id", profileId)
    .maybeSingle<VillageProfile>();

  if (!village) {
    const theme = pickRandomTheme();
    const { data: created } = await supabase
      .from("village_profiles")
      .insert({ profile_id: profileId, theme_key: theme.key })
      .select()
      .single<VillageProfile>();
    village = created ?? null;
  }

  const { data: progressRows } = await supabase
    .from("card_progress")
    .select("*")
    .eq("profile_id", profileId)
    .returns<CardProgress[]>();

  const masteredCount = (progressRows ?? []).filter((p) => p.mastery_level >= MASTERY_THRESHOLD).length;
  const currentLevel = calcVillageLevel(masteredCount);

  if (village && (village.village_level !== currentLevel || village.xp !== masteredCount)) {
    const { data: updated } = await supabase
      .from("village_profiles")
      .update({ village_level: currentLevel, xp: masteredCount })
      .eq("id", village.id)
      .select()
      .single<VillageProfile>();
    village = updated ?? village;
  }

  if (!village) {
    return (
      <main className="min-h-screen bg-zinc-50 px-6 py-10 dark:bg-black">
        <p className="mx-auto max-w-lg text-center text-sm text-red-500">
          마을을 불러오지 못했어요. 잠시 후 다시 시도해 주세요.
        </p>
      </main>
    );
  }

  const theme = getThemeByKey(village.theme_key);
  const progressInLevel = masteredCount % WORDS_PER_LEVEL;
  const remainingToNextLevel = WORDS_PER_LEVEL - progressInLevel;

  const buildingCount = Math.max(1, Math.min(village.village_level, 8));
  const natureCount = Math.min(masteredCount, 12);

  // STEP 8: 마을 예문 - 최근 학습(복습)한 익힌 단어로 주민 대화를 만든다.
  // STEP 9: 지금 배우는 언어(활성 언어) 기준으로 보여준다.
  const activeLanguage = await getActiveTargetLanguage(supabase, profileId);

  const { data: recentMastered } = await supabase
    .from("card_progress")
    .select("*")
    .eq("profile_id", profileId)
    .eq("language_code", activeLanguage)
    .gte("mastery_level", MASTERY_THRESHOLD)
    .order("last_reviewed_at", { ascending: false })
    .limit(1)
    .returns<CardProgress[]>();

  const recentConceptId = recentMastered?.[0]?.concept_id ?? null;

  let dialogue: {
    eventId: string;
    targetSentence: string;
    nativeSentence: string;
    targetWord: string;
    nativeWord: string;
    alreadyCompleted: boolean;
  } | null = null;

  if (recentConceptId) {
    const { data: concept } = await supabase
      .from("concepts")
      .select("*")
      .eq("id", recentConceptId)
      .single<Concept>();

    const { data: wordEntries } = await supabase
      .from("word_entries")
      .select("*")
      .eq("concept_id", recentConceptId)
      .returns<WordEntry[]>();

    const { data: examples } = await supabase
      .from("examples")
      .select("*")
      .eq("concept_id", recentConceptId)
      .returns<Example[]>();

    const targetWord = wordEntries?.find((w) => w.language_code === activeLanguage);
    const nativeWord = wordEntries?.find((w) => w.language_code === NATIVE_LANGUAGE);
    const targetExample = examples?.find((e) => e.language_code === activeLanguage);
    const nativeExample = examples?.find((e) => e.language_code === NATIVE_LANGUAGE);

    if (concept && targetWord && nativeWord && targetExample && nativeExample) {
      const { data: existingEvent } = await supabase
        .from("village_events")
        .select("*")
        .eq("profile_id", profileId)
        .eq("concept_id", recentConceptId)
        .order("shown_at", { ascending: false })
        .limit(1)
        .maybeSingle<VillageEvent>();

      let event = existingEvent;
      if (!event) {
        const { data: created } = await supabase
          .from("village_events")
          .insert({
            profile_id: profileId,
            concept_id: recentConceptId,
            example_id: targetExample.id,
            event_type: "resident_dialogue",
          })
          .select()
          .single<VillageEvent>();
        event = created ?? null;
      }

      if (event) {
        dialogue = {
          eventId: event.id,
          targetSentence: targetExample.sentence,
          nativeSentence: nativeExample.sentence,
          targetWord: targetWord.display_text,
          nativeWord: nativeWord.display_text,
          alreadyCompleted: Boolean(event.completed_at),
        };
      }
    }
  }

  return (
    <main className="min-h-screen bg-zinc-50 px-6 py-10 dark:bg-black">
      <div className="mx-auto flex w-full max-w-lg flex-col gap-6">
        <div className="flex items-center justify-between">
          <div>
            <h1 className="text-xl font-bold text-zinc-900 dark:text-zinc-50">픽셀 마을</h1>
            <p className="text-sm text-zinc-500">
              {profile.avatar ?? "🙂"} {profile.nickname}
            </p>
          </div>
          <div className="flex items-center gap-3">
            <LanguageSwitcher profileId={profile.id} activeLanguage={activeLanguage} />
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

        <section className="flex flex-col gap-4 rounded-2xl border border-zinc-200 bg-white p-6 dark:border-zinc-800 dark:bg-zinc-900">
          <div className="flex items-center gap-3">
            {/* eslint-disable-next-line @next/next/no-img-element */}
            <img
              src={theme.buildingImage}
              alt={theme.name}
              width={16}
              height={16}
              className="h-12 w-12 [image-rendering:pixelated]"
            />
            <div>
              <p className="text-lg font-bold text-zinc-900 dark:text-zinc-50">{theme.name}</p>
              <p className="text-sm text-zinc-500">Lv.{village.village_level} 마을</p>
            </div>
          </div>

          <div className="flex flex-col gap-1">
            <div className="h-2 w-full overflow-hidden rounded-full bg-zinc-100 dark:bg-zinc-800">
              <div
                className="h-full rounded-full bg-emerald-500"
                style={{ width: `${(progressInLevel / WORDS_PER_LEVEL) * 100}%` }}
              />
            </div>
            <p className="text-xs text-zinc-500">
              다음 레벨까지 단어 {remainingToNextLevel}개
            </p>
          </div>

          <div className="grid grid-cols-6 gap-2 rounded-xl bg-zinc-50 p-4 dark:bg-zinc-800">
            {Array.from({ length: buildingCount }).map((_, i) => (
              // eslint-disable-next-line @next/next/no-img-element
              <img
                key={`b-${i}`}
                src={theme.buildingImage}
                alt={theme.name}
                width={16}
                height={16}
                className="mx-auto h-8 w-8 [image-rendering:pixelated]"
              />
            ))}
            {Array.from({ length: natureCount }).map((_, i) => (
              // eslint-disable-next-line @next/next/no-img-element
              <img
                key={`n-${i}`}
                src={theme.natureImage}
                alt=""
                width={16}
                height={16}
                className="mx-auto h-8 w-8 [image-rendering:pixelated]"
              />
            ))}
            {buildingCount + natureCount === 0 && (
              <p className="col-span-6 text-sm text-zinc-400">
                아직 마을이 조용해요. 단어를 익히면 마을이 자라나요.
              </p>
            )}
          </div>

          <p className="text-center text-xs text-zinc-400">
            익힌 단어 {masteredCount}개가 마을의 건물과 풍경이 되었어요
          </p>
        </section>

        {dialogue ? (
          <VillagerDialogueClient
            profileId={profile.id}
            villagerImage={theme.buildingImage}
            villagerName={theme.name}
            {...dialogue}
          />
        ) : (
          <section className="flex flex-col items-center gap-2 rounded-2xl border border-dashed border-zinc-300 p-6 text-center dark:border-zinc-700">
            <p className="text-2xl">🌱</p>
            <p className="text-sm text-zinc-500">
              단어 카드에서 &quot;잘 알아요&quot;를 눌러 단어를 익히면 마을 주민이 그 단어로
              말을 걸어와요.
            </p>
          </section>
        )}

        <Link
          href={`/words?profile=${profile.id}`}
          className="rounded-lg bg-zinc-900 px-4 py-2 text-center text-sm font-medium text-white dark:bg-zinc-50 dark:text-zinc-900"
        >
          단어 카드로 마을 키우기
        </Link>
      </div>
    </main>
  );
}
