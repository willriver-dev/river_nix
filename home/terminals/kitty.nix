# Kitty Terminal Configuration
{ ... }:

{
  programs.kitty = {
    enable = true;
    
    settings = {
      font_family = "JetBrainsMono Nerd Font";
      font_size = 12;
      
      background_opacity = "0.9";
      
      # Catppuccin Mocha theme
      foreground = "#CDD6F4";
      background = "#1E1E2E";
      
      # Tab bar
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
    };
  };
}
