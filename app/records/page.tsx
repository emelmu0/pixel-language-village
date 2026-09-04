import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import type { CardProgress, Profile } from "@/types";

const LANGUAGE_LABEL: Record<string, string> = {
  ko: "한국어",
  en: "English",
  ja: "日本語",
  es: "Español",
};

function todayInSeoul(): string {
  return new Date().toLocaleDateString("en-CA", { timeZone: "Asia/Seoul" });
}

function dateInSeoul(iso: string): string {
  return new Date(iso).toLocaleDateString("en-CA", { timeZone: "Asia/Seoul" });
}

export default async function RecordsPage({
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

  const { data: progressRows } = await supabase
    .from("card_progress")
    .select("*")
    .eq("profile_id", profileId)
    .returns<CardProgress[]>();

  const progress = progressRows ?? [];
  const today = todayInSeoul();

  const touchedToday = progress.filter(
    (p) => p.last_reviewed_at && dateInSeoul(p.last_reviewed_at) === today
  );
  const masteredToday = touchedToday.filter((p) => p.mastery_level >= 4);

  const masteredTotal = progress.filter((p) => p.mastery_level >= 4);
  const totalReviewCount = progress.reduce((sum, p) => sum + p.review_count, 0);

  const masteredByLanguage = new Map<string, number>();
  for (const p of masteredTotal) {
    masteredByLanguage.set(
      p.language_code,
      (masteredByLanguage.get(p.language_code) ?? 0) + 1
    );
  }

  return (
    <main className="min-h-screen bg-zinc-50 px-6 py-10 dark:bg-black">
      <div className="mx-auto flex w-full max-w-lg flex-col gap-6">
        <div className="flex items-center justify-between">
          <div>
            <h1 className="text-xl font-bold text-zinc-900 dark:text-zinc-50">학습 기록</h1>
            <p className="text-sm text-zinc-500">
              {profile.avatar ?? "🙂"} {profile.nickname}
            </p>
          </div>
          <Link
            href="/profiles"
            className="text-sm text-zinc-500 underline underline-offset-2"
          >
            프로필 목록
          </Link>
        </div>

        <section className="flex flex-col gap-3 rounded-xl border border-zinc-200 bg-white p-4 dark:border-zinc-800 dark:bg-zinc-900">
          <h2 className="text-sm font-semibold text-zinc-700 dark:text-zinc-300">
            오늘의 기록
          </h2>
          <div className="grid grid-cols-2 gap-3">
            <div className="rounded-lg bg-zinc-50 p-3 text-center dark:bg-zinc-800">
              <p className="text-2xl font-bold text-zinc-900 dark:text-zinc-50">
                {touchedToday.length}
              </p>
              <p className="text-xs text-zinc-500">학습한 단어</p>
            </div>
            <div className="rounded-lg bg-zinc-50 p-3 text-center dark:bg-zinc-800">
              <p className="text-2xl font-bold text-zinc-900 dark:text-zinc-50">
                {masteredToday.length}
              </p>
              <p className="text-xs text-zinc-500">새로 익힌 단어</p>
            </div>
          </div>
        </section>

        <section className="flex flex-col gap-3 rounded-xl border border-zinc-200 bg-white p-4 dark:border-zinc-800 dark:bg-zinc-900">
          <h2 className="text-sm font-semibold text-zinc-700 dark:text-zinc-300">
            나의 언어 기록
          </h2>
          <dl className="flex flex-col divide-y divide-zinc-100 dark:divide-zinc-800">
            <div className="flex items-center justify-between py-2">
              <dt className="text-sm text-zinc-500">익힌 단어</dt>
              <dd className="text-base font-semibold text-zinc-900 dark:text-zinc-50">
                {masteredTotal.length}
              </dd>
            </div>
            <div className="flex items-center justify-between py-2">
              <dt className="text-sm text-zinc-500">학습해 본 단어</dt>
              <dd className="text-base font-semibold text-zinc-900 dark:text-zinc-50">
                {progress.length}
              </dd>
            </div>
            <div className="flex items-center justify-between py-2">
              <dt className="text-sm text-zinc-500">총 복습 횟수</dt>
              <dd className="text-base font-semibold text-zinc-900 dark:text-zinc-50">
                {totalReviewCount}
              </dd>
            </div>
          </dl>
        </section>

        {masteredByLanguage.size > 0 && (
          <section className="flex flex-col gap-3 rounded-xl border border-zinc-200 bg-white p-4 dark:border-zinc-800 dark:bg-zinc-900">
            <h2 className="text-sm font-semibold text-zinc-700 dark:text-zinc-300">
              언어별 기록
            </h2>
            <ul className="flex flex-col gap-2">
              {Array.from(masteredByLanguage.entries()).map(([code, count]) => (
                <li key={code} className="flex items-center justify-between text-sm">
                  <span className="text-zinc-600 dark:text-zinc-300">
                    {LANGUAGE_LABEL[code] ?? code}
                  </span>
                  <span className="font-medium text-zinc-900 dark:text-zinc-50">
                    {count}개
                  </span>
                </li>
              ))}
            </ul>
          </section>
        )}

        {progress.length === 0 && (
          <p className="rounded-xl border border-dashed border-zinc-300 p-6 text-center text-sm text-zinc-500 dark:border-zinc-700">
            아직 학습 기록이 없어요. 단어 카드로 학습을 시작해 보세요.
          </p>
        )}

        <p className="text-center text-xs text-zinc-400">
          문장 수와 학습시간 기록은 문장 모드 구현 이후 추가될 예정이에요.
        </p>

        <Link
          href={`/words?profile=${profile.id}`}
          className="rounded-lg bg-zinc-900 px-4 py-2 text-center text-sm font-medium text-white dark:bg-zinc-50 dark:text-zinc-900"
        >
          단어 카드 학습하러 가기
        </Link>
      </div>
    </main>
  );
}
