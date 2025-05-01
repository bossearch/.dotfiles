#!/usr/bin/env bash

set -e
systemctl start waydroid-container
nmcli connection down Wired\ connection\ 1
