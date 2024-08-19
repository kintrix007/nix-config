{ ... }:

{
  imports = [
    ./configuration.nix
    ./boot.nix
    ./fs.nix

    ../../shared/aseprite
    ../../shared/cups
    ../../shared/desktop/gnome
    ../../shared/fprintd
    ../../shared/games
    ../../shared/guix
  ];
}
