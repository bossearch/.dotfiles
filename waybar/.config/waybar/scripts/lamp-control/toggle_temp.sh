#!/bin/bash

lamp_ip="192.168.18.14"
port=38899

# Get the current temperature from the Python script
current_temp=$(python3 ~/.config/waybar/scripts/lamp-control/get_temp.py)

# Check if the current temperature is valid and toggle accordingly
if [ "$current_temp" -eq 4200 ] 2>/dev/null; then
  # Set temperature to 2700K
  echo -n "{\"id\":1,\"method\":\"setPilot\",\"params\":{\"temp\":2700}}" | ncat -u -w 1 $lamp_ip $port
elif [ "$current_temp" -eq 2700 ] 2>/dev/null; then
  # Set temperature to 4200K
  echo -n "{\"id\":1,\"method\":\"setPilot\",\"params\":{\"temp\":4200}}" | ncat -u -w 1 $lamp_ip $port
else
  echo "Failed to get or parse temperature."
fi
