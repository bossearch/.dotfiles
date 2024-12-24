#!/bin/bash

# Exit on error
set -e

# Define script directory and asset files
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
OVERRIDE_CONF="$SCRIPT_DIR/assets/override.conf"
CONFIG_INI="$SCRIPT_DIR/assets/config.ini"

# Install ly package (Assuming you're on Arch Linux)
echo "Installing Ly package..."
sudo pacman -S --noconfirm ly

# Create systemd directory for ly override if it doesn't exist
echo "Creating override directory..."
sudo mkdir -p /etc/systemd/system/ly.service.d

# Copy override.conf to /etc/systemd/system/ly.service.d/
echo "Copying override.conf..."
sudo cp "$OVERRIDE_CONF" /etc/systemd/system/ly.service.d/override.conf

# Copy and replace config.ini to /etc/ly/config.ini
echo "Copying config.ini..."
sudo cp "$CONFIG_INI" /etc/ly/config.ini

# Reload systemd daemon
echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

# Enable and start the ly service
echo "Enabling and starting ly service..."
sudo systemctl enable ly.service
sudo systemctl start ly.service

echo "Ly installation and configuration completed successfully!"
