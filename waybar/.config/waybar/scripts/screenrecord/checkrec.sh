#!/bin/bash

# get content from tooltip file
tooltip=$(cat ~/.config/waybar/scripts/screenrecord/tooltip)

# Check if wl-screenrec is running
if pgrep wl-screenrec >/dev/null; then
  # If wl-screenrec is running, display the recording icon in white
  echo "{\"class\": \"recording\", \"text\": \"\", \"tooltip\": \"$tooltip\"}"
else
  # If wl-screenrec is not running
  exit
fi
