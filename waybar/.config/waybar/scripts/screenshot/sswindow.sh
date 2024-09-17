#!/bin/sh

# Ensure the screenshots directory exists
mkdir -p ~/Pictures/Screenshots

# Get the active window information using hyprctl
window=$(hyprctl -j activewindow)

# Extract the window title, position, and size from the JSON
title=$(echo "$window" | jq -r '.initialTitle')
x=$(echo "$window" | jq -r '.at[0]')
y=$(echo "$window" | jq -r '.at[1]')
width=$(echo "$window" | jq -r '.size[0]')
height=$(echo "$window" | jq -r '.size[1]')

# Check if valid data is retrieved
if [ -z "$title" ] || [ -z "$x" ] || [ -z "$y" ] || [ -z "$width" ] || [ -z "$height" ]; then
  echo "Error: Could not retrieve active window information." >&2
  exit 1
fi

# Take a screenshot of the focused window using grim
grim -g "${x},${y} ${width}x${height}" - | wl-copy && wl-paste >~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png

# Send a notification
dunstify "Screenshot of $title taken" -t 2000
