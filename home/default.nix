# Home Manager Configuration for River
{ config, pkgs, inputs, lib, ... }:

{
  # ============================================================================
  # IMPORTS - Modular Configuration
  # ============================================================================
  
  imports = [
    # Desktop Environment
    ./noctalia.nix
    ./niri.nix
    
    # Editors
    ./editors/helix.nix
    ./editors/vim.nix
    ./editors/vscode.nix
    
    # Terminals
    ./terminals/alacritty.nix
    ./terminals/kitty.nix
    
    # Shell & Tools
    ./shell.nix
    ./git.nix
    ./cli-tools.nix
    
    # Applications & Packages
    ./packages.nix
    
    # System Integration
    ./xdg.nix
    ./systemd.nix
  ];

  # ============================================================================
  # HOME MANAGER SETTINGS
  # ============================================================================
  
  home = {
    username = "river";
    homeDirectory = "/home/river";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;
}
