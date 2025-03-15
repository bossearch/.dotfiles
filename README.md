# Bosse's dotfiles for nixos
Hi, this is my dotfiles repo for nixos, it wont work on your computer!
I suggest you to look `old` branch instead.

# Setup Guide

## Manual Installation

Do your usual [NixOS installation](https://nixos.org/manual/nixos/stable/#ch-installation) and reboot.

## Post Install

Magic !!

```
nix-shell -p git --command "nix run --experimental-features 'nix-command flakes' github:bossearch/.dotfiles"
```
