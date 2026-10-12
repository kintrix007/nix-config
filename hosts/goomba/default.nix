{ ... }:

{
  imports = [
    ./configuration.nix
    ./users.nix

    ./android.nix
    ./ios.nix
    ./drsprinto.nix
    ./fs.nix
    ./luks.nix
    ./vpn
    ./wireshark.nix

    ./svn.nix

    ./gitlab-runner

    # Import user-defined modules
    ../../modules

    # ../../shared/games

    ../../shared/cups
    ../../shared/desktop/gnome
    ../../shared/fprintd
    ../../shared/obs-deps
    ../../shared/scripts
    # ../../shared/winboat
  ];
}
