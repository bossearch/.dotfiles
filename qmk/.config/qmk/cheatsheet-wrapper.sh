#!/bin/bash
hyprctl dispatch movecursor 1280 720
alacritty -t crkbd --option 'colors.cursor={cursor="#1a1b26"}' -e ~/.config/qmk/crkbd-cheatsheet.sh
