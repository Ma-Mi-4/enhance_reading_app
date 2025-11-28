import GoogleLoginButton from '@/app/login/GoogleLoginButton';

export default function Home() {
  return (
    <div className="p-8">
      <h1 className="text-3xl mb-4">Next.js Frontend</h1>
      <p className="mb-4">ここから Google ログインへ進めます。</p>

      <GoogleLoginButton />
    </div>
  );
}
