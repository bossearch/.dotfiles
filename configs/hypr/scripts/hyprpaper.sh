#!/usr/bin/env bash

pushd ~/Pictures/gowall >/dev/null || exit

DATE=$(date +%Y%m%d)

INPUT_WALL=$(find /home/bosse/Pictures/gowall -maxdepth 1 -type f -name "wall-${DATE}.*" -printf "%f\n" | head -n 1)
OUTPUT_WALL="/tmp/hyprpaper.png"
THEME="tokyo-dark"

if [ ! -f "$INPUT_WALL" ]; then
  yes y | gowall -w
  echo "wall downloaded"
else
  echo "wall already exist"
fi

TODAY_WALL=$(find /home/bosse/Pictures/gowall -maxdepth 1 -type f -name "wall-${DATE}-*" -printf "%f\n" | head -n 1)
# Extract components using regex
if [[ "$TODAY_WALL" =~ wall-([0-9]{8})-[0-9]{6}\.([a-zA-Z0-9]+)$ ]]; then
  date_part="${BASH_REMATCH[1]}"
  ext="${BASH_REMATCH[2]}"
  dir=$(dirname "$TODAY_WALL")
  RENAMED_WALL="$dir/wall-${date_part}.${ext}"

  mv "$TODAY_WALL" "$RENAMED_WALL"
  echo "TODAY_WALL renamed"
else
  echo "TODAY_WALL does not match expected pattern."
fi

if [ ! -f "$OUTPUT_WALL" ]; then
  gowall convert "$INPUT_WALL" -t "$THEME" --output "$OUTPUT_WALL"
  cp "$OUTPUT_WALL" /tmp/hyprlock.png
fi

popd >/dev/null || exit
pkill hyprpaper; hyprpaper
