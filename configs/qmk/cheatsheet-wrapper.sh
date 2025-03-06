#!/usr/bin/env bash
hyprctl dispatch movecursor 1280 720
kitty -T crkbd -o cursor="#1a1b26" -e ~/.config/qmk/crkbd-cheatsheet.sh
