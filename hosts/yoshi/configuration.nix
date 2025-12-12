# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

let
  # epic-games-notifier = builtins.fetchGit {
  #   url = "https://git.sr.ht/~kintrix/epic-games-notifier";
  #   ref = "master"; # Branch reference
  #   rev = "c16553e2556338f429406c6a9b1d66b6cf3f21c1"; # Git revision
  # };
in
{
  imports = [
    # Include the results of the hardware scan.
    <nixos-hardware/framework/13-inch/13th-gen-intel>
    # "${epic-games-notifier}/module.nix"
    ../../modules/simulator
  ];

  ############################
  #                          #
  #   DEFINE YOUR HOSTNAME   #
  #                          #
  ############################
  networking.hostName = "yoshi"; # Define your hostname.

  networking.hosts = {
    "10.10.1.3" = [ "firebro" ];
    "10.10.1.4" = [ "hammerbro" ];
    "4.223.120.96" = [ "az1" ];
    "51.12.58.99" = [ "az2" ];
  };

  services.resolved = {
    enable = true;
    dnssec = "true";
    dnsovertls = "opportunistic";
  };

  networking.search = [
    "localhost"
    "local"
    "boldi.dev"
  ];

  environment.systemPackages = with pkgs; [
    vscodium
    # jetbrains.clion
    jetbrains.idea-ultimate
    # jetbrains.rider

    android-tools

    # Embedded/robotics tools
    # arduino-ide
    # arduino-cli
    # arduino-language-server
    # freecad

    # firefox-devedition
    # tor-browser

    anki
    scrcpy
    orca-slicer
  ];

  services = {
    udev.extraRules = # udev
      ''
        SUBSYSTEM=="usb", GROUP="spice", MODE="0660"
        SUBSYSTEM=="usb_device", GROUP="spice", MODE="0660"

        # ST-LINK/V2
        # `lsusb` lists idVendor and idProduct separated by a colon (0483:3748)
        # ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", MODE="0666"

        # STM32F3DISCOVERY rev C+ - ST-LINK/V2-1
        # ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", TAG+="uaccess"

        # Robohouse Hackathon
        ATTRS{idVendor}=="303a", ATTRS{idProduct}=="1001", MODE="0666"
      '';
  };

  # Enable simulator support
  simulator.enable = true;
}
