#!/bin/sh
hyprctl dispatch movecursor 1280 720
alacritty -t fastfetch --option 'colors.cursor={cursor="#1a1b26"}' -e zsh \
  -c "fastfetch --logo-position right --logo-padding-right 0; read -k"
