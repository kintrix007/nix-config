{ pkgs, ... }:

{
  programs = {
    nh.enable = true;
    nix-index = {
      enable = true;
      enableBashIntegration = false;  # Because otherwise it doesn't rebuild
      enableZshIntegration = false;   # Because otherwise it doesn't rebuild
    };
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
