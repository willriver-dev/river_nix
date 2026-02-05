# Development Packages and Applications
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # ===== PROGRAMMING LANGUAGES =====
    
    # Go
    go
    gopls
    golangci-lint
    gotools
    go-migrate
    
    # Python
    python3
    python3Packages.pip
    python3Packages.poetry
    python3Packages.virtualenv
    python3Packages.pylsp-mypy
    ruff
    
    # Node.js
    nodejs_22
    nodePackages.npm
    nodePackages.yarn
    nodePackages.pnpm
    nodePackages.typescript
    nodePackages.typescript-language-server
    
    # ===== EDITORS & IDEs =====
    
    # Text editors
    zed-editor
    
    # JetBrains IDEs (unfree)
    jetbrains.datagrip
    jetbrains.goland
    
    # ===== DEVELOPMENT TOOLS =====
    
    # Docker & Containers
    docker-compose
    
    # API Testing
    insomnia
    postman
    
    # Database tools
    postgresql
    mysql80
    redis
    
    # ===== SHELL UTILITIES =====
    
    # Modern CLI tools
    fzf              # Fuzzy finder
    ripgrep          # Better grep
    fd               # Better find
    bat              # Better cat
    eza              # Better ls
    zoxide           # Smart cd
    direnv           # Per-directory environments
    
    # Git tools
    gh               # GitHub CLI
    git-delta        # Better git diff
    
    # System tools
    btop             # System monitor
    dust             # Better du
    duf              # Better df
    procs            # Better ps
    
    # Network tools
    httpie           # HTTP client
    jq               # JSON processor
    
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
    
    # Screenshot tools (already in system packages, but listing here)
    grim
    slurp
    
    # Screen recording
    wf-recorder
    
    # Clipboard manager
    cliphist
    
    # Color picker
    hyprpicker
    
    # ===== MISC =====
    
    # Brightness control
    brightnessctl
    
    # Archive tools
    unzip
    unrar
    p7zip
    
    # Fonts preview
    font-manager
  ];
}
