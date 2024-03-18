{ pkgs, config, ... }:

let
  vlc-bittorent = import ./vlc-bittorrent.nix { };
in
{
  environment.systemPackages = with pkgs; [
    vlc
  ];

  environment.sessionVariables = {
    VLC_PLUGIN_PATH = "${vlc-bittorent}";
  };

  # For Chromecast support
  networking.firewall.allowedTCPPorts = [ 8010 ];
}
