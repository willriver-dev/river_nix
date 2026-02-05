# NixOS Configuration - Niri + Noctalia

Professional development environment with Niri compositor and Noctalia shell.

## Structure

```
.
├── flake.nix                    # Flake configuration (NixOS 25.11)
├── nixos/                       # System configuration
│   ├── configuration.nix        # Main system config
│   └── hardware-configuration.nix
└── home/                        # Home Manager configuration
    ├── default.nix              # Main imports
    ├── noctalia.nix             # Noctalia shell
    ├── niri.nix                 # Niri compositor
    ├── editors/                 # Editor configurations
    │   ├── helix.nix
    │   ├── vim.nix
    │   └── vscode.nix
    ├── terminals/               # Terminal emulators
    │   ├── alacritty.nix
    │   └── kitty.nix
    ├── shell.nix                # Bash + Starship
    ├── git.nix                  # Git + Delta + LazyGit
    ├── cli-tools.nix            # direnv, zoxide, fzf, bat, htop
    ├── packages.nix             # Development packages
    ├── xdg.nix                  # XDG directories
    └── systemd.nix              # User services
```

## Features

- **NixOS 25.11** with Flakes
- **Niri** scrollable-tiling Wayland compositor
- **Noctalia** beautiful desktop shell
- **Modular configuration** - each app/package in separate files
- Full development environment (Go, Python, Node.js, Docker)
- Modern CLI tools (fzf, ripgrep, bat, eza, zoxide)

## Quick Start

Xem file `INSTALL.md` để biết cách cài đặt.

Login: **river** / **nixos**

## Customization

### Adding a new package

Add to `home/packages.nix`:

```nix
home.packages = with pkgs; [
  # ... existing packages
  your-new-package
];
```

### Adding a new program config

1. Create `home/your-program.nix`:

```nix
{ ... }:
{
  programs.your-program = {
    enable = true;
    # ... config
  };
}
```

2. Import in `home/default.nix`:

```nix
imports = [
  # ... existing imports
  ./your-program.nix
];
```

### Disabling a module

Simply comment out or remove the import in `home/default.nix`:

```nix
imports = [
  # ./editors/vscode.nix  # Disabled
];
```

## System Details

- **Version**: NixOS 25.11
- **User**: river
- **Locale**: Asia/Ho_Chi_Minh
- **Kernel**: Latest (for Wayland)
- **Display Manager**: greetd + tuigreet (simple & stable)
- **Desktop**: Niri + Noctalia

## Key Bindings (Niri)

| Key | Action |
|-----|--------|
| `Super + Return` | Alacritty terminal |
| `Super + D` | Fuzzel (app launcher) |
| `Super + Q` | Close window |
| `Super + H/J/K/L` | Focus window (vim-style) |
| `Super + Shift + H/J/K/L` | Move window |
| `Super + 1-9` | Switch workspace |
| `Super + Shift + E` | Exit Niri |
| `Super + Space` | Noctalia launcher |
| `Super + Escape` | Noctalia control center |

See `home/niri.nix` for full keybindings.

## TODO

- [ ] First boot test
- [ ] Configure git email in `home/git.nix`
- [ ] Add custom modules in `nixos/modules/` if needed
- [ ] Setup secrets management (sops-nix, agenix)

## Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Niri Documentation](https://yalter.github.io/niri/)
- [Noctalia Documentation](https://docs.noctalia.dev/)

## License

MIT
