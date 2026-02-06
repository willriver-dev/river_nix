{ pkgs, ... }:
{
  programs.bash = {
    enable = true;
    
    # ============================================
    # ALIASES
    # ============================================
    shellAliases = {
      # Basic
      ".." = "cd ..";
      "..." = "cd ../..";
      ls = "eza --icons";
      ll = "eza -la --icons --git";
      tree = "eza --tree --icons";
      grep = "rg";
      find = "fd";
      # Modern replacements
      cat = "bat";           # Use bat instead of cat
      
      # NixOS
      rebuild = "sudo nixos-rebuild switch --flake ~/river_nix#nixos";
      update = "cd ~/river_nix && nix flake update && sudo nixos-rebuild switch --flake .#nixos";
      
      # Git
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
    };
    
    # ============================================
    # HISTORY
    # ============================================
    historyControl = [ "ignoredups" "ignorespace" ];
    historySize = 10000;
    historyFileSize = 20000;
    historyIgnore = [ "ls" "cd" "exit" ];
    
    # ============================================
    # SHELL OPTIONS
    # ============================================
    shellOptions = [
      "histappend"
      "checkwinsize"
      "extglob"
      "globstar"
      "checkjobs"
    ];
    
    # ============================================
    # ENVIRONMENT VARIABLES
    # ============================================
    sessionVariables = {
      EDITOR = "hx";
      VISUAL = "hx";
      PAGER = "bat";  # Use bat as pager
    };
    
    # ============================================
    # CUSTOM BASH CODE
    # ============================================
    bashrcExtra = ''
      # Custom prompt (if not using starship)
      
      # Functions
      mkcd() {
          mkdir -p "$1" && cd "$1"
      }
      
      extract() {
          if [ -f "$1" ]; then
              case "$1" in
                  *.tar.bz2)   tar xjf "$1"    ;;
                  *.tar.gz)    tar xzf "$1"    ;;
                  *.bz2)       bunzip2 "$1"    ;;
                  *.rar)       unrar x "$1"    ;;
                  *.gz)        gunzip "$1"     ;;
                  *.tar)       tar xf "$1"     ;;
                  *.tbz2)      tar xjf "$1"    ;;
                  *.tgz)       tar xzf "$1"    ;;
                  *.zip)       unzip "$1"      ;;
                  *.Z)         uncompress "$1" ;;
                  *.7z)        7z x "$1"       ;;
                  *)           echo "'$1' cannot be extracted" ;;
              esac
          else
              echo "'$1' is not a valid file"
          fi
      }
      
      # Nix helpers
      nix-search() {
          nix search nixpkgs "$@"
      }
      
      # Source local overrides
      if [ -f ~/.bashrc.local ]; then
          source ~/.bashrc.local
      fi
    '';
  };
  
  # ============================================
  # FZF - Fuzzy Finder
  # ============================================
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    
    # Dracula Light Theme
    colors = {
      bg = "#F8F8F2";
      "bg+" = "#FFFFFF";
      fg = "#282A36";
      "fg+" = "#282A36";
      hl = "#BD93F9";
      "hl+" = "#BD93F9";
      info = "#6272A4";
      prompt = "#50FA7B";
      pointer = "#FF79C6";
      marker = "#FFB86C";
      spinner = "#8BE9FD";
      header = "#6272A4";
    };
    
    defaultCommand = "fd --type f --hidden --exclude .git";
    defaultOptions = [
      "--height 40%"
      "--border"
      "--layout=reverse"
    ];
    
    changeDirWidgetCommand = "fd --type d --hidden --exclude .git";
    fileWidgetCommand = "fd --type f --hidden --exclude .git";
  };
  
  # ============================================
  # ZOXIDE - Smart CD
  # ============================================
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    
    # Options
    options = [
      "--cmd cd"  # Replace cd command with zoxide
    ];
  };
  
  # ============================================
  # DIRENV - Auto Environment Loading
  # ============================================
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
    
    # Silence direnv output
    config = {
      global = {
        warn_timeout = "5m";
      };
    };
  };
}
