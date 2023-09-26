# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nix-alien.nix
      ./nix-unstable.nix
      ./neovim.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  virtualisation.libvirtd.enable = true;

  networking.hostName = "yoshi"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

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

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
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
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      gh
      # vscode
      # neovim
      vscodium
      firefox

      util-linux
      vlc mpv
      libgourou # To remove DRM from .acsm files

      unstable.cargo
      ghdl

      jetbrains.clion
      jetbrains.idea-ultimate
      jetbrains.rider

      itch

      godot
      aseprite-unfree
    ];
  };

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
      parted gparted

      git
      curl wget
      htop neofetch
      zip unzip
      bc calc
      ffmpeg
      dos2unix
      tldr
      sl
      cowsay
      # texlive.combined.scheme-medium

      nixos-option
      nix-index
      gnumake gcc nodejs python311

      papirus-icon-theme
      libsForQt5.breeze-gtk
      fira fira-code fira-code-symbols

      pkgs.gnomeExtensions.pop-shell
      pkgs.gnomeExtensions.gsconnect
      pkgs.gnomeExtensions.appindicator
      pkgs.gnomeExtensions.blur-my-shell
      konsole
      nautilus-open-any-terminal

      qemu
      virt-manager
      gnome.gnome-boxes

      wineWowPackages.stable
      # wineWowPackages.waylandFull winetricks
      lutris

      (steam.override {
         # withPrimus = true;
         # withJava = true;
         extraPkgs = pkgs: [ bumblebee glxinfo ];
      }).run
  ];

  environment.gnome.excludePackages = with pkgs.gnome; [
    # baobab      # disk usage analyzer
    # cheese      # photo booth
    # eog         # image viewer
    # epiphany    # web browser
    # gedit       # text editor
    # simple-scan # document scanner
    totem       # video player
    yelp        # help viewer
    # evince      # document viewer
    # file-roller # archive manager
    # geary       # email client
    seahorse    # password manager

    # these should be self explanatory
    gnome-contacts gnome-music
    pkgs.gnome-connections pkgs.gnome-photos pkgs.gnome-tour
    pkgs.gnome-console
    # gnome-weather
    # gnome-extensions # What is the name of it?
    # gnome-calculator gnome-calendar gnome-characters gnome-clocks 
    # gnome-font-viewer gnome-logs gnome-maps gnome-screenshot
    # gnome-system-monitor gnome-disk-utility
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

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  nixpkgs.overlays = [
    (final: prev: {
      steam = prev.steam.override ({ extraPkgs ? pkgs': [], ... }: {
        extraPkgs = pkgs': (extraPkgs pkgs') ++ (with pkgs'; [
          libgdiplus
        ]);
      });
    })
  ];

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
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;
}
