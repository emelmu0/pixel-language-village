"use client";

import { useMemo, useState } from "react";
import { createClient } from "@/lib/supabase/client";
import type { CardProgress, Concept, Example, WordEntry } from "@/types";

const NATIVE_LANGUAGE = "ko";
const TARGET_LANGUAGE = "en";

const POS_EMOJI: Record<string, string> = {
  noun: "📦",
  verb: "🏃",
  adjective: "✨",
  other: "👋",
};

type ConceptWithRelations = Concept & {
  word_entries: WordEntry[];
  examples: Example[];
};

type CardData = {
  concept: ConceptWithRelations;
  targetWord: WordEntry;
  nativeWord: WordEntry;
  targetExample: Example | null;
  nativeExample: Example | null;
};

function buildCards(concepts: ConceptWithRelations[]): CardData[] {
  const cards: CardData[] = [];
  for (const concept of concepts) {
    const targetWord = concept.word_entries.find(
      (w) => w.language_code === TARGET_LANGUAGE
    );
    const nativeWord = concept.word_entries.find(
      (w) => w.language_code === NATIVE_LANGUAGE
    );
    if (!targetWord || !nativeWord) continue;

    const targetExample =
      concept.examples.find((e) => e.language_code === TARGET_LANGUAGE) ?? null;
    const nativeExample =
      concept.examples.find((e) => e.language_code === NATIVE_LANGUAGE) ?? null;

    cards.push({ concept, targetWord, nativeWord, targetExample, nativeExample });
  }
  return cards;
}

export default function WordCardsClient({
  profileId,
  concepts,
  initialProgress,
}: {
  profileId: string;
  concepts: ConceptWithRelations[];
  initialProgress: CardProgress[];
}) {
  const supabase = createClient();
  const cards = useMemo(() => buildCards(concepts), [concepts]);

  const [progressByConcept, setProgressByConcept] = useState<Record<string, CardProgress>>(
    () => {
      const map: Record<string, CardProgress> = {};
      for (const p of initialProgress) {
        if (p.language_code === TARGET_LANGUAGE) {
          map[p.concept_id] = p;
        }
      }
      return map;
    }
  );

  const [index, setIndex] = useState(0);
  const [flipped, setFlipped] = useState(false);
  const [saving, setSaving] = useState(false);

  const card = cards[index];
  const total = cards.length;
  const masteredCount = Object.values(progressByConcept).filter(
    (p) => p.mastery_level >= 4
  ).length;

  if (total === 0) {
    return (
      <p className="rounded-xl border border-dashed border-zinc-300 p-6 text-center text-sm text-zinc-500 dark:border-zinc-700">
        아직 준비된 단어 카드가 없어요.
      </p>
    );
  }

  if (!card) {
    return (
      <div className="flex flex-col items-center gap-4 rounded-xl border border-zinc-200 bg-white p-8 text-center dark:border-zinc-800 dark:bg-zinc-900">
        <p className="text-2xl">🎉</p>
        <p className="text-base font-medium text-zinc-900 dark:text-zinc-50">
          오늘 준비된 카드를 모두 살펴봤어요!
        </p>
        <button
          type="button"
          onClick={() => setIndex(0)}
          className="rounded-lg bg-zinc-900 px-4 py-2 text-sm font-medium text-white dark:bg-zinc-50 dark:text-zinc-900"
        >
          처음부터 다시 보기
        </button>
      </div>
    );
  }

  async function handleAssess(masteryLevel: number) {
    setSaving(true);
    const prev = progressByConcept[card.concept.id];

    const nextProgress = {
      profile_id: profileId,
      concept_id: card.concept.id,
      language_code: TARGET_LANGUAGE,
      mastery_level: masteryLevel,
      correct_count: (prev?.correct_count ?? 0) + (masteryLevel >= 4 ? 1 : 0),
      review_count: (prev?.review_count ?? 0) + 1,
      last_reviewed_at: new Date().toISOString(),
    };

    const { data, error } = await supabase
      .from("card_progress")
      .upsert(nextProgress, { onConflict: "profile_id,concept_id,language_code" })
      .select()
      .single();

    setSaving(false);

    if (!error && data) {
      setProgressByConcept((prevMap) => ({
        ...prevMap,
        [card.concept.id]: data as CardProgress,
      }));
    }

    setFlipped(false);
    setIndex((i) => i + 1);
  }

  return (
    <div className="flex flex-col gap-5">
      <div className="flex items-center justify-between text-sm text-zinc-500">
        <span>
          {index + 1} / {total}
        </span>
        <span>익힘 {masteredCount} / {total}</span>
      </div>

      <div
        className="relative h-72 w-full cursor-pointer [perspective:1200px]"
        onClick={() => setFlipped((f) => !f)}
      >
        <div
          className={`relative h-full w-full rounded-2xl shadow-md transition-transform duration-500 [transform-style:preserve-3d] ${
            flipped ? "[transform:rotateY(180deg)]" : ""
          }`}
        >
          {/* 앞면 */}
          <div className="absolute inset-0 flex flex-col items-center justify-center gap-4 rounded-2xl border border-zinc-200 bg-white p-6 [backface-visibility:hidden] dark:border-zinc-800 dark:bg-zinc-900">
            <span className="text-6xl">{POS_EMOJI[card.concept.part_of_speech] ?? "🧩"}</span>
            <span className="text-3xl font-bold text-zinc-900 dark:text-zinc-50">
              {card.targetWord.display_text}
            </span>
            <span className="text-xs text-zinc-400">카드를 눌러 뒤집어 보세요</span>
          </div>

          {/* 뒷면 */}
          <div className="absolute inset-0 flex flex-col items-center justify-center gap-3 rounded-2xl border border-zinc-200 bg-white p-6 text-center [backface-visibility:hidden] [transform:rotateY(180deg)] dark:border-zinc-800 dark:bg-zinc-900">
            <span className="text-2xl font-bold text-zinc-900 dark:text-zinc-50">
              {card.nativeWord.display_text}
            </span>
            {card.nativeWord.definition && (
              <p className="text-sm text-zinc-500">{card.nativeWord.definition}</p>
            )}
            <div className="mt-2 flex flex-col gap-1 text-sm text-zinc-600 dark:text-zinc-300">
              {card.targetExample && <p>{card.targetExample.sentence}</p>}
              {card.nativeExample && <p>{card.nativeExample.sentence}</p>}
            </div>
          </div>
        </div>
      </div>

      {flipped ? (
        <div className="grid grid-cols-3 gap-2">
          <button
            type="button"
            disabled={saving}
            onClick={() => handleAssess(1)}
            className="rounded-lg border border-zinc-300 px-2 py-2 text-sm text-zinc-600 disabled:opacity-50 dark:border-zinc-700 dark:text-zinc-300"
          >
            다시 볼래요
          </button>
          <button
            type="button"
            disabled={saving}
            onClick={() => handleAssess(2)}
            className="rounded-lg border border-zinc-300 px-2 py-2 text-sm text-zinc-600 disabled:opacity-50 dark:border-zinc-700 dark:text-zinc-300"
          >
            알 것 같아요
          </button>
          <button
            type="button"
            disabled={saving}
            onClick={() => handleAssess(4)}
            className="rounded-lg bg-zinc-900 px-2 py-2 text-sm font-medium text-white disabled:opacity-50 dark:bg-zinc-50 dark:text-zinc-900"
          >
            잘 알아요
          </button>
        </div>
      ) : (
        <p className="text-center text-sm text-zinc-400">
          단어를 읽어본 뒤 카드를 눌러 뜻을 확인해요
        </p>
      )}
    </div>
  );
}
