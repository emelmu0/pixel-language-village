"use client";

import { useMemo, useState } from "react";
import { createClient } from "@/lib/supabase/client";
import type { SentencePattern } from "@/types";

type Chip = {
  id: number;
  word: string;
};

function shuffle<T>(arr: T[]): T[] {
  const copy = [...arr];
  for (let i = copy.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [copy[i], copy[j]] = [copy[j], copy[i]];
  }
  return copy;
}

export default function SentenceMissionClient({
  profileId,
  patterns,
}: {
  profileId: string;
  patterns: SentencePattern[];
}) {
  const supabase = createClient();

  const [index, setIndex] = useState(0);
  const [placedIds, setPlacedIds] = useState<number[]>([]);
  const [status, setStatus] = useState<"idle" | "correct" | "wrong">("idle");
  const [saving, setSaving] = useState(false);
  const [completedCount, setCompletedCount] = useState(0);

  const pattern = patterns[index];

  const chips: Chip[] = useMemo(() => {
    if (!pattern) return [];
    return shuffle(pattern.structure_json.tokens.map((word, i) => ({ id: i, word })));
  }, [pattern]);

  if (patterns.length === 0) {
    return (
      <div className="flex flex-col items-center gap-4 rounded-xl border border-dashed border-zinc-300 p-8 text-center dark:border-zinc-700">
        <p className="text-2xl">✏️</p>
        <p className="text-sm text-zinc-500">
          아직 잘 아는 단어가 부족해요. 단어 카드에서 &quot;잘 알아요&quot;를 눌러 단어를 익히면
          문장 미션이 열려요.
        </p>
      </div>
    );
  }

  if (!pattern) {
    return (
      <div className="flex flex-col items-center gap-4 rounded-xl border border-zinc-200 bg-white p-8 text-center dark:border-zinc-800 dark:bg-zinc-900">
        <p className="text-2xl">🎉</p>
        <p className="text-base font-medium text-zinc-900 dark:text-zinc-50">
          지금 열려 있는 문장 미션을 모두 완료했어요! ({completedCount}개)
        </p>
        <button
          type="button"
          onClick={() => {
            setIndex(0);
            setPlacedIds([]);
            setStatus("idle");
          }}
          className="rounded-lg bg-zinc-900 px-4 py-2 text-sm font-medium text-white dark:bg-zinc-50 dark:text-zinc-900"
        >
          처음부터 다시 하기
        </button>
      </div>
    );
  }

  const placedWords = placedIds.map((id) => chips.find((c) => c.id === id)?.word ?? "");
  const poolChips = chips.filter((c) => !placedIds.includes(c.id));
  const isFull = placedIds.length === chips.length;

  function handlePick(id: number) {
    if (status === "correct") return;
    setStatus("idle");
    setPlacedIds((prev) => [...prev, id]);
  }

  function handleUnpick(id: number) {
    if (status === "correct") return;
    setPlacedIds((prev) => prev.filter((p) => p !== id));
  }

  async function handleCheck() {
    const answer = placedWords.join(" ");
    const correct = pattern.structure_json.tokens.join(" ");

    if (answer !== correct) {
      setStatus("wrong");
      return;
    }

    setStatus("correct");
    setSaving(true);

    await supabase.from("learned_sentences").insert({
      profile_id: profileId,
      language_code: pattern.language_code,
      sentence_pattern_id: pattern.id,
      sentence_text: correct,
    });

    setSaving(false);
    setCompletedCount((c) => c + 1);

    setTimeout(() => {
      setIndex((i) => i + 1);
      setPlacedIds([]);
      setStatus("idle");
    }, 900);
  }

  return (
    <div className="flex flex-col gap-5">
      <div className="flex items-center justify-between text-sm text-zinc-500">
        <span>
          {index + 1} / {patterns.length}
        </span>
        <span>완료 {completedCount}개</span>
      </div>

      <div className="rounded-2xl border border-zinc-200 bg-white p-6 dark:border-zinc-800 dark:bg-zinc-900">
        <p className="mb-4 text-center text-base text-zinc-500">
          {pattern.structure_json.native_sentence}
        </p>

        <div className="mb-4 flex min-h-16 flex-wrap items-center justify-center gap-2 rounded-xl border border-dashed border-zinc-300 p-3 dark:border-zinc-700">
          {placedIds.length === 0 && (
            <span className="text-xs text-zinc-400">아래 단어를 순서대로 눌러 문장을 만들어요</span>
          )}
          {placedIds.map((id) => {
            const chip = chips.find((c) => c.id === id);
            if (!chip) return null;
            return (
              <button
                key={chip.id}
                type="button"
                onClick={() => handleUnpick(chip.id)}
                className="rounded-lg bg-zinc-900 px-3 py-1.5 text-sm font-medium text-white dark:bg-zinc-50 dark:text-zinc-900"
              >
                {chip.word}
              </button>
            );
          })}
        </div>

        <div className="flex flex-wrap justify-center gap-2">
          {poolChips.map((chip) => (
            <button
              key={chip.id}
              type="button"
              onClick={() => handlePick(chip.id)}
              className="rounded-lg border border-zinc-300 px-3 py-1.5 text-sm text-zinc-700 dark:border-zinc-700 dark:text-zinc-200"
            >
              {chip.word}
            </button>
          ))}
        </div>
      </div>

      {status === "correct" && (
        <p className="text-center text-sm font-medium text-emerald-600">잘했어요! 🎉</p>
      )}
      {status === "wrong" && (
        <p className="text-center text-sm font-medium text-red-500">
          순서가 조금 달라요. 단어를 다시 눌러 순서를 바꿔 보세요.
        </p>
      )}

      <div className="flex gap-2">
        <button
          type="button"
          onClick={() => setPlacedIds([])}
          disabled={placedIds.length === 0 || status === "correct"}
          className="flex-1 rounded-lg border border-zinc-300 px-4 py-2 text-sm text-zinc-600 disabled:opacity-40 dark:border-zinc-700 dark:text-zinc-300"
        >
          다시 놓기
        </button>
        <button
          type="button"
          onClick={handleCheck}
          disabled={!isFull || saving || status === "correct"}
          className="flex-1 rounded-lg bg-zinc-900 px-4 py-2 text-sm font-medium text-white disabled:opacity-40 dark:bg-zinc-50 dark:text-zinc-900"
        >
          확인하기
        </button>
      </div>
    </div>
  );
}
