# Pre-Deploy Checklist

Before deploying to a NixOS machine, verify these items:

## ✅ Completed (by AI)

- [x] Created modular structure (`nixos/` and `home/`)
- [x] Split `home.nix` into 12 separate modules
- [x] Moved system configs to `nixos/`
- [x] Updated `flake.nix` to NixOS 25.11
- [x] Updated `system.stateVersion` to 25.11
- [x] Updated `home.stateVersion` to 25.11
- [x] Updated flake input paths
- [x] Created comprehensive documentation

## ⏳ TODO (before first deploy)

### 0. Generate Hardware Configuration ⚠️

**CRITICAL:** You need `nixos/hardware-configuration.nix` before deploying!

```bash
# On target NixOS machine or from live ISO after mounting partitions:
sudo nixos-generate-config --show-hardware-config > ~/workspace/nix_river/nixos/hardware-configuration.nix

# Or see nixos/IMPORTANT.md for detailed instructions
```

### 1. Update Personal Info

```bash
# Edit home/git.nix - line 6
userEmail = "your-real-email@example.com";  # ← Change this!
```

### 2. Validate Configuration (on NixOS machine)

```bash
cd ~/workspace/nix_river

# Check flake
nix flake check

# Validate syntax
nix flake show

# Build without activating
nixos-rebuild build --flake .#nixos
```

### 3. Review Hardware Config

```bash
# Make sure nixos/hardware-configuration.nix matches your hardware
# If needed, regenerate:
sudo nixos-generate-config --show-hardware-config
```

### 4. Optional: Test in VM First

```bash
nixos-rebuild build-vm --flake .#nixos
./result/bin/run-nixos-vm
```

### 5. Deploy

```bash
# First time (from live ISO)
sudo nixos-install --flake .#nixos

# Or rebuild existing system
sudo nixos-rebuild switch --flake .#nixos
```

## 🔍 Post-Deploy Verification

After successful boot:

- [ ] Niri starts correctly
- [ ] Noctalia bar appears
- [ ] Keybindings work (`Super+Return` for terminal)
- [ ] Applications launch (`Super+D` for fuzzel)
- [ ] Network works
- [ ] Audio works (via PipeWire)
- [ ] Bluetooth works
- [ ] All packages installed (`which hx go python3 docker`)
- [ ] Git configured (`git config --list`)
- [ ] Shell aliases work (`ll`, `rebuild`)

## 🐛 Troubleshooting

### If build fails

1. Check error message carefully
2. Validate syntax: `nix flake check`
3. Check for typos in imports
4. Ensure all files exist

### If system won't boot

1. Select previous generation at boot menu
2. Check logs: `journalctl -xe`
3. Check Niri logs: `~/.local/share/niri/niri.log`

### If home-manager fails

1. Check `home/default.nix` imports
2. Ensure all imported files exist
3. Check for conflicting options

## 📚 Quick Commands

```bash
# Update everything
nix flake update
sudo nixos-rebuild switch --flake .#nixos

# Or use alias (after first boot)
update

# Rollback if needed
sudo nixos-rebuild switch --rollback

# List generations
nixos-rebuild list-generations

# Garbage collect old generations
sudo nix-collect-garbage -d
```

## 🎯 NixOS 25.11 Notes

- NetworkManager: VPN plugins not included by default (we don't use VPN)
- Docker: Auto-upgraded to 28.x (no config change needed)
- nixos-rebuild-ng: Now default (compatible with old commands)
- All other breaking changes don't affect this config

## ✨ Tips

1. Always commit changes before rebuild
2. Use `dry-build` to preview changes
3. Keep at least 2 generations for safety
4. Document custom changes in comments
5. Test new packages in `nix shell` first

---

**Ready to deploy?** Start with step 1 in the TODO section!
