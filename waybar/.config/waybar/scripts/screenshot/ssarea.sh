#!/bin/sh

# Ensure the screenshots directory exists
mkdir -p ~/Pictures/Screenshots

# Define the filename with the current date and time
filename=~/Pictures/Screenshots/Area-$(date +%F_%T).png

# Use slurp to select an area
geometry=$(slurp)

# Start screenshot the area
grim -g "$geometry" - | wl-copy && wl-paste >$filename

# Notify the user that the Screenshot has done
dunstify -a screenshot "Screenshot of Area: $geometry taken" -t 3000
