#!/bin/bash

# Get the directory of the current script
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

# Copy the mirrorlist to the appropriate directory
sudo cp "$SCRIPT_DIR/assets/mirrorlist" /etc/pacman.d/mirrorlist

echo "Pacman mirrorlist updated"
