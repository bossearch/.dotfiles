#!/bin/bash
set -e
mv /etc/iptables/iptables.rules /etc/iptables/iptables.rules.bak
cp /home/bosse/.dotfiles/desktop/Desktop/INSTALL/install-scripts/assets/iptables_waydroid.rules /etc/iptables/iptables.rules
systemctl restart iptables
systemctl restart ip6tables
systemctl restart waydroid-container
