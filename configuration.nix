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

      ./aseprite.nix
      ./editor
      ./fonts.nix
      ./fprint.nix
      ./gnome
      ./input.nix
      ./man.nix
      ./nix-alien.nix
      ./nix-ld.nix
      ./postgres.nix
      ./sound.nix
      ./steam.nix
      ./terminal
      ./virtualization.nix
      ./vlc
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

  fileSystems."/games" = {
    device = "/dev/disk/by-uuid/fbdff21a-1844-4b94-b28a-59c1bc9cef8c";
    fsType = "auto";
    options = [ "defaults" "rw" "nofail" "user" "exec" ];
  };

  networking.hostName = "yoshi"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.hosts = {
    "192.168.178.188" = [ "rwgov" ];
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
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
      foomatic-filters
      foomatic-db
      foomatic-db-nonfree
      foomatic-db-ppds
      foomatic-db-engine
    ];
  };

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

      # vlc
      mpv
      libgourou # To remove DRM from .acsm files

      # jetbrains.clion
      jetbrains.idea-ultimate
      # jetbrains.rider

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
    "electron-11.5.0" # For Itch Desktop
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nano # Just to make sure there is an editor
    wl-clipboard

    git
    gnumake
    file
    tree
    parted
    gparted
    htop
    neofetch
    dos2unix
    # texlive.combined.scheme-medium

    bc
    calc
    curl
    wget
    zip
    unzip
    ripgrep
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

    konsole
    firefox
    w3m # A nice text-based browser
    tiv # A nice terminal image-viewer
    thunderbird
    authenticator
    okular
    filelight
    gimp

    libdecor

    wineWowPackages.stable
    # wineWowPackages.waylandFull winetricks
    lutris

    ntfs3g
    sshfs
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

  # List services that you want to enable:

  # Enable flatpak support
  services.flatpak.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = false;
    # require public key authentication for better security
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

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
