acestream() {
  if ! is-acestream-container-running; then
    start-acestream-container >/dev/null
  fi

  vlc "http://localhost:6878/ace/getstream?id=$1"
}

is-acestream-container-running() {
  docker ps --format '{{.Names}}' | grep -qx 'acestream'
}

start-acestream-container() {
  create-acestream-container
  docker start acestream >/dev/null
}

create-acestream-container() {
  is-acestream-container-created || docker create \
    --name acestream \
    --platform linux/amd64 \
    -p 6878:6878 \
    -p 8621:8621 \
    -p 62062:62062/udp \
    --restart unless-stopped \
    vstavrinov/acestream-engine:latest >/dev/null
}

is-acestream-container-created() {
  docker ps -a --format '{{.Names}}' | grep -qx 'acestream'
}

stop-acestream-container() {
  docker stop acestream
}

delete-acestream-container() {
  docker rm -f acestream 2>/dev/null || true
}

alias sub='subdb d'
