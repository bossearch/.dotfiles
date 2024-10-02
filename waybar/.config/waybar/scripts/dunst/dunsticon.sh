#!/bin/sh

# File to store the current icon state
ICON_FILE="$HOME/.config/waybar/scripts/dunst/notification-icon"
VOLUME_FILE="$HOME/.config/dunst/volume"

# Read the current icon from the file
CURRENT_ICON=$(cat "$ICON_FILE")

# Cycle through the icons
case $CURRENT_ICON in
"󰂞")
  NEW_ICON="󰂚"
  echo "0" >"$VOLUME_FILE"
  ;;
"󰂚")
  NEW_ICON="󰂛"
  dunstctl set-paused true
  ;;
*)
  NEW_ICON="󰂞"
  dunstctl close-all
  dunstctl set-paused false
  echo "65536" >"$VOLUME_FILE"
  ;;
esac

# Update the icon file with the new icon
echo "$NEW_ICON" >"$ICON_FILE"

# Trigger a Waybar update
pkill -SIGRTMIN+10 waybar
