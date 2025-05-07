{ ... }:

let
  sprinto = (import ./sprinto { });
in
{
  # environment.systemPackages = with pkgs; [
  #   lsb-release
  #   vulkan-tools
  # ];

  environment.systemPackages = [
    sprinto
  ];

  # DR Sprinto has a GraphQL Server listening on this port
  # networking.firewall.allowedTCPPorts = [ 37370 ];
  # networking.firewall.allowedUDPPorts = [ 37370 ];
}
