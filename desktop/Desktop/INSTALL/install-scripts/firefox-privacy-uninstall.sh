#!/bin/bash

# Change directory to the cloned repository
cd FireFox-Privacy-Script || {
  echo "Directory not found. Please clone the repository first."
  exit 1
}

# Run the uninstallation script
sudo bash ./sos-firefoxprivacy.sh --uninstall
