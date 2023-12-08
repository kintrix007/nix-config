# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./nix-unstable.nix
      ./home-manager
      ./hardware-configuration.nix

      ./gnome
      ./editor
      ./fonts.nix
      ./input.nix
      ./sound.nix
      ./steam.nix
      ./vm.nix
      ./nix-alien.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.blacklistedKernelModules = [
    "hid-sensor-hub" # To make the brightness buttons work on Framework 13
  ];

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];

  virtualisation.waydroid.enable = true; # Leads to dangling symlinks
  # virtualisation.docker.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  networking.hostName = "yoshi"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # networking.hosts = {
  #   "192.168.178.122" = [ "rw1" ];
  # };

  services.avahi = {
    enable = true;
    nssmdns = true;
    # publish = {
    #   enable = true;
    #   addresses = true;
    #   domain = true;
    # };
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.gutenprint ];

  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = with pkgs; [
    intel-media-driver
    vaapiIntel
    ocl-icd
    intel-compute-runtime
  ];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kin = {
    isNormalUser = true;
    description = "kin";
    extraGroups = [
      "networkmanager"
      "wheel"
      # ! Do not add docker group. That is basically the same as root.
      # "docker"
    ];
    packages = with pkgs; [
      gh
      # vscode
      # neovim
      vscodium

      vlc
      mpv
      libgourou # To remove DRM from .acsm files

      jetbrains.clion
      jetbrains.idea-ultimate
      jetbrains.rider

      itch
      butler
    ];
  };

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
    "python-2.7.18.6" # For Aseprite
    "electron-11.5.0" # For Itch Desktop
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nano # Just to make sure there is an editor
    wl-clipboard
    parted
    gparted

    git
    util-linux
    tree
    curl
    wget
    htop
    neofetch
    zip
    unzip
    file
    bc
    calc
    ffmpeg
    dos2unix
    tldr
    sl
    cowsay
    poppler_utils # e.g. pdfunite
    # texlive.combined.scheme-medium

    nixos-option
    nix-index
    nix-prefetch-git
    nix-prefetch-docker

    konsole
    firefox
    thunderbird
    authenticator

    libdecor

    wineWowPackages.stable
    # wineWowPackages.waylandFull winetricks
    lutris
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.java.enable = true;
  programs.dconf.enable = true;

  programs.direnv = {
    enable = true;
    silent = true;
    loadInNixShell = true;
    nix-direnv.enable = true;
  };

  # List services that you want to enable:

  # Enable the services for the fingerprint reader
  services.fprintd.enable = true;
  services.fprintd.package = pkgs.fprintd-tod;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;
  # services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090;

  # Enable flatpak support
  services.flatpak.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];
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
