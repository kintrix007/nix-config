# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      ./guix.nix
      ./nix

      ./desktop
      ./editor
      ./games
      ./media
      ./postgres.nix
      ./system
      ./terminal
      ./users.nix
    ];

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  networking.hostName = "yoshi"; # Define your hostname.
  time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  networking.hosts = {
    "192.168.178.188" = [ "rwgov" ];
    "192.168.178.181" = [ "m1" ];
    "4.223.120.96" = [ "az1" ];
  };

  environment.systemPackages = with pkgs; [
    nano # Just to make sure there is an editor
    wl-clipboard

    gnumake
    file
    tree
    parted
    gparted
    htop
    btop
    neofetch
    dos2unix
    # texlive.combined.scheme-medium

    jq
    bc
    calc
    curl
    wget
    websocat
    netcat
    zip
    unzip
    ripgrep
    fd
    poppler_utils # e.g. pdfunite
    tldr
    sl
    cowsay

    util-linux
    usbutils

    nixos-option
    nix-index
    nix-prefetch-scripts

    # vscode
    # neovim
    vscodium
    # jetbrains.clion
    jetbrains.idea-ultimate
    # jetbrains.rider

    konsole
    firefox
    firefox-devedition
    w3m # A nice text-based browser
    thunderbird
    authenticator
    filelight
    anki

    protonvpn-gui

    libdecor

    ntfs3g
    sshfs
  ];

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
    };

    # Firmware updater
    fwupd.enable = true;

    # Enable the OpenSSH daemon.
    openssh = {
      enable = false;
      # require public key authentication for better security
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
    };

    udev.extraRules = ''
      # ST-LINK/V2
      # `lsusb` lists idVendor and idProduct separated by a colon (0483:3748)
      ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", MODE="0666"

      # STM32F3DISCOVERY rev C+ - ST-LINK/V2-1
      # ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", TAG+="uaccess"
    '';

    flatpak.enable = true;
  };


  programs.java.enable = true;
  programs.dconf.enable = true;
  programs.ydotool.enable = true;
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = (pkgs.lib.range 16500 16600) ++ [ ];
  networking.firewall.allowedUDPPorts = (pkgs.lib.range 16500 16600) ++ [ ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  system.autoUpgrade.enable = false;
  system.autoUpgrade.allowReboot = false;
}
