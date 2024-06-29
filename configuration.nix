# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./home-manager
      ./nix-unstable.nix

      ./aseprite.nix
      ./disks.nix
      ./editor
      ./fonts.nix
      ./fprint.nix
      ./gnome
      ./input
      ./locale.nix
      ./man.nix
      ./nix-alien.nix
      ./nix-ld.nix
      ./postgres.nix
      ./print.nix
      ./sound.nix
      ./steam.nix
      ./storage.nix
      ./terminal
      ./users.nix
      ./virtualization.nix
      ./vlc
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.blacklistedKernelModules = [
    "hid-sensor-hub" # To make the brightness buttons work on Framework 13
  ];

  networking.hostName = "yoshi"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.hosts = {
    "192.168.178.188" = [ "rwgov" ];
    "4.223.120.96" = [ "az1" ];
  };

  services.udev.extraRules = ''
    # ST-LINK/V2
    # `lsusb` lists idVendor and idProduct separated by a colon (0483:3748)
    ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", MODE="0666"

    # STM32F3DISCOVERY rev C+ - ST-LINK/V2-1
    # ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", TAG+="uaccess"
  '';

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    # publish = {
    #   enable = true;
    #   addresses = true;
    #   domain = true;
    # };
  };

  services.flatpak.enable = true;

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
  };

  programs.java.enable = true;
  programs.dconf.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  nixpkgs.overlays = [
    # (final: prev:
    #   let
    #     nixd = fetchTarball "https://github.com/nix-community/nixd/archive/master.tar.gz";
    #   in
    #   pkgs.callPackage (import nixd)
    #   # with pkgs; import nixd  { inherit lib stdenv nix pkg-config llvmPackages bison meson gtest flex lit ninja boost182 libbacktrace nixpkgs-fmt; }
    # )
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-11.5.0" # For Itch Desktop
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
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
    ffmpeg
    poppler_utils # e.g. pdfunite
    tldr
    sl
    cowsay

    util-linux
    usbutils
    ydotool

    nixos-option
    nix-index
    nix-prefetch-scripts

    # vscode
    # neovim
    vscodium
    # jetbrains.clion
    jetbrains.idea-ultimate
    # jetbrains.rider

    # vlc
    mpv
    libgourou # To remove DRM from .acsm files

    konsole
    firefox
    firefox-devedition
    w3m # A nice text-based browser
    tiv # A nice terminal image-viewer
    thunderbird
    authenticator
    okular
    foliate # Epub reader
    filelight
    gimp
    anki
    # * Depends on butler
    # itch
    # * Currently broken
    # butler


    libdecor

    wineWowPackages.stable
    # wineWowPackages.waylandFull winetricks
    lutris

    ntfs3g
    sshfs
  ];

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = false;
    # require public key authentication for better security
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
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
