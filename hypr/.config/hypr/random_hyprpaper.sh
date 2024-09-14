#!/bin/bash
# Path to wallpapers directory
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Path to Hyprpaper config file
CONFIG_FILE="$HOME/.config/hypr/hyprpaper.conf"

# Select a random wallpaper
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
#echo $WALLPAPER
# Monitor to apply wallpaper to (replace DP-3 with your actual display name)
MONITOR="DP-3"

# Modify the config file to set the random wallpaper
sed -i "s|^wallpaper = $MONITOR, .*|wallpaper = $MONITOR, $WALLPAPER|" "$CONFIG_FILE"
#echo "Updated wallpaper line in config."
# Preload the wallpaper as well if necessary
sed -i "s|^preload = .*|preload = $WALLPAPER|" "$CONFIG_FILE"
#echo "Updated preload line in config."

# Check the contents of the config file after running sed
#echo "Config file after changes:"
#cat "$CONFIG_FILE"

# Reload Hyprpaper to apply the changes
hyprpaper
