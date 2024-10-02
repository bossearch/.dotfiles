#!/bin/sh

VOLUME_FILE="$HOME/.config/dunst/volume"
CURRENT_VOLUME=$(cat "$VOLUME_FILE")

if [ "$DUNST_URGENCY" = "CRITICAL" ]; then
  paplay ~/.config/dunst/sound/Sonar.mp3 --volume=$CURRENT_VOLUME
elif [ "$DUNST_APP_NAME" = "screenrecord" ]; then
  sleep 2 && paplay ~/.config/dunst/sound/clapper-board.mp3 --volume=$CURRENT_VOLUME
elif [ "$DUNST_APP_NAME" = "screenshot" ]; then
  paplay ~/.config/dunst/sound/camera-shutter.mp3 --volume=$CURRENT_VOLUME
else
  paplay ~/.config/dunst/sound/Note.mp3 --volume=$CURRENT_VOLUME
fi
