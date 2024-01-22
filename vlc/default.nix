{ pkgs, config, ... }:

let
  vlc-bittorent = import ./vlc-bittorrent.nix { };
in
{
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "vlc"
      ''
        VLC_PLUGIN_PATH=${vlc-bittorent} ${pkgs.vlc}/bin/vlc "$@"
      '')
  ];
}
