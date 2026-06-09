# Stage 1: builder
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build


# Stage 2: runner
FROM node:20-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production

COPY package*.json ./
RUN npm ci --omit=dev

COPY --from=builder /app/config ./config
COPY --from=builder /app/database ./database
COPY --from=builder /app/public ./public
COPY --from=builder /app/src ./src
COPY --from=builder /app/types ./types
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/package-lock.json ./package-lock.json

RUN addgroup -S strapi && adduser -S strapi -G strapi
RUN chown -R strapi:strapi /app

USER strapi

EXPOSE 1337

CMD ["npm", "run", "start"]