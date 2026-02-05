# Git Configuration
{ ... }:

{
  programs.git = {
    enable = true;
    userName = "river";
    userEmail = "river@example.com";  # Change this!
    
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
      core.editor = "hx";
    };
    
    delta = {
      enable = true;
      options = {
        navigate = true;
        line-numbers = true;
        syntax-theme = "Catppuccin-mocha";
      };
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      gui.theme = {
        activeBorderColor = [ "#89b4fa" "bold" ];
        inactiveBorderColor = [ "#313244" ];
      };
    };
  };
}
