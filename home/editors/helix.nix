# Helix Editor Configuration
{ ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    
    settings = {
      theme = "catppuccin_mocha";
      
      editor = {
        line-number = "relative";
        mouse = true;
        cursorline = true;
        auto-save = true;
        idle-timeout = 50;
        
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        
        indent-guides = {
          render = true;
          character = "│";
        };
        
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
      };
    };
    
    languages = {
      language-server.gopls = {
        command = "gopls";
      };
      language-server.pylsp = {
        command = "pylsp";
      };
    };
  };
}
