# CLI Tools Configuration
{ ... }:

{
  # direnv - automatic environment switching
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # zoxide - smart cd
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

 # ============================================
  # HTOP - System Monitor
  # ============================================
  programs.htop = {
    enable = true;
    
    settings = {
      # Display
      tree_view = true;
      show_program_path = false;
      hide_kernel_threads = true;
      hide_userland_threads = false;
      
      # Meters
      left_meters = [ "AllCPUs" "Memory" "Swap" ];
      left_meter_modes = [ 1 1 1 ];  # 1=bar, 2=text, 3=graph
      
      right_meters = [ "Tasks" "LoadAverage" "Uptime" ];
      right_meter_modes = [ 2 2 2 ];
      
      # Colors
      highlight_base_name = true;
      color_scheme = 0;  # 0-6 for different color schemes
      
      # Sorting
      sort_key = "PERCENT_CPU";
      sort_direction = -1;  # -1=descending, 1=ascending
    };
  };
  
  # ============================================
  # EZA - Better ls (optional)
  # ============================================
  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
    
    # Icons (requires Nerd Font)
    icons = "auto";  # ✅ SỬA ĐÂY - Đổi từ true sang "auto"
    git = true;
  };

  xdg.configFile."ncspot/config.toml".text = ''
  [theme]
  primary = "#c4a7e7"
  secondary = "#ebbcba"
  title = "#e0def4"
  playing = "#31748f"
  playing_selected = "#9ccfd8"
  playing_bg = "#26233a"
  highlight = "#c4a7e7"
  highlight_bg = "#393552"
  error = "#eb6f92"
  error_bg = "#393552"
  statusbar = "#e0def4"
  statusbar_progress = "#31748f"
  statusbar_bg = "#191724"
  cmdline = "#e0def4"
  cmdline_bg = "#26233a"
  
  [keybindings]
  "Shift+p" = "playpause"
  "Shift+n" = "next"
  "Shift+b" = "previous"
'';

}
