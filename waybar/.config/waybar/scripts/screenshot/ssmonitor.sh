#!/bin/bash

# Ensure the screenshots directory exists
mkdir -p ~/Pictures/Screenshots

# Get the name of the monitor/output using hyprctl (default to the first monitor)
output=$(hyprctl -j monitors | jq -r '.[0].name')

# Define the filename with the current date and time
filename=~/Pictures/Screenshots/$output-$(date +%F_%T).png

# Start screenshot the entire monitor
grim - | wl-copy && wl-paste >$filename

# Notify the user that the screenshot has done
dunstify "Screenshot of Monitor: $output taken" -t 3000
