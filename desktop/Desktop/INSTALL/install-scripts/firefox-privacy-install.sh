#!/bin/bash

# Clone the repository
git clone https://github.com/simeononsecurity/FireFox-Privacy-Script

# Change directory to the cloned repository
cd FireFox-Privacy-Script || {
  echo "Failed to change directory"
  exit 1
}

# Run the installation script
sudo bash ./sos-firefoxprivacy.sh
