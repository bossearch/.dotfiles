#!/bin/sh

# Restore the original iptables rules from the backup
mv /etc/iptables/iptables.rules.bak /etc/iptables/iptables.rules

# Stop Tor service
systemctl stop tor

# Reload the iptables services to apply the restored rules
systemctl restart iptables
systemctl restart ip6tables
