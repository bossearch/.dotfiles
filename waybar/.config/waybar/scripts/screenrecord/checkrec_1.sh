#!/bin/sh

# Icons
icon_recording=""
icon_alternate="󰻂"

# Get the tooltip content
tooltip=$(cat ~/.config/waybar/scripts/screenrecord/tooltip)

# Check if wl-screenrec is running
if pgrep wl-screenrec >/dev/null; then
  echo "Debug: wl-screenrec is running" >&2
  for i in {1..3}; do
    # Display the recording icon
    echo "{\"class\": \"recording\", \"text\": \"$icon_recording\", \"tooltip\": \"$tooltip\"}"
    sleep 1

    # Display the alternate icon
    echo "{\"class\": \"recording\", \"text\": \"$icon_alternate\", \"tooltip\": \"$tooltip\"}"
    sleep 1
  done
else
  echo "Debug: wl-screenrec is not running" >&2
  # If wl-screenrec is not running, exit
  exit
fi
