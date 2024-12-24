#!/bin/bash

# Show a dialog to choose an application
choice=$(zenity --list --title="App Selector" \
  --column="App" "Steam" "PrismLauncher" \
  --width=480 --height=360)

# Check the user's choice and launch the selected app
case $choice in
"Steam")
  steam
  ;;
"PrismLauncher")
  prismlauncher
  ;;
*)
  # Do nothing if no selection is made
  ;;
esac
