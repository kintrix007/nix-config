{ ... }:

{
  imports = [
    ./configuration.nix
    ./users.nix

    ./android.nix
    ./drsprinto.nix
    ./fs.nix
    ./luks.nix
    ./vpn
    ./wireshark.nix

    ../../shared/cups
    ../../shared/desktop/gnome
    ../../shared/fprintd
    ../../shared/obs-deps
    ../../shared/scripts
    # ../../shared/winboat
  ];
}
