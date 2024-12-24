#!/bin/sh

# Toggle the visibility of sysboard
if pgrep sysboard >/dev/null; then
  dunstctl close
  notify-send "Virtual Keyboard" "Hold"
  pkill -10 sysboard
else
  notify-send "Virtual Keyboard" "On"
  sysboard -H 0.4 -m 8
fi
