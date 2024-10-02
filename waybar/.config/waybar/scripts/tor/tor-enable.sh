#!/bin/sh

# Restore the original iptables rules from the backup
mv /etc/iptables/iptables.rules /etc/iptables/iptables.rules.bak

# Copy the custom iptables rules for Torification
cp /home/bosse/obsidian-vault/05\ -\ Permanent/tor-iptables.md /etc/iptables/iptables.rules

# Reload the iptables services to apply the restored rules
systemctl restart iptables
systemctl restart ip6tables

# Stop Tor service
systemctl start tor
