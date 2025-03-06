#!/usr/bin/env bash
hyprctl dispatch movecursor 1280 720
kitty -T mousefzf -o font_size=24 "$HOME"/.config/fzf/extra/drun.sh
