#!/bin/bash

# Install required packages
echo "Installing Git and gnome-keyring..."
sudo pacman -Syu --noconfirm git gnome-keyring libsecret

# Start the gnome-keyring daemon if it's not running
if ! pgrep -x "gnome-keyring-daemon" >/dev/null; then
  echo "Starting gnome-keyring-daemon..."
  gnome-keyring-daemon --start --components=secrets
  eval $(/usr/bin/gnome-keyring-daemon --start --components=secrets)
fi

# Configure Git to use libsecret
echo "Configuring Git to use libsecret..."
git config --global credential.helper /usr/lib/git-core/git-credential-libsecret

echo "Git and gnome-keyring setup complete!"
