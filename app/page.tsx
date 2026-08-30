import Link from "next/link";

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-center gap-4 bg-zinc-50 px-6 text-center dark:bg-black">
      <h1 className="text-3xl font-bold tracking-tight text-zinc-900 dark:text-zinc-50">
        Pixel Language Village
      </h1>
      <p className="max-w-md text-zinc-600 dark:text-zinc-400">
        카드로 단어를 익히고, 문장을 조합하며, 배운 말이 픽셀 마을로
        자라나는 언어학습 앱입니다.
      </p>
      <Link
        href="/login"
        className="mt-2 rounded-lg bg-zinc-900 px-5 py-2 text-base font-medium text-white dark:bg-zinc-50 dark:text-zinc-900"
      >
        시작하기
      </Link>
      <p className="text-sm text-zinc-400">STEP 2 · 인증과 프로필 구축 중</p>
    </main>
  );
}
