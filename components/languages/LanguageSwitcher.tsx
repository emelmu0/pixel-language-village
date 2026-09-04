"use client";

import { useRouter } from "next/navigation";
import { useState } from "react";
import { createClient } from "@/lib/supabase/client";
import { TARGET_LANGUAGES } from "@/lib/languages";

export default function LanguageSwitcher({
  profileId,
  activeLanguage,
}: {
  profileId: string;
  activeLanguage: string;
}) {
  const supabase = createClient();
  const router = useRouter();
  const [switching, setSwitching] = useState(false);

  async function handleSwitch(code: string) {
    if (code === activeLanguage || switching) return;
    setSwitching(true);

    await supabase
      .from("profile_languages")
      .update({ is_active: false })
      .eq("profile_id", profileId)
      .eq("is_active", true);

    await supabase
      .from("profile_languages")
      .upsert(
        { profile_id: profileId, language_code: code, is_active: true },
        { onConflict: "profile_id,language_code" }
      );

    setSwitching(false);
    router.refresh();
  }

  return (
    <div className="flex items-center gap-2">
      {TARGET_LANGUAGES.map((lang) => (
        <button
          key={lang.code}
          type="button"
          disabled={switching}
          onClick={() => handleSwitch(lang.code)}
          className={
            lang.code === activeLanguage
              ? "rounded-full bg-zinc-900 px-3 py-1 text-xs font-medium text-white disabled:opacity-50 dark:bg-zinc-50 dark:text-zinc-900"
              : "rounded-full border border-zinc-300 px-3 py-1 text-xs text-zinc-500 disabled:opacity-50 dark:border-zinc-700"
          }
        >
          {lang.label}
        </button>
      ))}
    </div>
  );
}
