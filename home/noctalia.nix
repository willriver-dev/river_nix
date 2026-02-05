# Noctalia Shell Configuration
{ inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;  # Auto-start via systemd user service
    
    settings = {
      bar = {
        density = "compact";      # Options: compact, normal, spacious
        position = "bottom";      # Options: top, bottom
      };
      
      colorSchemes = {
        predefinedScheme = "Catppuccin Mocha";
        # Other options: Catppuccin Latte, Nord, Gruvbox, Dracula, Tokyo Night
      };
      
      general = {
        radiusRatio = 0.2;       # Border radius
      };
      
      # Enable widgets
      widgets = {
        battery.enable = true;
        bluetooth.enable = true;
        networkManager.enable = true;
        powerProfiles.enable = true;
        tray.enable = true;
        clock.enable = true;
      };
    };
  };
}
