#!/usr/bin/env bash

# Automated script to install my dotfiles credit, to `https://github.com/librephoenix/nixos-config`
# If you new to nixos i highly recommend to watch his yt channel.

set -e

HOSTNAME=$(hostname)

# Clone dotfiles
if [ $# -gt 0 ]
  then
    DOTFILES=$1
  else
    DOTFILES=~/.dotfiles
fi

nix-shell -p git --command "git clone --branch=nixos --single-branch https://github.com/bossearch/.dotfiles $DOTFILES"

# Generate hardware config for new system
sudo nixos-generate-config --show-hardware-config > $DOTFILES/modules/hardware-configuration.nix

# Rebuild system
sudo nixos-rebuild switch --flake $DOTFILES#$HOSTNAME;
