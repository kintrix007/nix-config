{ pkgs, ... }:

{
  programs = {
    nh.enable = true;
    nix-index.enable = true;
  };

  system.tools = {
    nixos-option.enable = true;
  };

  environment.systemPackages = with pkgs; [
    dix
    nurl
    statix
    nix-prefetch
    nix-prefetch-scripts
  ];
}
