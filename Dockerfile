FROM caddy AS caddy-stage

FROM node:23-slim AS bw-stage

RUN npm install -g @bitwarden/cli

RUN apt-get update && apt-get install -y curl gnupg apt-transport-https ca-certificates

WORKDIR /app

COPY Caddyfile .
COPY entrypoint.sh .

RUN chmod +x entrypoint.sh

EXPOSE 8080 443

COPY --from=caddy-stage /usr/bin/caddy /usr/bin/caddy

ENTRYPOINT ["./entrypoint.sh"]
