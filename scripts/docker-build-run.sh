#!/bin/sh

docker build -t bw-proxy .

BW_CLI="$HOME/.config/Bitwarden CLI"

if [ -d "$BW_CLI" ]; then
  docker run -it --rm \
       -v "$BW_CLI:/root/.config/Bitwarden CLI" \
       -p 127.0.0.1:8080 \
       --name bw-proxy bw-proxy:latest
else
  docker run -it --rm \
       -p 127.0.0.1:8080:8080 \
       --name bw-proxy bw-proxy:latest
fi
