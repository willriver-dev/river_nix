{ pkgs, ... }:
{
  # ============================================
  # GTK THEME - Catppuccin Latte (Light)
  # ============================================
  
  gtk = {
    enable = true;
    
    theme = {
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        size = "standard";
        variant = "latte";
      };
      name = "Catppuccin-Latte-Standard-Mauve-Light";
    };
    
    iconTheme = {
      package = pkgs.tela-icon-theme;
      name = "Tela";
    };
    
    cursorTheme = {
      package = pkgs.catppuccin-cursors.latteLight;
      name = "catppuccin-latte-light-cursors";
      size = 24;
    };
    
    font = {
      name = "Inter";
      size = 10;
      package = pkgs.inter;
    };
    
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = false;
    };
    
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = false;
    };
  };
  
  # ============================================
  # QT THEME
  # ============================================
  
  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "adwaita";
    style.package = pkgs.adwaita-qt;
  };
  
  # ============================================
  # PACKAGES - CHỈ CÀI TELA, BỎ PAPIRUS
  # ============================================
  
  home.packages = with pkgs; [
    # Icon themes - CHỈ CÀI 1 THEME CHÍNH
    tela-icon-theme        # ✅ Theme chính
    # papirus-icon-theme   # ❌ BỎ - Conflict với Tela
    adwaita-icon-theme     # Fallback (built-in, không conflict)
    hicolor-icon-theme     # Base (không conflict)
    
    # Cursor themes
    catppuccin-cursors
    
    # GTK theme tools
    gnome-themes-extra
    
    # Theme utilities
    shared-mime-info
    desktop-file-utils
    
    # GTK config tool
    nwg-look

    glib                    # Cung cấp gsettings command
    gsettings-desktop-schemas  # Schemas cơ bản cho GTK
  ];
  
  # ============================================
  # XDG - Icon fallback (bỏ Papirus)
  # ============================================
  
  xdg.enable = true;
  
  xdg.dataFile."icons/default/index.theme".text = ''
    [Icon Theme]
    Name=Default
    Comment=Icon theme hierarchy
    Inherits=Tela,Tela,Adwaita,hicolor
  '';
  
  # ============================================
  # WAYLAND ENVIRONMENT VARIABLES
  # ============================================
  
  home.sessionVariables = {
    GTK_THEME = "Catppuccin-Latte-Standard-Mauve-Light";
    XCURSOR_THEME = "catppuccin-latte-light-cursors";
    XCURSOR_SIZE = "24";
    QT_QPA_PLATFORMTHEME = "gtk3";
    QT_STYLE_OVERRIDE = "adwaita";
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland,x11";
  };
  
  # ============================================
  # POINTER CURSOR CONFIG
  # ============================================
  
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.latteLight;
    name = "catppuccin-latte-light-cursors";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
