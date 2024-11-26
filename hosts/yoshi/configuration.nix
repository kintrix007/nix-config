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
      "${nixos-hardware}/framework/13-inch/13th-gen-intel"
    ];

  ############################
  #                          #
  #   DEFINE YOUR HOSTNAME   #
  #                          #
  ############################
  networking.hostName = "yoshi"; # Define your hostname.

  networking.hosts = {
    "192.168.178.188" = [ "rwgov" ];
    "192.168.178.181" = [ "m1" ];
    "4.223.120.96" = [ "az1" ];
    "51.12.58.99" = [ "az2" ];
  };

  environment.systemPackages = with pkgs; [
    vscodium
    # jetbrains.clion
    jetbrains.idea-ultimate
    # jetbrains.rider

    android-tools

    # Embedded/robotics tools
    arduino-ide
    arduino-cli
    arduino-language-server
    freecad

    firefox-devedition
    tor-browser
    protonvpn-gui
    anki
  ];

  services = {
    udev.extraRules = ''
      # ST-LINK/V2
      # `lsusb` lists idVendor and idProduct separated by a colon (0483:3748)
      # ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", MODE="0666"

      # STM32F3DISCOVERY rev C+ - ST-LINK/V2-1
      # ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", TAG+="uaccess"

      # Robohouse Hackathon
      ATTRS{idVendor}=="303a", ATTRS{idProduct}=="1001", MODE="0666"
    '';
  };
}
