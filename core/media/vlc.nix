{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [
    vlc
  ];

  environment.sessionVariables = {
    VLC_PLUGIN_PATH = "${pkgs.vlc-bittorrent}";
  };

  # For Chromecast support
  networking.firewall.allowedTCPPorts = [ 8010 ];
}
