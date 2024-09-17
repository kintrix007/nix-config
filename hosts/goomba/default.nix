{ ... }:

{
  imports = [
    ./configuration.nix
    ./users.nix

    ./drsprinto.nix
    ./luks.nix
    ./vpn

    ../../shared/cups
    ../../shared/desktop/gnome
    ../../shared/fprintd
    ../../shared/scrtxt
  ];
}
