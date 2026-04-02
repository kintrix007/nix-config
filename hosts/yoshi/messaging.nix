{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gajim  # XMPP client -- modern Discord-like UI
    dino  # XMPP client  -- older messenger style UI
  ];
}
