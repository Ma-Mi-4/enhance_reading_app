'use client';

import { useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { supabase } from '../../../lib/supabase/client';

export const dynamic = "force-dynamic";

export default function AuthCallbackPage() {
  const router = useRouter();

  useEffect(() => {
    const handleOAuthCallback = async () => {
      const { data, error } = await supabase.auth.getSession();

      console.log('Session data:', data);
      console.log('Session error:', error);

      const accessToken = data.session?.access_token;

      if (!accessToken) {
        router.push('/login');
        return;
      }

      const res = await fetch(
        'https://enhance-reading-app-morning-sound-6129.fly.dev/auth/callback_api', // ★ここも現在のルート名に合わせる
        {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ access_token: accessToken }),
          credentials: 'include',
        }
      );

      console.log("Rails Response:", res.status);

      if (res.ok) {
        // ★★ ここを Next の / ではなく Rails のトップに変更 ★★
        window.location.href = 'https://enhance-reading-app-morning-sound-6129.fly.dev/';
      } else {
        router.push('/login');
      }
    };

    handleOAuthCallback();
  }, [router]);

  return <div>Googleログイン処理中...</div>;
}
