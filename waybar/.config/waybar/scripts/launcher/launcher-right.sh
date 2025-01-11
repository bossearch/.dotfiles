#!/bin/sh
hyprctl dispatch movecursor 1280 720
alacritty --option 'font.size=24' -t mousefzf -e ~/.config/fzf/extra/drun.sh
