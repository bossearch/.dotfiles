#!/bin/bash

file="$1"

if [ -d "$file" ]; then
  eza -1 --tree --level=2 --all --icons=always --color=always "$file"
elif [ -f "$file" ]; then
  bat --color=always "$file"
else
  echo 'Not a file or directory'
fi
