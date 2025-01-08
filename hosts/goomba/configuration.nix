# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, pkgs, ... }:

let
  nixos-hardware = builtins.fetchGit {
    url = "https://github.com/NixOS/nixos-hardware.git";
    ref = "master"; # Auto-update on rebuild
  };
in
{
  imports = [
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

    unstable.dbvisualizer
  ];

  nixpkgs.config.permittedInsecurePackages = [
    (lib.trace "Temporarily allowing 'dotnet-sdk-wrapped-7.0.410' for Jetbrains Rider. Remove this as soon as possible." "dotnet-sdk-wrapped-7.0.410")
  ];

  programs = { };

  services = {
    udev.extraRules = # udev
      ''
        SUBSYSTEM=="usb", GROUP="spice", MODE="0660"
        SUBSYSTEM=="usb_device", GROUP="spice", MODE="0660"
      '';
  };
}
