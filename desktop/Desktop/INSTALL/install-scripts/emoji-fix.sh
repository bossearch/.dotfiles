#!/bin/bash

# Get the directory of the current script
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

# Step 1: Copy 75-noto-color-emoji configuration
echo "Copying emoji configuration..."
sudo cp "$SCRIPT_DIR/assets/75-noto-color-emoji.conf" /etc/fonts/conf.d/75-noto-color-emoji.conf

echo "Emoji Fixed"
