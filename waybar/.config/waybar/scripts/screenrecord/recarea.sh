#!/bin/sh

# Ensure the screenshots directory exists
mkdir -p ~/Videos//Screenrecords

# Define the filename with the current date and time
filename=~/Videos/Screenrecords/Area-$(date +%F_%T).mp4

# Define tooltip file location
tooltip=~/.config/waybar/scripts/screenrecord/tooltip

# Use slurp to select an area
geometry=$(slurp)

# Check if a valid area was selected
if [ -z "$geometry" ]; then
  echo "Error: No area selected."
  exit 1
fi

# Create or update tooltip file for checkrec.sh
echo "Screenrecording on Area: $geometry" >$tooltip

# Notify the user that the recording has started
notify-send -a screenrecord "Screenrecording on Area: $geometry will start in 3 seconds" -t 2500
sleep 3

# Start recording the entire monitor
wl-screenrec --audio --low-power=off --no-damage -g "$geometry" -f "$filename"

# When the script finishes (e.g., with CTRL+C), notify the user
trap 'dunstify "Screenrecord saved to $filename" -t 3000' EXIT
