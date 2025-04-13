#!/bin/bash

read -p "Enter basicauth username: " USER || return $?
read -s -p "Enter your basicauth password: " PASS || return $?
echo

NEW_HASH=$(caddy hash-password --plaintext "$PASS")
sed -i "s|^\s*CADDY_USER$|        ${USER} ${NEW_HASH}|" Caddyfile

# Start Caddy in the background
caddy run --config /app/Caddyfile &

ldd /usr/local/bin/bw               # check shared libs
export BW_SESSION="$(bw login --raw)"

# Start Bitwarden
bw serve --hostname 127.0.0.1 --port 8087
