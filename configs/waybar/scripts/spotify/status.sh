#!/bin/sh

status=$(playerctl -p spotify status)

if [[ $status == "Playing" ]]; then
  echo "{\"class\": \"playing\", \"text\": \"\", \"tooltip\": \"$album\"}"
elif [[ $status == "Paused" ]]; then
  echo "{\"class\": \"paused\", \"text\": \"\", \"tooltip\": \"$album\"}"
else
  # Handle the case when Spotify is not open or no player is found
  echo "{\"class\": \"stopped\", \"text\": \"\", \"tooltip\": \"No player found\"}"
fi
