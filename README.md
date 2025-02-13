# Bosse's dotfiles for nixos
Hi, this is my dotfiles repo for nixos, it wont work on your computer!
I suggest you to use main branch instead.

## Setup Guide
- Format the USB drive with the latest nixOS minimal setup.
- You should restart the computer, enter the BIOS/UEFI, and boot from the USB.
- and do this.
```sh
sudo -i

#partitioning
cfdisk

#formatting
mkfs.ext4 -L nixos /dev/...
mkfs.fat -F 32 -n boot /dev/...
mkswap /dev/...

#mounting
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount -o umask=077 /dev/.../boot /mnt/boot
swapon /dev/...

#installing
nixos-generate-config --root /mnt
nano /mnt/etc/nixos/configuration.nix #IMPORTANT set boot, hostname & user

nixos-install
#reboot
#login
nix-shell -p git --command "nix run --experimental-features='nix-command flakes' github:bossearch/.dotfiles?ref=nixos"
```
