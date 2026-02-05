# VSCode Configuration
{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      golang.go
      ms-python.python
      bbenoist.nix
      jnoortheen.nix-ide
      rust-lang.rust-analyzer
    ];
  };
}
