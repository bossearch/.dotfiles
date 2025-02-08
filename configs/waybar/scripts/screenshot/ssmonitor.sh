#!/usr/bin/env bash

# Ensure the screenshots directory exists
mkdir -p ~/Pictures/Screenshots

# Get the name of the monitor/output using hyprctl (default to the first monitor)
OUTPUT=$(hyprctl -j monitors | jq -r '.[0].name')

# Define the filename with the current date and time
FILENAME="$HOME/Pictures/Screenshots/$OUTPUT-$(date +%F_%T).png"

# Start screenshot the entire monitor
grim - | wl-copy && wl-paste > $FILENAME

# Notify the user that the screenshot has done
notify-send -a screenshot "Screenshot of Monitor: $OUTPUT Taken" -t 3000
