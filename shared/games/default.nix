{ pkgs, ... }:

{
  imports = [
    ./steam.nix
    # ./itch.nix
  ];

  environment.systemPackages = with pkgs; [
    lutris

    # Have it as a flatpak for now
    # heroic

    mangohud
    protonup
    # The following is wrong incorrect
    # (writeShellScriptBin "protonup" ''
    #   ${protonup}/bin/protonup -d "${protonDir}" "$@"
    # '')

    wineWowPackages.stable
    wineWowPackages.waylandFull
    winetricks
  ];

  programs.gamemode.enable = true;
}
