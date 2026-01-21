{ pkgs, ... }:

{
  imports = [
    ./steam.nix
    ./itch.nix
  ];

  environment.systemPackages = with pkgs; [
    unstable.lutris

    # Have it as a flatpak for now
    # heroic

    mangohud
    protonup-ng
    # The following is wrong incorrect
    # (writeShellScriptBin "protonup" ''
    #   ${protonup}/bin/protonup -d "${protonDir}" "$@"
    # '')

    wine-wayland
    winetricks

    r2modman
  ];

  programs.gamemode.enable = true;
}
