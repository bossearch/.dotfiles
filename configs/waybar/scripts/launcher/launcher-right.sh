#!/usr/bin/env bash
hyprctl dispatch movecursor 1280 720
alacritty -t mousefzf --option 'font.size=24' -e zsh -c "~/.config/fzf/extra/drun.sh"
