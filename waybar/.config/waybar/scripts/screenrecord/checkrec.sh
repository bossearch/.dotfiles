#!/bin/sh

# Path to the icon file
icon_file="$HOME/.config/waybar/scripts/screenrecord/icon"

# Get content from tooltip file
tooltip=$(cat ~/.config/waybar/scripts/screenrecord/tooltip)

# Define icons
icon_recording=""
icon_alternate="󰻂"

# Check if wl-screenrec is running and display the appropriate icon
if pgrep wl-screenrec >/dev/null; then
  current_icon=$(cat "$icon_file")
  # Determine the next icon to display
  if [ "$current_icon" = "$icon_recording" ]; then
    next_icon="$icon_alternate"
  else
    next_icon="$icon_recording"
  fi

  # Update the state file with the new icon
  echo "$next_icon" >"$icon_file"
  echo "{\"class\": \"recording\", \"text\": \"$next_icon\", \"tooltip\": \"$tooltip\"}"
else
  exit
fi
