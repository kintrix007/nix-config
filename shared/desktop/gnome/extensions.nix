{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs.gnomeExtensions; [
    pop-shell
    appindicator
    blur-my-shell
    color-picker
    kmonad-toggle

    pano
    pkgs.libgda6
    pkgs.gsound
  ];

  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };
}
