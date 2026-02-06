{ pkgs, programs, ... }:
{
    programs.ghostty = {
    enable = true;
    # Catppuccin tự động apply, không cần set theme thủ công
  };
  xdg.configFile."ghostty/config".text = ''
    # Theme
    
    # Font
    font-family = Lilex Nerd Font
    font-size = 13
    
    # Window
    window-padding-x = 10
    window-padding-y = 10
    window-decoration = false
    
    # Cursor
    cursor-style = block
    
    # Shell
    shell-integration = bash
    
    # Keybindings
    keybind = ctrl+shift+t=new_tab
    keybind = ctrl+shift+w=close_tab
    keybind = ctrl+shift+n=new_window
  '';
}
