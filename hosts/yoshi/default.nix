{ ... }:

{
  imports = [
    ./configuration.nix
    ./boot.nix
    ./fs.nix
    ./home-manager.nix
    ./users.nix

    ../../shared/aseprite
    ../../shared/cups
    ../../shared/desktop/gnome
    ../../shared/fprintd
    ../../shared/games
    ../../shared/guix
    ../../shared/home-manager
  ];
}
