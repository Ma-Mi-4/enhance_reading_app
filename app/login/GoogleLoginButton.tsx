'use client';

import { supabase } from '../../lib/supabase/client';

export default function GoogleLoginButton() {
  const loginWithGoogle = async () => {
    console.log('Google login button clicked');

    const { data, error } = await supabase.auth.signInWithOAuth({
      provider: 'google',
      options: {
        redirectTo: 'https://enhance-reading-app-morning-sound-6129.fly.dev/auth/callback'
      },
    });

    if (error) {
      console.error(error);
      return;
    }

    if (data.url) {
      window.location.href = data.url;
    }
  };

  return (
    <button
      onClick={loginWithGoogle}
      className="bg-red-500 text-white px-4 py-2 rounded"
    >
      Googleでログイン
    </button>
  );
}
