import type { NextRequest } from "next/server";
import { NextResponse } from "next/server";

export const config = {
  matcher: ["/api/:path*"],
};

export default function proxy(req: NextRequest) {
  const url = req.nextUrl.clone();

  // Rails (localhost:3001) へフォワード
  url.hostname = "localhost";
  url.port = "3001";
  url.protocol = "http";

  return NextResponse.rewrite(url);
}
