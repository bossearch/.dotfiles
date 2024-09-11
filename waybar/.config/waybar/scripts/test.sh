#!/bin/bash
# Extract the window ID of the active window
WINDOW_ID=$(hyprctl activewindow | grep 'Window' | awk '{print $2}')

# If a valid window ID is found, close the window
if [ -n "$WINDOW_ID" ]; then
  echo "Closing window with ID: $WINDOW_ID"
  hyprctl dispatch closewindow "$WINDOW_ID"
else
  echo "No active window found or no valid window ID."
fi
