#!/bin/bash

# Exit script if any command fails
set -e

# Clone the Alacritty repository
if git clone https://github.com/ayosec/alacritty.git; then
  echo "Cloned Alacritty repository successfully."
else
  echo "Failed to clone Alacritty repository."
  exit 1
fi

# Change to the Alacritty directory
cd alacritty

# Install dependencies
echo "Installing dependencies..."
sudo pacman -S --needed rustup cmake freetype2 fontconfig pkg-config make libxcb libxkbcommon python

# Ensure Rust is set up correctly
rustup override set stable
rustup update stable

# Build Alacritty
echo "Building Alacritty..."
cargo build --release

# Check for any errors in Alacritty's terminfo
echo "Checking terminfo for Alacritty..."
if infocmp alacritty >/dev/null 2>&1; then
  echo "No errors in terminfo. Proceeding."
else
  echo "Errors found in terminfo, running 'tic' command to fix."
  sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
fi

# Install Alacritty binary to /usr/local/bin or any directory in $PATH
echo "Installing Alacritty binary..."
sudo cp target/release/alacritty /usr/local/bin

# Copy the Alacritty icon to the pixmaps directory
echo "Copying Alacritty icon..."
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg

# Install the Alacritty desktop entry
echo "Installing desktop entry..."
sudo desktop-file-install extra/linux/Alacritty.desktop

# Update the desktop database to recognize the new application
echo "Updating desktop database..."
sudo update-desktop-database

echo "Alacritty installed and desktop entry updated successfully!"
