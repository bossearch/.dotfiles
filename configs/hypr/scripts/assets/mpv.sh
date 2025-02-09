#!/usr/bin/env bash

MPV_SOCKET="/tmp/mpv-socket"

# Check if mpv is already running
if pgrep -x "mpv" >/dev/null; then
  echo '{ "command": ["quit"] }' | socat - UNIX-CONNECT:/tmp/mpv-socket
else
  mpv --player-operation-mode=pseudo-gui --input-ipc-server=/tmp/mpv-socket
fi
