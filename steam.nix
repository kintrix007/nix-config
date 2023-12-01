{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      steam = prev.steam.override ({ extraPkgs ? pkgs': [ ], ... }: {
        extraPkgs = pkgs': (extraPkgs pkgs') ++ (with pkgs'; [
          libgdiplus
        ]);
      });
    })
  ];

  # environment.systemPackages = with pkgs; [
  #   (steam.override {
  #     # withPrimus = true; # NVIDIA only
  #     # withJava = true;
  #     extraPkgs = pkgs: [ bumblebee glxinfo ];
  #   }).run
  # ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  hardware.opengl.driSupport32Bit = true; # Enables support for 32bit libs that steam uses
}
