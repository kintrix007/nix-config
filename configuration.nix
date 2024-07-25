# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

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
      ./hardware-configuration.nix
      "${nixos-hardware}/framework/13-inch/13th-gen-intel"

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
    patchelf

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

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.05"; # Did you read the comment?
}
