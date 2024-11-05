#!/bin/sh

zenity --question \
  --title="System Shutdown" \
  --text="Are you sure you want to shutdown your system?" \
  --width=200 \
  --height=100 \
  --icon-name=system-shutdown

if [ $? -eq 0 ]; then
  systemctl --quiet --no-warn poweroff
#else
#  echo "Shutdown canceled."
fi
