import GoogleLoginButton from './GoogleLoginButton';

export default function LoginPage() {
  return (
    <div className="p-8">
      <h1 className="text-2xl mb-4">ログインページ</h1>
      <GoogleLoginButton />
    </div>
  );
}