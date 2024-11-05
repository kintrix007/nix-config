# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

let
  nixos-hardware = builtins.fetchGit {
    url = "https://github.com/NixOS/nixos-hardware.git";
    ref = "master"; # Auto-update on rebuild
  };
in
{
  imports =
    [
      # Include the results of the hardware scan.
      # "${nixos-hardware}/???"
    ];

  ############################
  #                          #
  #   DEFINE YOUR HOSTNAME   #
  #                          #
  ############################
  networking.hostName = "goomba";

  environment.systemPackages = with pkgs; [
    vscodium
    jetbrains.rider
    firefox-devedition
    dbeaver-bin

    keepassxc
    wireguard-tools
  ];

  programs = { };

  services = { };
}
