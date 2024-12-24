#!/bin/bash

DUNST_ICON_FILE="$HOME/.config/waybar/scripts/dunst/notification-icon"
DUNST_VOLUME_FILE="$HOME/.config/dunst/volume"

HYPRSUNSET_ICON_FILE="$HOME/.config/waybar/scripts/hyprsunset/hyprsunset-icon"
HYPRSUNSET_TEMP_FILE="$HOME/.config/waybar/scripts/hyprsunset/temperature"
HYPRSUNSET_TEMP_SCROLL="$HOME/.config/waybar/scripts/hyprsunset/temp-scroll"

GAMEMODE_FILE="$HOME/.cache/gamemode"

echo "󰂞" >"$DUNST_ICON_FILE"
echo "65536" >"$DUNST_VOLUME_FILE"

echo "  " >"$HYPRSUNSET_ICON_FILE"
echo "6500" | tee "$HYPRSUNSET_TEMP_FILE" "$HYPRSUNSET_TEMP_SCROLL"

if [ -f "$GAMEMODE_FILE" ]; then
  rm "$GAMEMODE_FILE"
fi
