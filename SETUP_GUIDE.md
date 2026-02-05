# Hướng dẫn Setup Chi Tiết

## 📝 Checklist Trước Khi Deploy

- [ ] **Hardware Configuration**: Replace `hardware-configuration.nix` với config thật
- [ ] **User Info**: Cập nhật git username/email trong `home.nix`
- [ ] **Timezone**: Kiểm tra timezone trong `configuration.nix`
- [ ] **Hostname**: Đổi hostname nếu cần
- [ ] **Password**: Chuẩn bị đổi password sau khi deploy

## 🔧 Các bước thực hiện

### Bước 1: Copy Hardware Configuration

Trên NixOS system của bạn:

```bash
# Tạo hardware config mới
sudo nixos-generate-config --show-hardware-config > ~/workspace/nix_river/hardware-configuration.nix

# HOẶC copy từ system hiện tại
sudo cp /etc/nixos/hardware-configuration.nix ~/workspace/nix_river/
```

### Bước 2: Tạo Flake Lock

```bash
cd ~/workspace/nix_river
nix flake lock
```

Lệnh này sẽ:
- Download và lock tất cả inputs (nixpkgs, home-manager, niri, noctalia)
- Tạo file `flake.lock`
- Đảm bảo reproducible builds

### Bước 3: Check Syntax

```bash
nix flake check
```

Nếu có lỗi syntax, sửa lại các file `.nix` tương ứng.

### Bước 4: Test Build (Dry Run)

```bash
nix build .#nixosConfigurations.nixos.config.system.build.toplevel --dry-run
```

Lệnh này sẽ show những gì sẽ được build mà không download gì cả.

### Bước 5: Build (Không Deploy)

```bash
nix build .#nixosConfigurations.nixos.config.system.build.toplevel
```

Lệnh này sẽ:
- Download tất cả packages
- Build system configuration
- Tạo symlink `./result` pointing to system

**Lưu ý**: Build lần đầu có thể mất 30-60 phút tùy vào tốc độ mạng và máy.

### Bước 6: Deploy

#### Option A: Switch Ngay (Recommended for Testing)

```bash
sudo nixos-rebuild switch --flake ~/workspace/nix_river#nixos
```

Áp dụng config ngay lập tức. Nếu có vấn đề, có thể rollback.

#### Option B: Boot (Safer)

```bash
sudo nixos-rebuild boot --flake ~/workspace/nix_river#nixos
```

Config sẽ được apply sau khi reboot. Safer vì system hiện tại không bị ảnh hưởng.

### Bước 7: Reboot

```bash
reboot
```

### Bước 8: First Login

1. SDDM sẽ xuất hiện
2. Chọn user "river"
3. Nhập password: `nixos`
4. Chọn session "Niri" (hoặc "Niri (Wayland)")
5. Login!

### Bước 9: Post-Install

```bash
# Đổi password ngay!
passwd

# Check Noctalia
systemctl --user status noctalia-shell

# Check Niri
niri --version
niri msg version

# Open app launcher
# Press: Mod+Space
```

## 🐛 Common Issues & Fixes

### Issue: "error: path does not exist"

**Nguyên nhân**: Hardware configuration chưa được tạo hoặc sai path.

**Fix**: Đảm bảo `hardware-configuration.nix` tồn tại và có đúng filesystem UUIDs.

### Issue: "error: attribute 'niri' missing"

**Nguyên nhân**: Flake inputs chưa được fetch.

**Fix**: 
```bash
nix flake update
nix flake lock
```

### Issue: Noctalia widgets không hoạt động

**Check dependencies**:

```bash
# NetworkManager
systemctl status NetworkManager

# Bluetooth
systemctl status bluetooth

# Power Profiles
systemctl status power-profiles-daemon

# UPower
systemctl status upower
```

All services should be `active (running)`.

### Issue: Docker commands require sudo

**Fix**: Logout và login lại để group membership có hiệu lực.

```bash
# Verify groups
groups

# Should show: wheel networkmanager docker video audio
```

### Issue: Fonts không hiển thị đúng

**Rebuild font cache**:

```bash
fc-cache -fv
```

**Check fonts**:

```bash
fc-list | grep -i "jetbrains"
fc-list | grep -i "nerd"
```

## 🎯 Optimization Tips

### Tăng tốc builds

Sử dụng binary caches:

```nix
nix.settings = {
  substituters = [
    "https://cache.nixos.org"
    "https://niri.cachix.org"
    "https://nix-community.cachix.org"
  ];
  trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];
};
```

### Giảm disk usage

```bash
# Clean old generations
sudo nix-collect-garbage -d

# Optimize store
nix-store --optimise
```

### Build parallel

Sử dụng multiple cores (đã config sẵn):

```nix
nix.settings = {
  max-jobs = "auto";
  cores = 0;  # Use all cores
};
```

## 📦 Thêm Packages

### System-wide (configuration.nix)

```nix
environment.systemPackages = with pkgs; [
  # Thêm packages vào đây
  neofetch
];
```

### User-level (home.nix)

```nix
home.packages = with pkgs; [
  # Thêm packages vào đây
  spotify
  discord
];
```

Sau khi sửa, rebuild:

```bash
sudo nixos-rebuild switch --flake ~/workspace/nix_river#nixos
```

## 🔐 Security Notes

1. **Đổi initial password ngay!**: Default password `nixos` rất không an toàn
2. **SSH**: Disabled by default. Enable only if needed
3. **Firewall**: Enabled by default. Mở ports cần thiết trong `networking.firewall.allowedTCPPorts`
4. **Sudo**: Requires password by default

## 📊 System Monitoring

```bash
# System info
neofetch

# Resource usage
htop
btop

# Disk usage
duf

# Process monitoring
procs
```

## 🎨 Customization Examples

### Thay đổi Niri gaps và borders

Trong `home.nix`:

```nix
programs.niri.settings.layout = {
  gaps = 12;  # Bigger gaps
  border.width = 3;
  border.active.color = "#f38ba8";  # Catppuccin Red
};
```

### Thêm keybindings

```nix
programs.niri.settings.binds = {
  "Mod+T".action = spawn "thunderbird";
  "Mod+M".action = spawn "spotify";
};
```

### Custom Noctalia bar density

```nix
programs.noctalia-shell.settings.bar.density = "spacious";
```

---

**Happy Hacking! 🚀**
