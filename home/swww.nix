{ pkgs, ... }:
{
  # Script auto change wallpaper
  home.file.".local/bin/wallpaper-changer.sh" = {
    text = ''
      #!/usr/bin/env bash
      
      WALLPAPER_DIR="$HOME/Wallpapers"
      INTERVAL=300  # 5 phút (giây)
      
      # Start swww daemon nếu chưa chạy
      if ! pgrep -x swww-daemon > /dev/null; then
          swww-daemon &
          sleep 1
      fi
      
      # Load wallpaper ban đầu
      FIRST_WALL=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" \) | shuf -n 1)
      swww img "$FIRST_WALL" --transition-type wipe --transition-fps 60 --transition-duration 2
      
      # Loop auto change
      while true; do
          sleep "$INTERVAL"
          
          # Random wallpaper
          WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" \) | shuf -n 1)
          
          # Random transition effect
          TRANSITIONS=("wipe" "grow" "outer" "wave" "center")
          RANDOM_TRANS=''${TRANSITIONS[$RANDOM % ''${#TRANSITIONS[@]}]}
          
          # Change wallpaper with animation
          swww img "$WALLPAPER" \
              --transition-type "$RANDOM_TRANS" \
              --transition-fps 60 \
              --transition-duration 2 \
              --transition-pos 0.5,0.5
      done
    '';
    executable = true;
  };
  
  # Systemd service để auto-start
  systemd.user.services.wallpaper-changer = {
    Unit = {
      Description = "Auto wallpaper changer with swww";
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.bash}/bin/bash %h/.local/bin/wallpaper-changer.sh";
      Restart = "always";
      RestartSec = 10;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}