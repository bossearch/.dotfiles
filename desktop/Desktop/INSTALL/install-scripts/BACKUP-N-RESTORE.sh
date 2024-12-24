#!/bin/bash

# Backup files and directories
declare -A BACKUP_ITEMS=(
  ["$HOME/.local/share/zoxide"]="$HOME/.dotfiles/other/zoxide"
  #  ["$HOME/.config/some_other_config"]="$HOME/.dotfiles/other/some_other_config"
  #  ["$HOME/Documents/important_file.txt"]="$HOME/.dotfiles/other/documents/important_file.txt"
)

# Function to perform backup
backup_files() {
  echo "Starting backup process..."
  for SRC in "${!BACKUP_ITEMS[@]}"; do
    DEST="${BACKUP_ITEMS[$SRC]}"
    mkdir -p "$(dirname "$DEST")" # Ensure destination directory exists
    cp -r "$SRC" "$DEST"          # Copy the files recursively
    echo "Backed up $SRC to $DEST"
  done

  # Navigate to the dotfiles repo directory
  cd "$REPO_DIR" || exit

  # Add changes to git, commit, and push
  git add .
  git commit -m "more adjustment"
  git push

  echo "Backup completed and changes pushed to the remote repository."
}

# Function to perform restore
restore_files() {
  echo "Starting restore process..."
  for DEST in "${!BACKUP_ITEMS[@]}"; do
    SRC="${BACKUP_ITEMS[$DEST]}"
    mkdir -p "$(dirname "$DEST")" # Ensure destination directory exists
    cp -r "$SRC" "$DEST"          # Restore the files recursively
    echo "Restored $SRC to $DEST"
  done
  echo "Restore completed."
}

# Ask the user if they want to backup or restore
read -rp "Do you want to backup or restore files? (b/r): " CHOICE

# Define the repository directory
REPO_DIR="$HOME/.dotfiles"

# Execute based on user choice
if [[ "$CHOICE" == "b" ]]; then
  backup_files
elif [[ "$CHOICE" == "r" ]]; then
  restore_files
else
  echo "Invalid choice! Please select 'b' for backup or 'r' for restore."
  exit 1
fi
