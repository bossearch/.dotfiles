#!/bin/bash

# Initialize state variables
shift_locked=false
last_shift_time=0
shift_timeout=500 # 500ms for double-tap detection
shift_key_pressed=false

# Monitor for Shift key press/release
while true; do
  # Monitor the input event stream for Shift key presses/releases
  sudo evtest /dev/input/event3 | while read -r event; do
    # Check if the event is related to the LEFT SHIFT key (code 42)
    if echo "$event" | grep -q "code 42"; then
      # Get the value (1 for press, 0 for release, 2 for held)
      value=$(echo "$event" | grep -oP 'value \K\d+')

      # Handle Shift press (value 1) or release (value 0)
      if [ "$value" -eq 1 ]; then
        shift_key_pressed=true
        if $shift_locked; then
          shift_locked=false
          notify-send "Shift Released" "Press Shift to lock" -u low
        fi
      elif [ "$value" -eq 0 ]; then
        shift_key_pressed=false
      elif [ "$value" -eq 2 ] && ! $shift_locked && $shift_key_pressed; then
        # If Shift key is being held (value 2) and Shift is not locked, lock it
        shift_locked=true
        notify-send "Shift Locked" "Press Shift to unlock" -u normal
      fi
    fi
  done
done
