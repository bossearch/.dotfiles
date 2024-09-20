#!/bin/bash
# Path to wallpapers directory
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Path to Hyprpaper config file
HYPRPAPER_FILE="$HOME/.config/hypr/hyprpaper.conf"

# Path to Hyprpaper config file
HYPRLOCK_FILE="$HOME/.config/hypr/hyprlock.conf"

# Select a random wallpaper
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

# Monitor to apply wallpaper to (replace DP-3 with your actual display name)
MONITOR="DP-3"

# Modify the config file to set the random wallpaper
sed -i "s|^wallpaper = $MONITOR, .*|wallpaper = $MONITOR, $WALLPAPER|" "$HYPRPAPER_FILE"

# Preload the wallpaper as well if necessary
sed -i "s|^preload = .*|preload = $WALLPAPER|" "$HYPRPAPER_FILE"

# Change hyprlock background to be same like hyprpaper wallpaper
sed -i '/background/,/}/ s|^\( *path *= *\).*|\1'" $WALLPAPER"'|' "$HYPRLOCK_FILE"

# Reload Hyprpaper to apply the changes
hyprpaper
