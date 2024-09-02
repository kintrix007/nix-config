{ ... }:

{
  imports = [
    ./configuration.nix
    ./users.nix

    ../../shared/cups
    ../../shared/desktop/gnome
    ../../shared/fprintd
  ];
}
