# Migration Guide - Modular Structure + NixOS 25.11

## What Changed

### 1. Directory Structure

**Before:**
```
.
├── flake.nix
├── configuration.nix
├── hardware-configuration.nix
└── home.nix (661 lines)
```

**After:**
```
.
├── flake.nix
├── nixos/
│   ├── configuration.nix
│   └── hardware-configuration.nix
└── home/
    ├── default.nix
    ├── noctalia.nix
    ├── niri.nix
    ├── editors/ (3 files)
    ├── terminals/ (2 files)
    ├── shell.nix
    ├── git.nix
    ├── cli-tools.nix
    ├── packages.nix
    ├── xdg.nix
    └── systemd.nix
```

### 2. Version Upgrade

- **nixpkgs**: `nixos-unstable` → `nixos-25.11`
- **system.stateVersion**: `25.05` → `25.11`
- **home.stateVersion**: `25.05` → `25.11`

### 3. Modular Configuration

Each domain now has its own file:

| Old (home.nix) | New Location |
|----------------|--------------|
| Noctalia config | `home/noctalia.nix` |
| Niri config | `home/niri.nix` |
| Helix/Vim/VSCode | `home/editors/*.nix` |
| Alacritty/Kitty | `home/terminals/*.nix` |
| Bash + Starship | `home/shell.nix` |
| Git + Delta + LazyGit | `home/git.nix` |
| CLI tools (direnv, fzf, etc) | `home/cli-tools.nix` |
| All packages | `home/packages.nix` |
| XDG directories | `home/xdg.nix` |
| Systemd user services | `home/systemd.nix` |

## Benefits

1. **Easier to maintain**: Each app/package in its own file
2. **Easy to enable/disable**: Comment out import in `home/default.nix`
3. **Better organization**: Clear separation of concerns
4. **Scalable**: Easy to add new modules
5. **Reusable**: Modules can be shared across configs
6. **Latest stable**: NixOS 25.11 with all new features

## NixOS 25.11 Breaking Changes (Relevant to This Config)

### ✅ Already Handled

- **NetworkManager VPN plugins**: Not using VPN, no action needed
- **Docker 28.x**: Will update automatically, config doesn't pin version
- **nixos-rebuild-ng**: New default, compatible with old usage

### ❌ Not Applicable

- **GNOME 49**: Using Niri, not GNOME
- **LXD removal**: Not using LXD
- **Postfix changes**: Not using mail server
- **River compositor**: Not using River (using Niri)

## Testing the New Configuration

### 1. Validate Flake

```bash
cd ~/workspace/nix_river
nix flake check
```

### 2. Build (without activating)

```bash
# Build system config
nixos-rebuild build --flake .#nixos

# Check what would change
nixos-rebuild dry-build --flake .#nixos
```

### 3. Test in VM (optional)

```bash
nixos-rebuild build-vm --flake .#nixos
./result/bin/run-nixos-vm
```

### 4. Apply Configuration

```bash
# Apply system config
sudo nixos-rebuild switch --flake .#nixos

# Home-manager will rebuild automatically via NixOS module
```

## Rollback (if needed)

If something goes wrong:

```bash
# Rollback to previous generation
sudo nixos-rebuild switch --rollback

# Or select generation at boot (GRUB/systemd-boot menu)
```

## Next Steps

1. ✅ Structure migrated
2. ✅ Version upgraded to 25.11
3. ⏳ Test build (you need to do this)
4. ⏳ Update git email in `home/git.nix`
5. ⏳ First boot test
6. ⏳ Fine-tune configs as needed

## Questions?

- Check `README.md` for usage guide
- Check `SETUP_GUIDE.md` for installation instructions
- Read NixOS 25.11 release notes for full changelog
