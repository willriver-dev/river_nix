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
    ./swww.nix
    # Applications & Packages
    ./packages.nix

    # System Integration
    ./xdg.nix
    ./systemd.nix
    ./bash.nix
    ./cli-tools.nix
    ./theme.nix
    ./starship.nix
    # ./ca.nix
    # ./ghostty.nix
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
