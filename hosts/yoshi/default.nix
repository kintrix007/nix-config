{ ... }:

{
  imports = [
    ./boot.nix
    ./configuration.nix
    ./fs.nix
    ./home-manager.nix
    # ./tailscale.nix
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
