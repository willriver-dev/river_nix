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

  # fzf - fuzzy finder
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  # bat - better cat
  programs.bat = {
    enable = true;
    config = {
      theme = "Catppuccin-mocha";
    };
  };

  # htop - system monitor
  programs.htop = {
    enable = true;
    settings = {
      tree_view = true;
      show_program_path = false;
    };
  };
}
