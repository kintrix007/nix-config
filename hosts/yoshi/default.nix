{ ... }:

{
  imports = [
    ./configuration.nix
    ./boot.nix
    ./fs.nix
    ./home-manager.nix
    ./users.nix

    # ../../shared/guix
    ../../shared/aseprite
    ../../shared/cups
    ../../shared/desktop/gnome
    ../../shared/fprintd
    ../../shared/games
    ../../shared/home-manager
    ../../shared/obs-deps
    ../../shared/scrtxt

    ../../shared/mtkclient-udev.nix
  ];
}
