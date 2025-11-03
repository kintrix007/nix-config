# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    <nixos-hardware/hp/probook/460G11>
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

  programs = {
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "boldi" ];
    };
  };

  services = {
    udev.extraRules = # udev
      ''
        SUBSYSTEM=="usb", GROUP="spice", MODE="4775"
        SUBSYSTEM=="usb_device", GROUP="spice", MODE="4775"
      '';
  };
}
