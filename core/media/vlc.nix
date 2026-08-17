{ pkgs, ... }:

{
  programs.vlc = {
    enable = true;
    chromecast.openFirewall = true;

    plugins = with pkgs; [
      vlc-bittorrent
    ];
  };
}
