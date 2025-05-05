#!/usr/bin/env bash

nmcli connection down Wired\ connection\ 1
set -e
systemctl start waydroid-container
waydroid show-full-ui

