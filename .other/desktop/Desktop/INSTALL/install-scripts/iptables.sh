#!/bin/bash

# Get the directory of the current script
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

sudo rm /etc/iptables/ip6tables.rules
# Copy the custom iptables rules for Torification
sudo cp "$SCRIPT_DIR/assets/iptables.rules" /etc/iptables/iptables.rules
sudo ln -sf /etc/iptables/iptables.rules /etc/iptables/ip6tables.rules

sudo systemctl enable iptables
sudo systemctl start iptables
sudo systemctl enable ip6tables
sudo systemctl start ip6tables
