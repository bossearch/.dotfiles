#!/bin/bash

# Path to the Timeshift configuration file
CONFIG_FILE="/etc/timeshift/timeshift.json"

# Check if the script is run with sudo
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or use sudo."
  exit 1
fi

# Backup the original configuration file
cp "$CONFIG_FILE" "$CONFIG_FILE.bak"
echo "Backup created: $CONFIG_FILE.bak"

# Update the 'include_btrfs_home_for_backup' setting
sed -i 's/"include_btrfs_home_for_backup" : "true"/"include_btrfs_home_for_backup" : "false"/' "$CONFIG_FILE"

# Verify the change
if grep -q '"include_btrfs_home_for_backup" : "false"' "$CONFIG_FILE"; then
  echo "Successfully updated Timeshift to exclude /home from backups."
else
  echo "Failed to update the configuration. Please check the file manually."
  exit 1
fi

# Show a summary
echo "Current configuration for 'include_btrfs_home_for_backup':"
grep '"include_btrfs_home_for_backup"' "$CONFIG_FILE"

# Optional: Run Timeshift check to confirm
echo "Running Timeshift check..."
sudo timeshift --check
