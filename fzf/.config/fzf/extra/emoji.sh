#!/bin/sh

# Location of your emoji list
EMOJI_FILE=~/.config/fzf/extra/emoji.txt

# Use fzf to select an emoji from the list
selected=$(cat "$EMOJI_FILE" | fzf --layout=default --border=none)

# Extract the emoji (first field)
emoji=$(echo "$selected" | awk '{print $1}')

# Copy the selected emoji to the clipboard (using xclip for X11 or wl-copy for Wayland)
echo -n "$emoji" | wl-copy # Use xclip if you're on X11

# Insert the emoji using wtype
#wtype "$emoji"
#sleep 0.2
echo "$emoji" | xargs -r -I {} sh -c 'nohup wtype "{}" >/dev/null 2>&1 & disown'

# Notify the user
#notify-send "Emoji Picker" "Copied $emoji to clipboard"
