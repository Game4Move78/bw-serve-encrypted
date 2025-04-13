# bw serve encrypted with TLS

`bw serve` can be used to use Bitwarden CLI without the long warmup time by accessing the vault through an express web server. Unfortunately it only communicates over HTTP and offers the same access to every app without credentials. This Docker container hides the port, and uses a Caddy server to add HTTPs and credentials.

## Installation

### Build

Build the docker container with Caddy and Bitwarden CLI. The Caddyfile and entrypoint.sh will be copied into the container, and port 8080 will be used.

```sh
docker build -t bw-proxy .
```

## Run

This will launch bw serve and expose it through an authenticated https server using Caddy. Provide a username and password for connecting to the vault. The vault will also be protected by the master password when locked.

```sh
docker run -it --rm \
  -v "$HOME/.config/Bitwarden CLI:/root/.config/Bitwarden CLI" \
  -p 127.0.0.1:8080:8080 \
  --name bw-proxy bw-proxy:latest
```

## Credential

Copy the TLS certificate from outside your Docker container to enable encrypted HTTPS.

```sh
docker run -it --rm -v $HOME/.config/Bitwarden\ CLI:/root/.config/Bitwarden\ CLI -p 127.0.0.1:8080:8080 --name bw-proxy bw-proxy:latest
```

You will now have a file in this repo called root.crt. You can test the server with

```sh
curl --cacert root.crt -u USER:PASS https://localhost:8080/status
```

# Helper scripts

```sh
./scripts/docker-build-run.sh
./scripts/docker-certificate.sh
```

# Notes

The Docker image is based on node:23-slim.
