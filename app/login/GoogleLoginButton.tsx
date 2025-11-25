'use client';

import { supabase } from '../../lib/supabase/client';

export default function GoogleLoginButton() {
  const loginWithGoogle = async () => {
    console.log('Google login button clicked');
    const { data, error } = await supabase.auth.signInWithOAuth({
      provider: 'google',
      options: {
        redirectTo: 'https://enhance-reading-app-morning-sound-6129.fly.dev/auth/google/callback'
      },
    });

    console.log('OAuth data:', data);
    console.log('OAuth error:', error);

    if (data?.url) {
      window.location.href = data.url;
    } else {
      console.warn('Redirect URL is missing!');
    }
  };

  return (
    <button
      onClick={() => {
        console.log('Button clicked');
        loginWithGoogle();
      }}
      className="bg-red-500 text-white px-4 py-2 rounded"
    >
      Googleでログイン
    </button>
  );
}
