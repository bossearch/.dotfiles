#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

WALLPAPER=$(find -L "$WALLPAPER_DIR" -type f | shuf -n 1)

ln -sf "$WALLPAPER" /tmp/current-wallpaper.jpg

export CURRENT_WALLPAPER="$WALLPAPER"
hyprpaper
