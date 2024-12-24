#!/bin/bash

# Install Zsh using sudo and pacman
echo "Installing Zsh..."
sudo pacman -S --noconfirm zsh

# Change the default shell to Zsh
echo "Changing default shell to Zsh..."
chsh -s /usr/bin/zsh

# Check if the shell was successfully changed
if [ $? -eq 0 ]; then
  echo "Default shell successfully changed to Zsh."
  echo "Please log out and log back in to apply the changes."
else
  echo "Failed to change the default shell. Please try again."
fi
