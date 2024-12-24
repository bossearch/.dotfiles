#!/bin/bash

# Define the base directories
firefox_source="$HOME/.dotfiles/.other/firefox"
firefox_target="$HOME/.mozilla/firefox"

# Find the exact default-release folder in source
source_folder=$(find "$firefox_source" -maxdepth 1 -type d -name "*.default-release")

# Check if the folder was found
if [ -z "$source_folder" ]; then
  echo "No default-release folder found in $firefox_source"
  exit 1
fi

# Get the exact name of the default-release folder in source
old_name=$(basename "$source_folder")

# Find the exact default-release folder in target
target_folder=$(find "$firefox_target" -maxdepth 1 -type d -name "*.default-release")

# Check if the folder was found
if [ -z "$target_folder" ]; then
  echo "No default-release folder found in $firefox_target"
  exit 1
fi

# Get the exact name of the default-release folder in target
exact_name=$(basename "$target_folder")

# Rename the local repo folder to match the default-release folder
mv "$firefox_source/$old_name" "$firefox_source/$exact_name"

# Delete conflicting files and folders in the target folder
echo "Deleting conflicting files and folders in the target folder..."
while IFS= read -r -d '' item; do
  relative_path="${item#$firefox_source/$exact_name/}" # Get relative path
  target_item="$firefox_target/$exact_name/$relative_path"
  if [ -e "$target_item" ]; then
    rm -rf "$target_item"
    echo "Deleted: $target_item"
  fi
done < <(find "$firefox_source/$exact_name" -print0)

# Change to the local repo directory
cd "$firefox_source" || exit

# Stow firefox
stow "$exact_name" -d ~/.dotfiles/.other/firefox -t ~/.mozilla/firefox/$exact_name

echo "Renaming, cleanup, and stow completed successfully."
