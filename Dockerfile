# Builds the site with the same script Netlify runs, then serves dist/ with Caddy.
FROM node:22-bookworm AS build
WORKDIR /app
COPY . .
ENV NETLIFY_CACHE_DIR=/tmp/build-cache
RUN bash scripts/netlify-build.sh

FROM caddy:2-alpine
COPY Caddyfile /etc/caddy/Caddyfile
COPY --from=build /app/dist /srv
