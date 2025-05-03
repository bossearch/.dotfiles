#!/usr/bin/env bash

pushd ~/Pictures/gowall >/dev/null || exit

DATE=$(date +%Y%m%d)
TODAY_WALL="/home/bosse/Pictures/gowall/wall-${DATE}.jpeg"
OUTPUT_WALL="/tmp/hyprpaper.png"
THEME="tokyo-dark"

if [ ! -f "$TODAY_WALL" ]; then
  yes y | gowall -w
  mv wall-"$DATE"-*.jpeg wall-"$DATE".jpeg
fi

if [ ! -f "$OUTPUT_WALL" ]; then
  gowall convert "$TODAY_WALL" -t "$THEME" --output "$OUTPUT_WALL"
  cp "$OUTPUT_WALL" /tmp/hyprlock.png
fi

popd >/dev/null || exit

hyprpaper
