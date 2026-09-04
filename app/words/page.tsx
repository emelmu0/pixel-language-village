import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import WordCardsClient from "@/components/cards/WordCardsClient";
import type { CardProgress, Concept, Example, Profile, WordEntry } from "@/types";

type ConceptWithRelations = Concept & {
  word_entries: WordEntry[];
  examples: Example[];
};

export default async function WordsPage({
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

  const { data: concepts } = await supabase
    .from("concepts")
    .select("*, word_entries(*), examples(*)")
    .order("created_at", { ascending: true })
    .returns<ConceptWithRelations[]>();

  const { data: progress } = await supabase
    .from("card_progress")
    .select("*")
    .eq("profile_id", profileId)
    .returns<CardProgress[]>();

  return (
    <main className="min-h-screen bg-zinc-50 px-6 py-10 dark:bg-black">
      <div className="mx-auto flex w-full max-w-lg flex-col gap-6">
        <div className="flex items-center justify-between">
          <div>
            <h1 className="text-xl font-bold text-zinc-900 dark:text-zinc-50">단어 카드</h1>
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

        <WordCardsClient
          profileId={profile.id}
          concepts={concepts ?? []}
          initialProgress={progress ?? []}
        />
      </div>
    </main>
  );
}
