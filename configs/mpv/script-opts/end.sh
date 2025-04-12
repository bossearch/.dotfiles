#!/bin/bash

# Path to the mpv IPC socket
MPV_SOCKET="/tmp/mpv-socket"

# Check if the socket exists
if [[ ! -e "$MPV_SOCKET" ]]; then
  echo "mpv IPC socket not found. Is mpv running with --input-ipc-server?"
  exit 1
fi

#echo '{ "command": ["script-message", "playlist-view-toggle"] }' | socat - UNIX-CONNECT:"$MPV_SOCKET"
# Seek to the last second of the video
echo '{ "command": ["seek", "99999", "absolute"] }' | socat - UNIX-CONNECT:"$MPV_SOCKET"

# Resume playback if paused
echo '{ "command": ["set_property", "pause", false] }' | socat - UNIX-CONNECT:"$MPV_SOCKET"
