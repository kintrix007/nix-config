{ config, pkgs, ... }:

let
  gs-connect-ports = pkgs.lib.range 1714 1764;
in
{
  environment.systemPackages = with pkgs.gnomeExtensions; [
    pop-shell
    gsconnect
    appindicator
    blur-my-shell
  ];

  networking.firewall.allowedTCPPorts =
    gs-connect-ports;
  networking.firewall.allowedUDPPorts =
    gs-connect-ports;
}
