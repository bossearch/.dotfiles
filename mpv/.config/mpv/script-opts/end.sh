#!/bin/bash

# Path to the mpv IPC socket
MPV_SOCKET="/tmp/mpv-socket"

# Check if the socket exists
if [[ ! -e "$MPV_SOCKET" ]]; then
  echo "mpv IPC socket not found. Is mpv running with --input-ipc-server?"
  exit 1
fi

#echo '{ "command": ["script-message", "playlist-view-toggle"] }' | ncat -U /tmp/mpv-socket
# Seek to the last second of the video
echo '{ "command": ["seek", "99999", "absolute"] }' | ncat -U "$MPV_SOCKET"

# Resume playback if paused
echo '{ "command": ["set_property", "pause", false] }' | ncat -U "$MPV_SOCKET"
