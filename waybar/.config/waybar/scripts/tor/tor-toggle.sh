#!/bin/sh

if systemctl is-active --quiet tor; then
  pkexec ~/.config/waybar/scripts/tor/tor-disable.sh
  pkill -SIGRTMIN+11 waybar
  dunstify "TOR Disabled"
else
  pkexec ~/.config/waybar/scripts/tor/tor-enable.sh
  pkill -SIGRTMIN+11 waybar
  dunstify "TOR Enabled"
fi
