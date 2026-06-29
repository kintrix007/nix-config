{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.gnomeExtensions; [
    appindicator
    bluetooth-battery-meter
    blur-my-shell
    color-picker
    kmonad-toggle
    # NixOS 26.05 ships a pop-shell incompatible with its GNOME version...
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
