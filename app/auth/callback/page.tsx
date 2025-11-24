'use client';

import { useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { supabase } from '../../../lib/supabase/client';

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

      const params = new URLSearchParams({ access_token: accessToken });
      const res = await fetch('/sessions/google', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ access_token: accessToken }),
      credentials: 'include',
    });

      if (res.ok) {
        router.push('/');
      } else {
        router.push('/login');
      }
    };

    handleOAuthCallback();
  }, [router]);

  return <div>Googleログイン処理中...</div>;
}
