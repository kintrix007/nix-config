{ ... }:

{
  imports = [
    ./configuration.nix
    ./users.nix

    ./drsprinto.nix

    ../../shared/cups
    ../../shared/desktop/gnome
    ../../shared/fprintd
  ];
}
