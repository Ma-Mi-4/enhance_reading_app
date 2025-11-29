'use client';

import { useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { supabase } from '../../../lib/supabase/client';

export const dynamic = "force-dynamic";

export default function AuthCallbackPage() {
  const router = useRouter();

  useEffect(() => {
    const handleOAuthCallback = async () => {
      const { data } = await supabase.auth.getSession();
      const accessToken = data.session?.access_token;

      if (!accessToken) {
        router.push('/login');
        return;
      }

      const res = await fetch(
        "https://enhance-reading-app-morning-sound-6129.fly.dev/auth/callback_api",
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: JSON.stringify({ access_token: accessToken }),
          credentials: "include",
        }
      );

      console.log("Rails status:", res.status);

      if (res.ok) {
        window.location.href = "https://enhance-reading-app-morning-sound-6129.fly.dev/";
      } else {
        router.push("/login");
      }
    };

    handleOAuthCallback();
  }, [router]);

  return <div>Googleログイン処理中...</div>;
}
