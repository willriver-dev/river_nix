# Development Packages and Applications
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # ===== PROGRAMMING LANGUAGES =====
    
    # Go
    go
    gopls
    golangci-lint
    
    # Python (FIXED)
    python3
    
    # Node.js
    nodejs
    
    # ===== EDITORS & IDEs =====
    
    # JetBrains IDEs (unfree - requires allowUnfree = true in nixos config)
    jetbrains.goland
    jetbrains.datagrip
    
    # ===== DEVELOPMENT TOOLS =====
    
    # Docker
    docker-compose
    
    # ===== SHELL UTILITIES =====
    
    # Modern CLI tools
    fzf
    ripgrep
    fd
    bat
    eza
    
    # Git tools
    gh
    
    # System tools
    btop
    
    # Network tools
    httpie
    jq
    
    # ===== BROWSERS =====
    firefox
    chromium
    
    # ===== MEDIA & UTILS =====
    
    # Image viewer
    imv
    
    # Video player
    mpv
    
    # PDF viewer
    zathura
    
    # Screenshot tools
    grim
    slurp
    
    # Screen recording
    wf-recorder
    
    # Clipboard
    wl-clipboard
    
    # ===== MISC =====
    
    # Archive tools
    unzip
    p7zip
  ];
}
