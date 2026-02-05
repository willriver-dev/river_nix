# Niri Compositor Configuration
{ config, inputs, ... }:

{
  imports = [
    inputs.niri.homeModules.niri
  ];

  programs.niri = {
    enable = true;
    
    settings = {
      # Input configuration
      input = {
        keyboard.xkb = {
          layout = "us";
        };
        
        touchpad = {
          tap = true;
          natural-scroll = true;
          dwt = true;  # Disable while typing
          accel-profile = "adaptive";
        };
        
        mouse = {
          accel-profile = "flat";
          accel-speed = 0.0;
        };
      };

      # Layout configuration
      layout = {
        gaps = 8;
        
        border = {
          enable = true;
          width = 2;
          active.color = "#89b4fa";      # Catppuccin Blue
          inactive.color = "#313244";    # Catppuccin Surface0
        };
        
        preset-column-widths = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
        ];
        
        default-column-width = { proportion = 0.5; };
      };

      # Programs to spawn at startup
      spawn-at-startup = [
        # Don't spawn Noctalia here - systemd handles it via programs.noctalia-shell.systemd.enable
        { command = ["mako"]; }  # Notification daemon
      ];

      # Keybindings
      binds = with config.lib.niri.actions; {
        # ===== TERMINALS =====
        "Mod+Return".action = spawn "alacritty";
        "Mod+Shift+Return".action = spawn "kitty";
        "Mod+Alt+Return".action = spawn "ghostty";
        
        # ===== APPLICATIONS =====
        "Mod+D".action = spawn "fuzzel";
        "Mod+E".action = spawn "thunar";
        "Mod+B".action = spawn "firefox";
        
        # ===== NOCTALIA IPC CONTROLS =====
        "Mod+Space".action = spawn "noctalia-shell" "ipc" "call" "launcher" "toggle";
        "Mod+Escape".action = spawn "noctalia-shell" "ipc" "call" "controlCenter" "toggle";
        "Mod+Shift+L".action = spawn "noctalia-shell" "ipc" "call" "lockScreen" "lock";
        
        # ===== WINDOW MANAGEMENT =====
        "Mod+Q".action = close-window;
        
        # Focus
        "Mod+Left".action = focus-column-left;
        "Mod+Right".action = focus-column-right;
        "Mod+Up".action = focus-window-up;
        "Mod+Down".action = focus-window-down;
        "Mod+H".action = focus-column-left;
        "Mod+L".action = focus-column-right;
        "Mod+K".action = focus-window-up;
        "Mod+J".action = focus-window-down;
        
        # Move windows
        "Mod+Shift+Left".action = move-column-left;
        "Mod+Shift+Right".action = move-column-right;
        "Mod+Shift+Up".action = move-window-up;
        "Mod+Shift+Down".action = move-window-down;
        "Mod+Shift+H".action = move-column-left;
        "Mod+Shift+L".action = move-column-right;
        "Mod+Shift+K".action = move-window-up;
        "Mod+Shift+J".action = move-window-down;
        
        # Window sizing
        "Mod+R".action = switch-preset-column-width;
        "Mod+F".action = maximize-column;
        "Mod+Shift+F".action = fullscreen-window;
        "Mod+C".action = center-column;
        
        # Resize
        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Equal".action = set-column-width "+10%";
        "Mod+Shift+Minus".action = set-window-height "-10%";
        "Mod+Shift+Equal".action = set-window-height "+10%";
        
        # ===== WORKSPACES =====
        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;
        "Mod+6".action = focus-workspace 6;
        "Mod+7".action = focus-workspace 7;
        "Mod+8".action = focus-workspace 8;
        "Mod+9".action = focus-workspace 9;
        
        # Move to workspace
        "Mod+Shift+1".action = move-column-to-workspace 1;
        "Mod+Shift+2".action = move-column-to-workspace 2;
        "Mod+Shift+3".action = move-column-to-workspace 3;
        "Mod+Shift+4".action = move-column-to-workspace 4;
        "Mod+Shift+5".action = move-column-to-workspace 5;
        "Mod+Shift+6".action = move-column-to-workspace 6;
        "Mod+Shift+7".action = move-column-to-workspace 7;
        "Mod+Shift+8".action = move-column-to-workspace 8;
        "Mod+Shift+9".action = move-column-to-workspace 9;
        
        # Workspace navigation
        "Mod+Page_Down".action = focus-workspace-down;
        "Mod+Page_Up".action = focus-workspace-up;
        "Mod+Ctrl+Down".action = move-column-to-workspace-down;
        "Mod+Ctrl+Up".action = move-column-to-workspace-up;
        
        # ===== MONITORS =====
        "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
        "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;
        
        # ===== SCREENSHOTS =====
        "Print".action = spawn "grim" "-g" "$(slurp)" "$(xdg-user-dir PICTURES)/screenshot-$(date +%Y%m%d-%H%M%S).png";
        "Shift+Print".action = spawn "grim" "$(xdg-user-dir PICTURES)/screenshot-$(date +%Y%m%d-%H%M%S).png";
        
        # ===== SYSTEM =====
        "Mod+Shift+E".action = quit;
        "Mod+Shift+P".action = power-off-monitors;
        
        # Volume (if not handled by Noctalia)
        "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05+";
        "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05-";
        "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
        
        # Brightness
        "XF86MonBrightnessUp".action = spawn "brightnessctl" "set" "+5%";
        "XF86MonBrightnessDown".action = spawn "brightnessctl" "set" "5%-";
      };

      # Screenshot path
      screenshot-path = "~/Pictures/Screenshots/screenshot_%Y-%m-%d_%H-%M-%S.png";
      
      # Animations
      animations = {
        enable = true;
        slowdown = 1.0;
      };
      
      # Cursor
      cursor = {
        size = 24;
        theme = "Adwaita";
      };
      
      # Environment variables for Niri session
      environment = {
        DISPLAY = ":0";
      };
    };
  };
}
