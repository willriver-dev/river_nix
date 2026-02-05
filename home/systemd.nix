# Systemd User Services and Home Activation
{ lib, ... }:

{
  systemd.user.startServices = "sd-switch";

  # Create Screenshots directory at activation
  home.activation.createScreenshotsDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p ~/Pictures/Screenshots
  '';
}
