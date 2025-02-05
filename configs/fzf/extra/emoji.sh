#!/bin/sh

# Location of your emoji list
EMOJI_FILE=~/.config/fzf/extra/assets/emoji.txt

# Use fzf to select an emoji from the list
selected=$(cat "$EMOJI_FILE" | fzf -m --layout=default --border=none --highlight-line --info=inline-right --prompt="❯ " \
  --color=fg:#c0caf5,fg+:#B1BAE4,bg:#1a1b26,bg+:#16161e,hl:#92BE67,hl+:#93d84e --color=info:#7296E6,marker:#E26E87,prompt:#AC8FE6,spinner:#E26E87,pointer:#E26E87 --color=gutter:#1a1b26,separator:#27a1b9,scrollbar:#27a1b9,label:#aeaeae,query:#B1BAE4)
# Extract the emoji (first field)
emoji=$(echo "$selected" | awk '{print $1}')

# Copy the selected emoji to the clipboard (using xclip for X11 or wl-copy for Wayland)
echo -n "$emoji" | wl-copy # Use xclip if you're on X11

# Insert the emoji using wtype
#echo "$emoji" | xargs -r -I {} sh -c 'nohup wtype "{}" >/dev/null 2>&1 & disown'
