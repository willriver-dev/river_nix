# Niri Compositor Configuration - DEFAULT CONFIG
{ inputs, ... }:

{
  imports = [
    inputs.niri.homeModules.niri
  ];

  # Enable Niri with default configuration
  # Niri will use its built-in defaults for keybindings, layout, etc.
  programs.niri.enable = true;
  
  # All settings are optional - Niri works great with defaults!
  # To customize later, see: https://github.com/YaLTeR/niri/wiki/Configuration:-Overview
}
