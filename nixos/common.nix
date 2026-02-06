# nixos/common.nix
{ config, pkgs, lib, ... }:

# let
#   companyCA =
#     if builtins.pathExists "/etc/ssl/my-ca/myca.crt" then
#       pkgs.runCommand "company-ca.pem" {} ''
#         cp /etc/ssl/my-ca/myca.crt $out
#       ''
#     else
#       null;
# in
{
  # ... các option khác ...
    security.pki.certificateFiles = [
    ../certs/vingroup.crt
  ];

  nix.settings.ssl-cert-file = "/etc/ssl/certs/ca-bundle.crt";
  # security.pki.certificateFiles =
  #   builtins.filter (x: x != null) [
  #     companyCA
  #   ];

  # nix.settings.ssl-cert-file = "/etc/ssl/certs/ca-bundle.crt";
  services.flatpak.enable = true;
  
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
    config.common = {
      default = [ "gtk" "wlr" ];
      "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
    };
  };

   # Cho phép chạy binaries dynamically linked thông thường
  programs.nix-ld.enable = true;
  
  # Thêm các libs cần thiết cho JetBrains
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    fuse3
    icu
    nss
    openssl
    curl
    expat
    xorg.libX11
    xorg.libXext
    xorg.libXi
    xorg.libXrender
    xorg.libXtst
  ];
}
