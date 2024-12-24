#!/bin/bash

# Get the directory of the current script
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

# Step 1: Install dnscrypt-proxy
echo "Installing dnscrypt-proxy..."
sudo pacman -S --noconfirm dnscrypt-proxy

# Step 2: Copy dnscrypt-proxy configuration
echo "Copying dnscrypt-proxy configuration..."
sudo cp "$SCRIPT_DIR/assets/dnscrypt-proxy.toml" /etc/dnscrypt-proxy/dnscrypt-proxy.toml

# Step 3: Backup and replace /etc/resolv.conf
echo "Backing up and replacing /etc/resolv.conf..."
sudo cp /etc/resolv.conf /etc/resolv.conf.backup
sudo cp "$SCRIPT_DIR/assets/resolv.conf" /etc/resolv.conf

# Step 4: Lock /etc/resolv.conf to prevent changes
echo "Locking /etc/resolv.conf to prevent changes..."
sudo chattr +i /etc/resolv.conf

# Step 5: Enable and start dnscrypt-proxy service
echo "Enabling and starting dnscrypt-proxy service..."
sudo systemctl enable --now dnscrypt-proxy.service

# Step 6: Open browser to verify DNS is working
echo "Opening browser for DNS leak test..."
xdg-open "https://one.one.one.one/help/" &>/dev/null
xdg-open "https://www.dnsleaktest.com/" &>/dev/null

echo "DNSCrypt-Proxy is configured and running!"
