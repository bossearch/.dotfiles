#!/bin/sh

# Ensure the screenshots directory exists
mkdir -p ~/Videos//Screenrecords

# Define tooltip file location
tooltip=~/.config/waybar/scripts/screenrecord/tooltip

# Get the active window's geometry using hyprctl
window=$(hyprctl -j activewindow)
title=$(echo "$window" | jq '.initialTitle')
x=$(echo "$window" | jq '.at[0]')
y=$(echo "$window" | jq '.at[1]')
width=$(echo "$window" | jq '.size[0]')
height=$(echo "$window" | jq '.size[1]')

# Define the filename with the current date and time
filename=~/Videos/Screenrecords/$title-$(date +%F_%T).mp4

# Check if valid data is retrieved
if [ -z "$title" ] || [ -z "$x" ] || [ -z "$y" ] || [ -z "$width" ] || [ -z "$height" ]; then
  echo "Error: Could not retrieve active window information."
  exit 1
fi

# Define the geometry string for wl-screenrec
geometry="${x},${y} ${width}x${height}"

# Create or update tooltip file for checkrec.sh
echo "Screenrecording on $title" >$tooltip

# Notify the user that the recording is about to start
dunstify -a screenrecord "Screenrecording on $title will start in 3 seconds " -t 2500
sleep 2

# Start recording the active window
wl-screenrec --audio --low-power=off --no-damage -g "$geometry" -f "$filename"

# When the script finishes (e.g., with CTRL+C), notify the user
trap 'dunstify "Screenrecord saved to $filename" -t 3000' EXIT
