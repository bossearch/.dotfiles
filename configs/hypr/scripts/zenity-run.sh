#!/usr/bin/env bash

# Show a dialog to choose an application
choice=$(zenity --list --title="App Selector" \
  --column="App" "Steam" "PrismLauncher" "Waydroid" "VirtManager"\
  --width=480 --height=385)

# Check the user's choice and launch the selected app
case $choice in
"Steam")
  steam
  ;;
"PrismLauncher")
  prismlauncher
  ;;
"Waydroid")
  if pkexec ~/.config/hypr/scripts/assets/waydroid-run.sh; then
    # Only show the Waydroid UI if the run script succeeded
    waydroid show-full-ui
  else
    :
  fi
  ;;
"VirtManager")
  virt-manager
  ;;
*)
  # Do nothing if no selection is made
  ;;
esac
