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
        position = "top";      # Options: top, bottom
        type = "floating";
      };
      
      colorSchemes = {
        predefinedScheme = "Catppuccin Mocha";
        # Other options: Catppuccin Latte, Nord, Gruvbox, Dracula, Tokyo Night
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

      wallpaper = {
      enabled = false;  # Tắt wallpaper management
    };
    };
  };
}
