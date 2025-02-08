#!/usr/bin/env bash

VOLUME_FILE="$HOME/.cache/bosse/volume"
CURRENT_VOLUME=$(cat "$VOLUME_FILE")

if [ "$DUNST_URGENCY" = "CRITICAL" ]; then
  pw-play ~/.config/dunst/sound/Sonar.mp3 --volume=$CURRENT_VOLUME
elif [ "$DUNST_APP_NAME" = "screenrecord" ]; then
  sleep 2 && pw-play ~/.config/dunst/sound/clapper-board.mp3 --volume=$CURRENT_VOLUME
elif [ "$DUNST_APP_NAME" = "screenshot" ]; then
  pw-play ~/.config/dunst/sound/camera-shutter.mp3 --volume=$CURRENT_VOLUME
elif [ "$DUNST_APP_NAME" = "nchat" ]; then
  pw-play ~/.config/dunst/sound/Livechat.mp3 --volume=$CURRENT_VOLUME
elif [ "$DUNST_APP_NAME" = "game-on" ]; then
  pw-play ~/.config/dunst/sound/Mario-power-up.mp3 --volume=$CURRENT_VOLUME
elif [ "$DUNST_APP_NAME" = "game-off" ]; then
  pw-play ~/.config/dunst/sound/Mario-power-down.mp3 --volume=$CURRENT_VOLUME
else
  pw-play ~/.config/dunst/sound/Chord.mp3 --volume=$CURRENT_VOLUME
fi
