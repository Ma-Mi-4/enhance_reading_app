# --- Base Image ---
FROM node:20-slim AS base
WORKDIR /app
ENV NODE_ENV=production

# --- Dependencies Layer ---
FROM base AS deps
COPY package.json package-lock.json ./
RUN npm ci

# --- Build Layer ---
FROM base AS builder
COPY --from=deps /app/node_modules ./node_modules

# 🔥 ここが重要：環境変数ファイルをコピー
COPY .env.production .env.production

COPY . .
RUN npm run build

# --- Runner Layer ---
FROM base AS runner
WORKDIR /app

COPY --from=builder /app/public ./public
COPY --from=builder /app/.next ./.next
COPY --from=deps /app/node_modules ./node_modules
COPY package.json ./

EXPOSE 3000
ENV PORT=3000
CMD ["npm", "run", "start"]
