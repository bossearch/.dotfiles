#!/bin/sh

# Ensure the screenshots directory exists
mkdir -p ~/Videos//Screenrecords

# Get the name of the monitor/output using hyprctl (default to the first monitor)
output=$(hyprctl -j monitors | jq -r '.[0].name')

# Define the filename with the current date and time
filename=~/Videos/Screenrecords/$output-$(date +%F_%T).mp4

# Define tooltip file location
tooltip=~/.config/waybar/scripts/screenrecord/tooltip

# Create or update tooltip file for checkrec.sh
echo "Screenrecording on Monitor: $output" >$tooltip

# Notify the user that the recording has started
dunstify -a screenrecord "Screenrecording on Monitor: $output will start in 3 seconds" -t 2500
sleep 2

# Start recording the entire monitor
wl-screenrec --audio --low-power=off --no-damage -o "$output" -f "$filename"

# When the script finishes (e.g., with CTRL+C), notify the user
trap 'dunstify "Screenrecord saved to $filename" -t 3000' EXIT
