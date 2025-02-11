#!/usr/bin/env bash
#
# original gist = https://gist.github.com/0atman/1a5133b842f929ba4c1e195ee67599d5
#
set -e

# Get the hostname
HOSTNAME=$(hostname)

# cd to your config dir
pushd ~/.dotfiles > /dev/null

# Check for arguments
if [[ "$1" == "-switch" ]]; then
    REBUILD_CMD="switch"
elif [[ "$1" == "-boot" ]]; then
    REBUILD_CMD="boot"
elif [[ "$1" == "-test" ]]; then
    REBUILD_CMD="test"
else
    echo -e "rebuild -<\e[1;33moptions\e[0m> = nixos-rebuild <\e[1;33moptions\e[0m> --flake .#hostname\n"
    echo -e "-\e[1;33mswitch\e[0m  Build and activate the new configuration, and make it the boot default.\n"
    echo -e "-\e[1;33mboot\e[0m    Build the new configuration and make it the boot default \
(as with nixos-rebuild switch),\n         but do not activate it. That is, the system continues \
to run the previous configuration until the next reboot.\n"
    echo -e "-\e[1;33mtest\e[0m    Build and activate the new configuration, but do not add it to the GRUB boot menu.\n\
         Thus, if you reboot the system  (or if it crashes), you will automatically revert to the default configuration \n\
         (i.e. the configuration resulting from the last call to nixos-rebuild switch or nixos-rebuild boot).\n"
    echo -e "by default this scripts will go to my dotfile directory, which is ~/.dotfiles"
    popd > /dev/null
    exit 0
fi

# Early return if no changes were detected (thanks @singiamtel!)
if git diff --quiet '*.nix'; then
    echo "No changes detected, exiting."
    popd > /dev/null
    exit 0
fi

# Show your changes
git diff -U0 --no-prefix '*.nix' | rg '^(?:diff --git |(?:\+[^+]|-[^-]))' | sed -E \
  -e 's/^(diff --git .*)/\n\x1b[1m\1\x1b[0m/' \
  -e 's/^(\+)(.*)/\x1b[32m+\2\x1b[0m/' \
  -e 's/^(-)(.*)/\x1b[31m-\2\x1b[0m/'

echo ""
git status --short '*.nix'
# Stage all changes
git add .

echo ""
trap 'git reset -q; echo -e "\nAborted by user."; exit 1' SIGINT
read -p "Are you sure you want to proceed? (y/N): " confirm
confirm="${confirm:-y}"
if [[ ! "$confirm" =~ ^[yY]$ ]]; then
    git reset -q
    echo "Aborted."
    popd > /dev/null
    exit 1
fi

echo ""
echo -e "NixOS Rebuilding for host: \e[1m$HOSTNAME\e[0m (mode: \e[33m$REBUILD_CMD\e[0m)"

# Option to see log or not (thanks @JustCoderDev)
if sudo nixos-rebuild "$REBUILD_CMD" --flake ".#$HOSTNAME" &>.nixos.log; then
    notify-send -e "NixOS Rebuild ($REBUILD_CMD)" "Done" --icon=software-update-available
else
    notify-send -e "NixOS Rebuild ($REBUILD_CMD)" "Error" --icon=software-update-urgent --urgency=critical

    git reset -q

    echo ""
    cat .nixos.log | grep --color error
    echo ""

    if read -p "Open log? (y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
        nvim .nixos.log
    fi

    popd > /dev/null
    exit 1
fi
