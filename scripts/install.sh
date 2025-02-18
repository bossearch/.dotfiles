#!/usr/bin/env bash

# Automated script to install my dotfiles credit, to `https://github.com/librephoenix/nixos-config`
# If you new to nixos i highly recommend to watch his yt channel.

set -e

HOSTNAME=$(hostname)

# Set dotfiles directory
DOTFILES=~/.dotfiles

# Clone dotfiles if the directory does not exist
if [ ! -d "$DOTFILES" ]; then
    nix-shell -p git --command "git clone --branch=nixos --single-branch https://github.com/bossearch/.dotfiles $DOTFILES"
else
    echo "Dotfiles directory already exists. Skipping clone."
fi

# Generate hardware config for new system
sudo cp /etc/nixos/hardware-configuration.nix $DOTFILES/modules/hardware-configuration.nix

# Rebuild system
sudo nixos-rebuild switch --flake $DOTFILES#$HOSTNAME;
