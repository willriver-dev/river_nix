# NixOS System Configuration with Niri + Noctalia
{ config, pkgs, inputs, lib, ... }:

{
  # ============================================================================
  # BOOT & KERNEL
  # ============================================================================
  
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    
    # Use latest kernel for best Wayland support
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # ============================================================================
  # NETWORKING
  # ============================================================================
  
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;  # Required for Noctalia
    firewall = {
      enable = true;
      # Thêm ports nếu cần (VD: 8080 cho dev server)
      # allowedTCPPorts = [ 8080 ];
    };
  };

  # ============================================================================
  # LOCALE & TIME
  # ============================================================================
  
  time.timeZone = "Asia/Ho_Chi_Minh";
  
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "vi_VN.UTF-8";
      LC_IDENTIFICATION = "vi_VN.UTF-8";
      LC_MEASUREMENT = "vi_VN.UTF-8";
      LC_MONETARY = "vi_VN.UTF-8";
      LC_NAME = "vi_VN.UTF-8";
      LC_NUMERIC = "vi_VN.UTF-8";
      LC_PAPER = "vi_VN.UTF-8";
      LC_TELEPHONE = "vi_VN.UTF-8";
      LC_TIME = "vi_VN.UTF-8";
    };
  };

  # ============================================================================
  # NIX SETTINGS
  # ============================================================================
  
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      max-jobs = "auto";
      cores = 0;  # Use all available cores
      
      # Binary cache optimization with China mirrors
      substituters = [
        # China mirrors (check first for faster downloads in CN)
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        
        # Official caches (fallback)
        "https://cache.nixos.org"
        "https://niri.cachix.org"  # Niri binary cache
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      ];
    };
    
    # Garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # Allow unfree packages (for JetBrains IDEs, etc.)
  nixpkgs.config.allowUnfree = true;

  # ============================================================================
  # DESKTOP ENVIRONMENT - NIRI
  # ============================================================================
  
  # Niri compositor configured via home-manager (home/niri.nix)
  # programs.niri.enable = true;  # ← Moved to home-manager
  
  # Display Manager - greetd with tuigreet (simple & stable for Wayland)
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
        user = "greeter";
      };
    };
  };
  
  # XDG Desktop Portal (for screensharing, file picker, etc.)
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome  # For Niri screencasting
    ];
    wlr.enable = true;
  };

  # ============================================================================
  # HARDWARE & SERVICES
  # ============================================================================
  
  # Audio - PipeWire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  
  # Bluetooth (required by Noctalia)
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  
  # Power management (required by Noctalia)
  services.power-profiles-daemon.enable = true;
  
  # UPower for battery info (required by Noctalia)
  services.upower.enable = true;
  
  # Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # ============================================================================
  # VIRTUALIZATION - DOCKER
  # ============================================================================
  
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };

  # ============================================================================
  # FONTS
  # ============================================================================
  
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      # Nerd Fonts for terminal & coding (NixOS 25.11 syntax)
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
      
      # System fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      
      # Additional
      liberation_ttf
      dejavu_fonts
    ];
    
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font" ];
        sansSerif = [ "Noto Sans" ];
        serif = [ "Noto Serif" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  # ============================================================================
  # SYSTEM PACKAGES
  # ============================================================================
  
  environment.systemPackages = with pkgs; [
    # Core utilities
    vim wget curl git htop btop
    unzip zip
    
    # Wayland essentials
    wayland
    wayland-utils
    wl-clipboard
    
    # Build tools
    gcc
    gnumake
    pkg-config
    
    # Niri utilities
    fuzzel              # App launcher (Wayland native)
    mako                # Notification daemon
    swaylock            # Screen locker
    grim                # Screenshot utility
    slurp               # Region selector for screenshots
    
    # File manager
    xfce.thunar
    xfce.thunar-volman
    
    # Network tools
    networkmanagerapplet
    
    # System monitoring
    pavucontrol         # Audio control
    blueman             # Bluetooth manager
    
    # Terminal emulators (base install)
    alacritty
    kitty
  ];

  # ============================================================================
  # USERS
  # ============================================================================
  
  users.users.river = {
    isNormalUser = true;
    description = "River";
    extraGroups = [ 
      "wheel"           # sudo
      "networkmanager"  # network configuration
      "docker"          # docker access
      "video"           # video devices
      "audio"           # audio devices
    ];
    shell = pkgs.bash;
    # Set initial password (change after first login!)
    initialPassword = "nixos";
  };

  # ============================================================================
  # SECURITY & SUDO
  # ============================================================================
  
  security = {
    sudo.wheelNeedsPassword = true;
    polkit.enable = true;
    rtkit.enable = true;  # RealtimeKit for audio
  };

  # ============================================================================
  # SERVICES
  # ============================================================================
  
  services = {
    # SSH (optional, useful for remote management)
    openssh = {
      enable = false;  # Set to true if needed
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = true;
      };
    };
    
    # D-Bus
    dbus.enable = true;
    
    # Printing (optional)
    printing.enable = false;  # Set to true if needed
  };

  # ============================================================================
  # ENVIRONMENT VARIABLES
  # ============================================================================
  
  environment.sessionVariables = {
    # Wayland environment
    NIXOS_OZONE_WL = "1";  # Electron/Chromium apps use Wayland
    MOZ_ENABLE_WAYLAND = "1";  # Firefox Wayland
    
    # Qt Wayland
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    
    # Editor
    EDITOR = "hx";  # Helix
    VISUAL = "hx";
  };

  # ============================================================================
  # SYSTEM STATE VERSION
  # ============================================================================
  
  # NixOS release version for compatibility
  system.stateVersion = "25.11";
}
