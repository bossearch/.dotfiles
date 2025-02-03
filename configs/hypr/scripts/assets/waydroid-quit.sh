#!/bin/bash
set -e
mv /etc/iptables/iptables.rules.bak /etc/iptables/iptables.rules
systemctl restart iptables
systemctl restart ip6tables
systemctl restart waydroid-container
waydroid session stop
