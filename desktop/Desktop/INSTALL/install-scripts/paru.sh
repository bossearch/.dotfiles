#!/bin/bash

# Install base-devel if not already installed
echo "Installing base-devel..."
sudo pacman -S --needed base-devel

# Clone paru repository
echo "Cloning paru repository..."
git clone https://aur.archlinux.org/paru.git

# Change directory to paru
cd paru || {
  echo "Failed to change directory to paru. Exiting."
  exit 1
}

# Build and install paru
echo "Building and installing paru..."
makepkg -si

# Confirm success
if command -v paru >/dev/null 2>&1; then
  echo "Paru has been successfully installed."
else
  echo "Paru installation failed."
fi
