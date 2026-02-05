# Shell Configuration (Bash + Starship)
{ ... }:

{
  programs.bash = {
    enable = true;
    
    shellAliases = {
      # System
      rebuild = "sudo nixos-rebuild switch --flake ~/workspace/nix_river#nixos";
      update = "cd ~/workspace/nix_river && nix flake update && sudo nixos-rebuild switch --flake .#nixos";
      
      # Git
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline --graph";
      
      # Docker
      d = "docker";
      dc = "docker-compose";
      
      # Tools
      cat = "bat";
      ls = "eza --icons";
      ll = "eza -la --icons";
      tree = "eza --tree --icons";
      
      # Navigation
      ".." = "cd ..";
      "..." = "cd ../..";
    };
    
    initExtra = ''
      # Starship prompt
      eval "$(starship init bash)"
      
      # Custom environment
      export EDITOR=hx
      export VISUAL=hx
    '';
  };

  # Starship prompt
  programs.starship = {
    enable = true;
    
    settings = {
      add_newline = true;
      
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      
      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
      };
    };
  };
}
