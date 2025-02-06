#!/bin/sh

status=$(playerctl -p spotify status)

if [[ $status == "Playing" ]]; then
  playerctl -p spotify pause
  pkill -SIGRTMIN+9 waybar
fi

if [[ $status == "Paused" ]]; then
  playerctl -p spotify play
  pkill -SIGRTMIN+9 waybar
fi
