{ ... }:

{
  imports = [
    ./configuration.nix
    ./users.nix

    ./android.nix
    ./drsprinto.nix
    ./luks.nix
    ./vpn
    ./winboat
    ./wireshark.nix

    ../../shared/cups
    ../../shared/desktop/gnome
    ../../shared/fprintd
    ../../shared/obs-deps
    ../../shared/scripts
  ];
}
