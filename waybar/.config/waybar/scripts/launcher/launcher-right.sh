#!/bin/sh
hyprctl dispatch movecursor 1280 720
alacritty -t fzf -e ~/.config/fzf/extra/drun.sh
