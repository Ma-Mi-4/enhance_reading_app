# -------------------------
# 1. Install dependencies
# -------------------------
FROM node:20-alpine AS deps
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci

# -------------------------
# 2. Build Next.js in standalone mode (webpack)
# -------------------------
FROM node:20-alpine AS builder
WORKDIR /app

COPY . .
COPY --from=deps /app/node_modules ./node_modules

ENV NEXT_TELEMETRY_DISABLED=1
RUN npm run build --webpack

# -------------------------
# 3. Production image
# -------------------------
FROM node:20-alpine AS runner
WORKDIR /app

ENV NODE_ENV=production
ENV PORT=3000

# Public assets
COPY --from=builder /app/public ./public

# Standalone build output
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static

COPY package.json ./

EXPOSE 3000

CMD ["node", "server.js"]
