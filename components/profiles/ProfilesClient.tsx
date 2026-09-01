"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { createClient } from "@/lib/supabase/client";
import type { Profile } from "@/types";

const AVATAR_OPTIONS = ["🐱", "🐶", "🐰", "🦊", "🐻", "🐼", "🦁", "🐸"];

function maskEmail(rawEmail: string): string {
  const [local, domain] = rawEmail.split("@");
  if (!local || !domain) return rawEmail;
  const visible = local.slice(0, Math.min(2, local.length));
  return `${visible}${"*".repeat(Math.max(local.length - visible.length, 2))}@${domain}`;
}

export default function ProfilesClient({
  initialProfiles,
  email,
}: {
  initialProfiles: Profile[];
  email: string;
}) {
  const router = useRouter();
  const supabase = createClient();

  const [profiles, setProfiles] = useState<Profile[]>(initialProfiles);
  const [nickname, setNickname] = useState("");
  const [avatar, setAvatar] = useState(AVATAR_OPTIONS[0]);
  const [editingId, setEditingId] = useState<string | null>(null);
  const [editingNickname, setEditingNickname] = useState("");
  const [error, setError] = useState<string | null>(null);
  const [saving, setSaving] = useState(false);

  async function handleAdd(event: React.FormEvent) {
    event.preventDefault();
    if (!nickname.trim()) return;
    setSaving(true);
    setError(null);

    const {
      data: { user },
    } = await supabase.auth.getUser();

    if (!user) {
      setError("로그인 정보가 만료되었어요. 다시 로그인해 주세요.");
      setSaving(false);
      return;
    }

    const { data, error } = await supabase
      .from("profiles")
      .insert({ owner_user_id: user.id, nickname: nickname.trim(), avatar })
      .select()
      .single();

    setSaving(false);
    if (error) {
      setError(error.message);
      return;
    }

    setProfiles((prev) => [...prev, data as Profile]);
    setNickname("");
    setAvatar(AVATAR_OPTIONS[0]);
  }

  async function handleDelete(id: string) {
    const prev = profiles;
    setProfiles((p) => p.filter((profile) => profile.id !== id));
    const { error } = await supabase.from("profiles").delete().eq("id", id);
    if (error) {
      setError(error.message);
      setProfiles(prev);
    }
  }

  function startEdit(profile: Profile) {
    setEditingId(profile.id);
    setEditingNickname(profile.nickname);
  }

  async function handleSaveEdit(id: string) {
    if (!editingNickname.trim()) return;
    const { data, error } = await supabase
      .from("profiles")
      .update({ nickname: editingNickname.trim() })
      .eq("id", id)
      .select()
      .single();

    if (error) {
      setError(error.message);
      return;
    }

    setProfiles((prev) => prev.map((p) => (p.id === id ? (data as Profile) : p)));
    setEditingId(null);
  }

  async function handleLogout() {
    await supabase.auth.signOut();
    router.push("/login");
    router.refresh();
  }

  return (
    <div className="mx-auto flex w-full max-w-lg flex-col gap-8">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-xl font-bold text-zinc-900 dark:text-zinc-50">아이 프로필</h1>
          <p className="text-sm text-zinc-500">{maskEmail(email)}</p>
        </div>
        <button
          type="button"
          onClick={handleLogout}
          className="rounded-lg border border-zinc-300 px-3 py-1.5 text-sm text-zinc-600 dark:border-zinc-700 dark:text-zinc-300"
        >
          로그아웃
        </button>
      </div>

      <ul className="flex flex-col gap-3">
        {profiles.length === 0 && (
          <li className="rounded-xl border border-dashed border-zinc-300 p-6 text-center text-sm text-zinc-500 dark:border-zinc-700">
            아직 등록된 아이 프로필이 없어요. 아래에서 추가해 주세요.
          </li>
        )}
        {profiles.map((profile) => (
          <li
            key={profile.id}
            className="flex items-center gap-3 rounded-xl border border-zinc-200 bg-white p-3 dark:border-zinc-800 dark:bg-zinc-900"
          >
            <span className="text-2xl">{profile.avatar ?? "🙂"}</span>

            {editingId === profile.id ? (
              <div className="flex flex-1 items-center gap-2">
                <input
                  autoFocus
                  value={editingNickname}
                  onChange={(e) => setEditingNickname(e.target.value)}
                  className="flex-1 rounded-lg border border-zinc-300 px-2 py-1 text-base dark:border-zinc-700 dark:bg-zinc-800"
                />
                <button
                  type="button"
                  onClick={() => handleSaveEdit(profile.id)}
                  className="text-sm font-medium text-emerald-600"
                >
                  저장
                </button>
                <button
                  type="button"
                  onClick={() => setEditingId(null)}
                  className="text-sm text-zinc-400"
                >
                  취소
                </button>
              </div>
            ) : (
              <>
                <span className="flex-1 text-base font-medium text-zinc-900 dark:text-zinc-50">
                  {profile.nickname}
                </span>
                <button
                  type="button"
                  onClick={() => startEdit(profile)}
                  className="text-sm text-zinc-500"
                >
                  수정
                </button>
                <button
                  type="button"
                  onClick={() => handleDelete(profile.id)}
                  className="text-sm text-red-500"
                >
                  삭제
                </button>
              </>
            )}
          </li>
        ))}
      </ul>

      <form
        onSubmit={handleAdd}
        className="flex flex-col gap-3 rounded-xl border border-zinc-200 bg-white p-4 dark:border-zinc-800 dark:bg-zinc-900"
      >
        <h2 className="text-sm font-semibold text-zinc-700 dark:text-zinc-300">
          새 아이 프로필 추가
        </h2>

        <div className="flex flex-wrap gap-2">
          {AVATAR_OPTIONS.map((option) => (
            <button
              key={option}
              type="button"
              onClick={() => setAvatar(option)}
              className={`flex h-10 w-10 items-center justify-center rounded-lg text-xl ${
                avatar === option
                  ? "bg-zinc-900 dark:bg-zinc-50"
                  : "bg-zinc-100 dark:bg-zinc-800"
              }`}
            >
              {option}
            </button>
          ))}
        </div>

        <input
          value={nickname}
          onChange={(e) => setNickname(e.target.value)}
          placeholder="아이 닉네임"
          required
          className="rounded-lg border border-zinc-300 px-3 py-2 text-base dark:border-zinc-700 dark:bg-zinc-800"
        />

        {error && <p className="text-sm text-red-500">{error}</p>}

        <button
          type="submit"
          disabled={saving}
          className="rounded-lg bg-zinc-900 px-4 py-2 text-base font-medium text-white disabled:opacity-50 dark:bg-zinc-50 dark:text-zinc-900"
        >
          {saving ? "추가 중..." : "프로필 추가"}
        </button>
      </form>
    </div>
  );
}
