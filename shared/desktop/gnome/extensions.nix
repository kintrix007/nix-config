{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.gnomeExtensions; [
    appindicator
    bluetooth-battery-meter
    blur-my-shell
    color-picker
    kmonad-toggle
    pop-shell

    # Used to be default
    pkgs.gnome-shell-extensions

    pano
    pkgs.libgda6
    pkgs.gsound
  ];

  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };
}
