"use client";

import Link from "next/link";
import { useState } from "react";
import { createClient } from "@/lib/supabase/client";

function HighlightedSentence({
  sentence,
  keyword,
  profileId,
}: {
  sentence: string;
  keyword: string;
  profileId: string;
}) {
  const tokens = sentence.split(" ");
  const lowerKeyword = keyword.toLowerCase();

  return (
    <p className="text-base text-zinc-900 dark:text-zinc-50">
      {tokens.map((token, i) => {
        const isKeyword = token.toLowerCase().includes(lowerKeyword);
        return (
          <span key={i}>
            {isKeyword ? (
              <Link
                href={`/words?profile=${profileId}`}
                className="rounded bg-amber-200 px-1 font-bold text-zinc-900 dark:bg-amber-400/30 dark:text-amber-200"
              >
                {token}
              </Link>
            ) : (
              token
            )}
            {i < tokens.length - 1 ? " " : ""}
          </span>
        );
      })}
    </p>
  );
}

export default function VillagerDialogueClient({
  profileId,
  eventId,
  villagerImage,
  villagerName,
  targetSentence,
  nativeSentence,
  targetWord,
  nativeWord,
  alreadyCompleted,
}: {
  profileId: string;
  eventId: string;
  villagerImage: string;
  villagerName: string;
  targetSentence: string;
  nativeSentence: string;
  targetWord: string;
  nativeWord: string;
  alreadyCompleted: boolean;
}) {
  const supabase = createClient();
  const [revealed, setRevealed] = useState(alreadyCompleted);
  const [completed, setCompleted] = useState(alreadyCompleted);
  const [saving, setSaving] = useState(false);

  async function handleComplete() {
    if (completed) return;
    setSaving(true);
    await supabase
      .from("village_events")
      .update({ completed_at: new Date().toISOString() })
      .eq("id", eventId);
    setSaving(false);
    setCompleted(true);
  }

  return (
    <section className="flex flex-col gap-3 rounded-2xl border border-zinc-200 bg-white p-6 dark:border-zinc-800 dark:bg-zinc-900">
      <p className="text-xs font-medium text-zinc-400">주민 이야기</p>

      {!revealed ? (
        <button
          type="button"
          onClick={() => setRevealed(true)}
          className="flex flex-col items-center gap-2 rounded-xl border border-dashed border-zinc-300 p-6 text-center dark:border-zinc-700"
        >
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img
            src={villagerImage}
            alt={villagerName}
            width={16}
            height={16}
            className="h-12 w-12 [image-rendering:pixelated]"
          />
          <span className="text-xs text-zinc-400">주민을 눌러 이야기를 들어보세요</span>
        </button>
      ) : (
        <div className="flex flex-col gap-3 rounded-xl bg-zinc-50 p-4 dark:bg-zinc-800">
          <div className="flex items-start gap-3">
            {/* eslint-disable-next-line @next/next/no-img-element */}
            <img
              src={villagerImage}
              alt={villagerName}
              width={16}
              height={16}
              className="h-10 w-10 shrink-0 [image-rendering:pixelated]"
            />
            <div className="flex-1 rounded-2xl rounded-tl-none bg-white p-3 dark:bg-zinc-900">
              <HighlightedSentence
                sentence={targetSentence}
                keyword={targetWord}
                profileId={profileId}
              />
              <p className="mt-1 text-sm text-zinc-500">
                {nativeSentence.split(" ").map((token, i, arr) => (
                  <span key={i}>
                    {token.includes(nativeWord) ? (
                      <span className="font-semibold text-amber-600 dark:text-amber-400">
                        {token}
                      </span>
                    ) : (
                      token
                    )}
                    {i < arr.length - 1 ? " " : ""}
                  </span>
                ))}
              </p>
            </div>
          </div>

          <button
            type="button"
            onClick={handleComplete}
            disabled={saving || completed}
            className="self-end rounded-lg bg-zinc-900 px-3 py-1.5 text-xs font-medium text-white disabled:opacity-50 dark:bg-zinc-50 dark:text-zinc-900"
          >
            {completed ? "확인했어요 ✓" : "확인했어요"}
          </button>
        </div>
      )}
    </section>
  );
}
