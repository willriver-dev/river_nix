# Development Packages and Applications
{ pkgs, ... }:

{

  services.network-manager-applet.enable = true;
  # Packages
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
    helix
    vscode
    code-cursor

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

    postman            # Postman API testing
    bruno
    zed-editor         # Zed Editor
    nautilus

    swww
    spotify
    cmatrix
    spotdl           # Download tool
    musikcube        # TUI player
    ffmpeg
  ];
}
