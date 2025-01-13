#!/bin/sh

# Read the app names and Exec commands from the saved txt file
apps_list=$(cat $HOME/.config/fzf/extra/assets/drun.txt)

# Use fzf to list app names and select one
selected=$(
  echo "$apps_list" | cut -d'|' -f1 | sort |
    fzf -m --layout=default --border=none --highlight-line --info=inline-right --prompt="❯ " \
      --color=fg:#c0caf5,fg+:#B1BAE4,bg:#1a1b26,bg+:#16161e,hl:#92BE67,hl+:#93d84e \
      --color=info:#7296E6,marker:#E26E87,prompt:#AC8FE6,spinner:#E26E87,pointer:#E26E87 \
      --color=gutter:#1a1b26,separator:#27a1b9,scrollbar:#27a1b9,label:#aeaeae,query:#B1BAE4 \
      --bind "enter:accept"
)

# Run the selected application's Exec command
if [ -n "$selected" ]; then
  # Get the corresponding Exec command from the list
  exec_command=$(echo "$apps_list" | grep "^$selected|" | cut -d'|' -f2)

  drun="setsid $exec_command >/dev/null 2>&1 &"
  eval "$drun"

  if echo "$exec_command" | grep -q "pkexec"; then
    # Delay execution to allow pkexec to process properly
    sleep 1
  else
    :
  fi
fi
