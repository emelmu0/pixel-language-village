import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import ProfilesClient from "@/components/profiles/ProfilesClient";

export default async function ProfilesPage() {
  const supabase = await createClient();

  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    redirect("/login");
  }

  const { data: profiles } = await supabase
    .from("profiles")
    .select("*")
    .order("created_at", { ascending: true });

  return (
    <main className="min-h-screen bg-zinc-50 px-6 py-10 dark:bg-black">
      <ProfilesClient initialProfiles={profiles ?? []} email={user.email ?? ""} />
    </main>
  );
}
