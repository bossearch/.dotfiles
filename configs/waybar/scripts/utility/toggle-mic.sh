#!/usr/bin/env bash

# Get the current mute state
MUTE_STATE=$(wpctl get-volume @DEFAULT_SOURCE@ | awk '{print $3}')

# Toggle the mute state
if [ "$MUTE_STATE" = "[MUTED]" ]; then
  wpctl set-mute @DEFAULT_SOURCE@ 0
  notify-send "Microphone Unmuted"
else
  wpctl set-mute @DEFAULT_SOURCE@ 1
  notify-send "Microphone Muted"
fi
