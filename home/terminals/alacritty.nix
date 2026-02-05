# Alacritty Terminal Configuration
{ ... }:

{
  programs.alacritty = {
    enable = true;
    
    settings = {
      window = {
        opacity = 0.9;
        padding = {
          x = 10;
          y = 10;
        };
      };
      
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        size = 12.0;
      };
      
      colors = {
        primary = {
          background = "#1e1e2e";  # Catppuccin Mocha
          foreground = "#cdd6f4";
        };
      };
    };
  };
}
