#!/bin/bash

file="$1"

if [ -d "$file" ]; then
  eza -1 --color=always "$file"
elif [ -f "$file" ]; then
  bat --color=always "$file"
else
  echo 'Not a file or directory'
fi
