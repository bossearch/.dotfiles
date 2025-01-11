#!/bin/bash

# Path to the mpv.desktop file
MPV_DESKTOP="/usr/share/applications/mpv.desktop"

# Check if the mpv.desktop file exists
if [[ -f "$MPV_DESKTOP" ]]; then
  # Use sed to replace the Exec line with the new command
  sudo sed -i 's|^Exec=mpv --player-operation-mode=pseudo-gui -- %U|Exec=mpv --player-operation-mode=pseudo-gui --input-ipc-server=/tmp/mpv-socket|' "$MPV_DESKTOP"
  echo "Updated Exec line in mpv.desktop."
else
  echo "mpv.desktop not found at $MPV_DESKTOP."
fi
