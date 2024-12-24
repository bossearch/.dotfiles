#!/bin/bash

# Install git and base-devel if not already installed
echo "Installing git and base-devel..."
sudo pacman -S --needed git base-devel

# Clone yay repository
echo "Cloning yay repository..."
git clone https://aur.archlinux.org/yay.git

# Change directory to yay
cd yay || {
  echo "Failed to change directory to yay. Exiting."
  exit 1
}

# Build and install yay
echo "Building and installing yay..."
makepkg -si

# Confirm success
if command -v yay >/dev/null 2>&1; then
  echo "Yay has been successfully installed."
else
  echo "Yay installation failed."
fi
