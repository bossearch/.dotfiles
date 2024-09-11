#!/bin/bash

# Get the microphone source ID
MIC_SOURCE=$(pactl list short sources | grep -m 1 input | awk '{print $1}')

# Get the current mute state (0 for unmuted, 1 for muted)
MUTE_STATE=$(pactl get-source-mute $MIC_SOURCE | awk '{print $2}')

# Toggle the mute state
if [ "$MUTE_STATE" = "yes" ]; then
  pactl set-source-mute $MIC_SOURCE 0
  notify-send "Microphone Unmuted"
else
  pactl set-source-mute $MIC_SOURCE 1
  notify-send "Microphone Muted"
fi
