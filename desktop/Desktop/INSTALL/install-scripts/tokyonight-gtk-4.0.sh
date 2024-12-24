#!/bin/bash

### This is a script to apply tokyonight-gtk-theme-git aur to gtk-4.0 ###

# Define source and target directories
SOURCE_DIR="/usr/share/themes/Tokyonight-Dark/gtk-4.0"
TARGET_DIR="$HOME/.config/gtk-4.0"

# Create the target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Copy the files
cp -r "$SOURCE_DIR/assets" "$TARGET_DIR"
cp "$SOURCE_DIR/gtk.css" "$TARGET_DIR"
cp "$SOURCE_DIR/gtk-dark.css" "$TARGET_DIR"

echo "Files copied to $TARGET_DIR"
