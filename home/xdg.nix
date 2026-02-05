# XDG User Directories Configuration
{ ... }:

{
  xdg = {
    enable = true;
    
    userDirs = {
      enable = true;
      createDirectories = true;
      
      desktop = "$HOME/Desktop";
      documents = "$HOME/Documents";
      download = "$HOME/Downloads";
      music = "$HOME/Music";
      pictures = "$HOME/Pictures";
      videos = "$HOME/Videos";
      templates = "$HOME/Templates";
      publicShare = "$HOME/Public";
    };
    
    # Create Screenshots directory
    configFile."user-dirs.dirs".text = ''
      XDG_SCREENSHOTS_DIR="$HOME/Pictures/Screenshots"
    '';
  };
}
