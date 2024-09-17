#!/bin/sh

# Path to the icon state file
#icon_state_file="$HOME/.config/waybar/scripts/screenrecord/icon_state"

# Path to the icon file
icon_file="$HOME/.config/waybar/scripts/screenrecord/icon"

# Get content from tooltip file
tooltip=$(cat ~/.config/waybar/scripts/screenrecord/tooltip)

# Define icons
icon_recording=""
icon_alternate="󰻂"

# Check if the icon state file exists
#if [ -f "$icon_state_file" ]; then
#  # Read the current state from the file
#  current_icon=$(cat "$icon_state_file")
#else
#  # If the state file does not exist, initialize with the recording icon
#  current_icon="$icon_recording"
#fi

#current_icon=$(cat "$icon_file")
## Determine the next icon to display
#if [ "$current_icon" = "$icon_recording" ]; then
#  next_icon="$icon_alternate"
#else
#  next_icon="$icon_recording"
#fi
#
## Write the next icon to the icon file
##echo "$next_icon" >"$icon_file"
#
## Update the state file with the new icon
#echo "$next_icon" >"$icon_file"

# Check if wl-screenrec is running and display the appropriate icon
if pgrep wl-screenrec >/dev/null; then
  current_icon=$(cat "$icon_file")
  # Determine the next icon to display
  if [ "$current_icon" = "$icon_recording" ]; then
    next_icon="$icon_alternate"
  else
    next_icon="$icon_recording"
  fi

  # Write the next icon to the icon file
  #echo "$next_icon" >"$icon_file"

  # Update the state file with the new icon
  echo "$next_icon" >"$icon_file"
  echo "{\"class\": \"recording\", \"text\": \"$next_icon\", \"tooltip\": \"$tooltip\"}"
else
  exit
fi
