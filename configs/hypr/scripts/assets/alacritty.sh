#!/usr/bin/env bash

# Check if tmux is installed
if command -v tmux >/dev/null 2>&1; then
  source ~/.config/fzf/extra/tmux
  TERM_TITLE=$(hyprctl activewindow | awk -F': ' '/title: / {print $2}')
  # Check if the title is "magic"
  if [ "$TERM_TITLE" = "scratchpad" ]; then
    # Do nothing explicitly
    :
  else
    if ! tmux has-session 2>/dev/null; then
      # Ask for a session name
      SESSION_NAME=$(zenity --entry --title="Tmux Session" --text="Enter tmux session name:" 2>/dev/null)
      # Use "0" as default if no input is given
      SESSION_NAME=${SESSION_NAME:-0}
      # Start a new tmux session with the given name
      tm "$SESSION_NAME"
    else
      if tmux list-sessions -F '#{session_attached}' | grep -q '^1$'; then
        # Do nothing explicitly
        :
      else
        tmux attach-session
      fi
    fi
  fi
else
  :
fi
