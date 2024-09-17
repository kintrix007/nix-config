{ ... }:

{
  imports = [
    ./configuration.nix
    ./users.nix

    ./drsprinto.nix
    ./vpn

    ../../shared/cups
    ../../shared/desktop/gnome
    ../../shared/fprintd
    ../../shared/scrtxt
  ];
}
