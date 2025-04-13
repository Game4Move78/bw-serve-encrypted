#!/bin/sh

# Copy the root certificate from the running container
docker cp bw-proxy:/root/.local/share/caddy/pki/authorities/local/root.crt ./root.crt
echo
echo 'Try using: curl --cacert root.crt -u USER:PASS https://localhost:8080/status'
