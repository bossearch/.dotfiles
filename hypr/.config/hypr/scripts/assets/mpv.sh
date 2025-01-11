#!/bin/bash

MPV_SOCKET="/tmp/mpv-socket"

# Check if mpv is already running
if pgrep -x "mpv" >/dev/null; then
  echo '{ "command": ["quit"] }' | ncat -U /tmp/mpv-socket
else
  mpv --player-operation-mode=pseudo-gui --input-ipc-server=/tmp/mpv-socket
fi
