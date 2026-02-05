# Cài NixOS Nhanh

## 1. Partition
```bash
sudo parted /dev/sda -- mklabel gpt
sudo parted /dev/sda -- mkpart ESP fat32 1MiB 512MiB
sudo parted /dev/sda -- set 1 esp on
sudo parted /dev/sda -- mkpart primary 512MiB 100%

sudo mkfs.fat -F 32 -n boot /dev/sda1
sudo mkfs.ext4 -L nixos /dev/sda2

sudo mount /dev/disk/by-label/nixos /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/disk/by-label/boot /mnt/boot
```

## 2. Clone & Install
```bash
sudo git clone https://github.com/YOUR-REPO/river_nix.git /mnt/etc/nixos
cd /mnt/etc/nixos

sudo nixos-generate-config --root /mnt
sudo mv /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/nixos/

sudo nixos-install --flake .#nixos
```

## 3. Reboot & Login
```bash
sudo reboot
```

**Login:** river / nixos

**Đổi password ngay:** `passwd`
