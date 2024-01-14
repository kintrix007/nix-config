{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs.gnomeExtensions; [
    pop-shell
    # gsconnect
    appindicator
    blur-my-shell
  ];

  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };
}
