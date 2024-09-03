{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    lsb-release
    vulkan-tools
  ];

  # DR Sprinto has a GraphQL Server listen on this port
  networking.firewall.allowedTCPPorts = [ 37370 ];
  networking.firewall.allowedUDPPorts = [ 37370 ];
  # ? Alternatively disable the firewall altogether.
  # networking.firewall.enable = lib.mkForce false;
}
