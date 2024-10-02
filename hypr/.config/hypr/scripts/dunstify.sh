#!/bin/sh

# File to store the current icon state
ICON_FILE="$HOME/.config/waybar/scripts/dunst/notification_icon"
VOLUME_FILE="$HOME/.config/dunst/volume"

echo "󰂞" >"$ICON_FILE" && echo "65536" >"$VOLUME_FILE"
