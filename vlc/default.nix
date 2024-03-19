{ pkgs, config, ... }:

let
  vlc-bittorent = import ./vlc-bittorrent.nix { };
in
{
  environment.systemPackages = with pkgs; [
    vlc
  ];

  environment.sessionVariables = {
    VLC_PLUGIN_PATH =
      if pkgs.unstable ? vlc-bittorrent then
        "${pkgs.unstable.vlc-bittorrent}"
      else
        "${vlc-bittorent}";
  };

  # For Chromecast support
  networking.firewall.allowedTCPPorts = [ 8010 ];
}
