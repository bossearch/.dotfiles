#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

WALLPAPER=$(find -L "$WALLPAPER_DIR" -type f | shuf -n 1)

ln -sf "$WALLPAPER" /tmp/hyprpaper.png

hyprpaper
