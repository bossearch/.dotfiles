#!/usr/bin/env bash
# original gist = https://gist.github.com/0atman/1a5133b842f929ba4c1e195ee67599d5

set -e

# Get the hostname
HOSTNAME=$(hostname)

# cd to your config dir
pushd ~/.dotfiles >/dev/null

# Check for arguments
if [[ "$1" == "--switch" ]]; then
  REBUILD_CMD="switch"
elif [[ "$1" == "--boot" ]]; then
  REBUILD_CMD="boot"
elif [[ "$1" == "--test" ]]; then
  REBUILD_CMD="test"
elif [[ "$1" == "--update" ]]; then
  nix flake update
  exit 0
elif [[ "$1" == "--delete" ]]; then
  sudo nix-collect-garbage -d
  exit 0
else
  echo -e "rebuild -<\e[1;33moptions\e[0m> = nixos-rebuild <\e[1;33moptions\e[0m> --flake .#hostname\n"
  echo -e "-\e[1;33mswitch\e[0m  Build and activate the new configuration, and make it the boot default.\n"
  echo -e "-\e[1;33mboot\e[0m    Build the new configuration and make it the boot default \
(as with nixos-rebuild switch),\n         but do not activate it. That is, the system continues \
to run the previous configuration until the next reboot.\n"
  echo -e "-\e[1;33mtest\e[0m    Build and activate the new configuration, but do not add it to the GRUB boot menu.\n\
         Thus, if you reboot the system  (or if it crashes), you will automatically revert to the default configuration \n\
         (i.e. the configuration resulting from the last call to nixos-rebuild switch or nixos-rebuild boot).\n"
  echo -e "by default this scripts will go to my dotfile directory, which is ~/.dotfiles"
  popd >/dev/null
  exit 0
fi

# Check for -force argument
FORCE_UPDATE=false
if [[ "$2" == "--force" ]]; then
  FORCE_UPDATE=true
fi

# Skip "no changes detected" check if -force is provided
if [[ "$FORCE_UPDATE" == false ]]; then
  # Early return if no changes were detected (thanks @singiamtel!)
  if git diff --quiet '*.nix'; then
    echo "No changes detected, exiting."
    popd >/dev/null
    exit 0
  fi
  # Show your changes
  git diff -U0 --no-prefix '*.nix' | rg '^(?:diff --git |(?:\+[^+]|-[^-]))' | sed -E \
    -e 's/^(diff --git .*)/\n\x1b[1m\1\x1b[0m/' \
    -e 's/^(\+)(.*)/\x1b[32m+\2\x1b[0m/' \
    -e 's/^(-)(.*)/\x1b[31m-\2\x1b[0m/'

  echo ""
  git status --short '*.nix'

  # Stage all changes
  git add .
fi

echo ""
trap 'tput cnorm; git reset -q; echo -e "\nAborted by user."; exit 1' SIGINT
read -p "Are you sure you want to proceed? (y/N): " confirm
confirm="${confirm:-y}"
if [[ ! "$confirm" =~ ^[yY]$ ]]; then
  git reset -q
  echo "Aborted."
  popd >/dev/null
  exit 0
fi

echo ""
echo -e "NixOS Rebuilding for host: \e[1m$HOSTNAME\e[0m (mode: \e[33m$REBUILD_CMD\e[0m)"

# Ensure sudo doesn't ask for a password mid-way
sudo -v

# Function to show a spinner
spinner() {
  local pid=$1
  local delay=0.1
  local spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
  local max_width=60
  tput civis

  while ps -p $pid &>/dev/null; do
    for i in $(seq 0 $((${#spin} - 1))); do
      local last_log=$(tail -n 1 .nixos.log | cut -c 1-$max_width) # Get the last line from the log file
      echo -ne "\r\033[K\e[33m[${spin:$i:1}]\e[0m $last_log"
      sleep $delay
    done
  done

  echo -ne "\r\033[K" # Clear the spinner line after finishing
}

# Run nixos-rebuild in the background
sudo nixos-rebuild "$REBUILD_CMD" --flake ".#$HOSTNAME" &>.nixos.log &
rebuild_pid=$!

# Start spinner animation
spinner $rebuild_pid
tput cnorm

# Check exit status
if wait $rebuild_pid; then
  CURRENT=$(nixos-rebuild list-generations | grep current | tr -s ' ' | tr -d '*')
  echo -e "\e[32mDone\e[0m - \e[1m$CURRENT\e[0m"
  notify-send -e "NixOS Rebuild ($REBUILD_CMD)" "Done" --icon=software-update-available
else
  notify-send -e "NixOS Rebuild ($REBUILD_CMD)" "Error" --icon=software-update-urgent --urgency=critical
  git reset -q

  echo ""
  cat .nixos.log | grep --color error
  echo ""

  if read -p "Open log? (y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
    nvim .nixos.log
  fi

  popd >/dev/null
  exit 1
fi
