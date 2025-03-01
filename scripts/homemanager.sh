#!/usr/bin/env bash

set -e

# Get the hostname and username
HOSTNAME=$(hostname)
USERNAME=$(whoami)

# Change to config directory
pushd ~/.dotfiles >/dev/null

# Default OPTIONS (Prevent empty execution)
OPTIONS=""

# Check for arguments
case "$1" in
  "--switch") OPTIONS="switch --flake ." ;;
  "--delete") OPTIONS="expire-generations -d" ;;
  "--list") home-manager generations; exit 0 ;;
  *) echo -e "\e[31mError:\e[0m Invalid option"; exit 1 ;;
esac

# Stage all changes
git add .

echo ""
trap 'tput cnorm; git reset -q; echo -e "\nAborted by user."; exit 1' SIGINT
read -p "Are you sure you want to proceed? (y/N): " confirm
confirm="${confirm:-n}"
if [[ ! "$confirm" =~ ^[yY]$ ]]; then
  git reset -q
  echo "Aborted."
  popd >/dev/null
  exit 0
fi

echo ""
echo -e "Home Manager running for \e[33m$USERNAME\e[0m@\e[1m$HOSTNAME\e[0m"

# Function to show a spinner
spinner() {
  local pid=$1
  local delay=0.1
  local spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
  local max_width=120
  tput civis

  while ps -p $pid &>/dev/null; do
    for ((i=0; i<${#spin}; i++)); do
      local last_log=$(tail -n 1 .hm.log | cut -c 1-$max_width) # Get the last line from the log file
      echo -ne "\r\033[K\e[33m[${spin:$i:1}]\e[0m $last_log"
      sleep $delay
    done
  done

  echo -ne "\r\033[K" # Clear spinner after finishing
}

# Run home-manager in the background
home-manager $OPTIONS &>.hm.log &
rebuild_pid=$!

# Start spinner animation
spinner $rebuild_pid
tput cnorm

# Check exit status
if wait $rebuild_pid; then
  CURRENT=$(home-manager generations | sed -n '2p')
  echo -e "\e[32mDone\e[0m - \e[1m$CURRENT\e[0m"
  notify-send -e "Home Manager" "Done" --icon=software-update-available
else
  notify-send -e "Home Manager" "Error" --icon=software-update-urgent --urgency=critical
  git reset -q

  if read -p "Open log? (y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
    nvim .hm.log
  fi

  popd >/dev/null
  exit 1
fi
