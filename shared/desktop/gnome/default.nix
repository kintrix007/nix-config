{ pkgs, config, ... }:

{
  imports = [
    ./extensions.nix
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    # baobab      # disk usage analyzer
    # cheese      # photo booth
    # eog         # image viewer
    epiphany # web browser
    # gedit       # text editor
    # simple-scan # document scanner
    totem # video player
    yelp # help viewer
    # evince      # document viewer
    # file-roller # archive manager
    # geary       # email client
    seahorse # password manager

    # these should be self explanatory
    gnome-contacts
    gnome-music
    gnome-connections
    gnome-photos
    gnome-tour
    gnome-console
    # gnome-weather
    # gnome-extensions # What is the name of it?
    # gnome-calculator gnome-calendar gnome-characters gnome-clocks 
    # gnome-font-viewer gnome-logs gnome-maps gnome-screenshot
    # gnome-system-monitor gnome-disk-utility
  ];

  environment.systemPackages = with pkgs; [
    gnome-randr # xrandr for GNOME on Wayland
    dconf-editor
    gnomecast
    nautilus-python
    epiphany
    newsflash

    nautilus-open-any-terminal
    papirus-icon-theme
    libsForQt5.breeze-gtk
  ];
}
