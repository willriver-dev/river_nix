# ⚠️ IMPORTANT: Hardware Configuration Missing

## Before First Deploy

You need to generate `hardware-configuration.nix` on your target NixOS machine.

### Method 1: During Installation (from live ISO)

```bash
# Mount your partitions to /mnt first, then:
sudo nixos-generate-config --root /mnt

# This creates:
# /mnt/etc/nixos/hardware-configuration.nix
# /mnt/etc/nixos/configuration.nix (ignore this one)

# Copy hardware-configuration.nix to your repo:
cp /mnt/etc/nixos/hardware-configuration.nix ~/workspace/nix_river/nixos/
```

### Method 2: On Existing NixOS System

```bash
# Generate and save to repo:
sudo nixos-generate-config --show-hardware-config > ~/workspace/nix_river/nixos/hardware-configuration.nix
```

### Method 3: Manual Creation

If you already have a working NixOS system, copy your existing:

```bash
cp /etc/nixos/hardware-configuration.nix ~/workspace/nix_river/nixos/
```

## What This File Contains

- Boot loader configuration
- Filesystem mount points
- Partition UUIDs
- Kernel modules for your hardware
- CPU-specific settings
- Network interfaces

## Example Structure

See `hardware-configuration.nix.example` for reference structure.

## Security Note

⚠️ **Consider NOT committing this file to git** if it contains:
- Drive serial numbers
- Network MACs
- Other identifying information

You can add it to `.gitignore` and generate it on each machine separately.

Alternatively, use it as a template and remove sensitive parts before committing.
