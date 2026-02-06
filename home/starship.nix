{ pkgs, ... }:
{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    
    settings = {
      # ============================================
      # FORMAT - Thứ tự hiển thị
      # ============================================
      format = "$username$hostname$directory$git_branch$git_status$nix_shell$python$rust$nodejs$golang$java$c$cmd_duration$line_break$character";
      
      # Thêm newline giữa các lệnh
      add_newline = true;
      
      # ============================================
      # CHARACTER - Prompt symbol
      # ============================================
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
        vimcmd_symbol = "[←](bold green)";
      };
      
      # ============================================
      # DIRECTORY - Current path
      # ============================================
      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
        style = "bold cyan";
        read_only = " 󰌾";
        
        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
          "Videos" = " ";
          "~" = "󰋜 ";
        };
      };
      
      # ============================================
      # GIT - Git status
      # ============================================
      git_branch = {
        symbol = " ";
        style = "bold purple";
        format = "[$symbol$branch]($style) ";
      };
      
      git_status = {
        style = "bold yellow";
        format = "([$all_status$ahead_behind]($style) )";
        
        conflicted = "🏳";
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        untracked = "?";
        stashed = "$";
        modified = "!";
        staged = "+";
        renamed = "»";
        deleted = "✘";
      };
      
      # ============================================
      # NIX SHELL - Nix environment
      # ============================================
      nix_shell = {
        symbol = " ";
        style = "bold blue";
        format = "[$symbol$state]($style) ";
        impure_msg = "";
        pure_msg = "pure";
      };
      
      # ============================================
      # PROGRAMMING LANGUAGES
      # ============================================
      
      # Python
      python = {
        symbol = " ";
        style = "yellow";
        format = "[$symbol$version]($style) ";
      };
      
      # Rust
      rust = {
        symbol = " ";
        style = "red";
        format = "[$symbol$version]($style) ";
      };
      
      # Node.js
      nodejs = {
        symbol = " ";
        style = "green";
        format = "[$symbol$version]($style) ";
      };
      
      # Go
      golang = {
        symbol = " ";
        style = "cyan";
        format = "[$symbol$version]($style) ";
      };
      
      # Java
      java = {
        symbol = " ";
        style = "red";
        format = "[$symbol$version]($style) ";
      };
      
      # C/C++
      c = {
        symbol = " ";
        style = "blue";
        format = "[$symbol$version]($style) ";
      };
      
      # ============================================
      # CMD DURATION - Command execution time
      # ============================================
      cmd_duration = {
        min_time = 2000;  # Show if command takes > 2s
        format = "took [$duration](bold yellow) ";
      };
      
      # ============================================
      # USERNAME & HOSTNAME
      # ============================================
      username = {
        style_user = "bold green";
        style_root = "bold red";
        format = "[$user]($style)";
        disabled = false;
        show_always = false;  # Only show in SSH
      };
      
      hostname = {
        ssh_only = true;
        format = "[@$hostname](bold blue) ";
        disabled = false;
      };
    };
  };
}
