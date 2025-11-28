'use client';

import { supabase } from '../../lib/supabase/client';

export default function GoogleLoginButton() {
  console.log("GoogleLoginButton loaded!!!"); 
  const loginWithGoogle = async () => {
    alert("login start");

    const { data, error } = await supabase.auth.signInWithOAuth({
      provider: 'google',
      options: {
        redirectTo: 'https://frontend-autumn-morning-199.fly.dev/auth/callback'
      },
    });

    console.log("OAuth result:", data, error);

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
