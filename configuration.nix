# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      <home-manager/nixos>
      ./hardware-configuration.nix
      ./nix-alien.nix
      ./nix-unstable.nix
      ./neovim.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.blacklistedKernelModules = [
    "hid-sensor-hub" # To make the brightness buttons work on Framework 13
  ];
  # For OBS virtual webcam
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];

  swapDevices = [
  { device = "/var/lib/swapfile";
    size = 16*1024;
  }];

  virtualisation.libvirtd.enable = true;
  virtualisation.waydroid.enable = true;
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

  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [
      mozc
    ];
    # fcitx5.addons = with pkgs; [
    #   fcitx5-mozc
    #   fcitx5-gtk
    # ];
  };

  # environment.sessionVariables =
  #   let ime = "fcitx";
  #   in {
  #     INPUT_METHOD = ime;
  #     QT_IM_MODULE = ime;
  #     GTK_IM_MODULE = ime;
  #     XMODIFIERS = "@im=${ime}";
  #     XIM_SERVERS = ime;
  #   };

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

  fonts.fonts = with pkgs; [
    fira
    fira-code
    fira-code-symbols
    noto-fonts-cjk-sans
    cantarell-fonts
    source-code-pro
    dejavu_fonts
    carlito

    # For JP, apparently?
    ipafont
    kochi-substitute
    ttf_bitstream_vera
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [
        "Source Code Pro"
        "FiraCode Nerd Font"
        "IPAGothic"
      ];
      sansSerif = [
        "Cantarell"
        "IPAPGothic"
      ];
      serif = [
        "DejaVu Serif"
        "IPAPMincho"
      ];
    };
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

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.kin = { pkgs, ... }: {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        input-overlay
        obs-pipewire-audio-capture
      ];
    };

    home.stateVersion = "23.05";
  };

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

      vlc mpv
      libgourou # To remove DRM from .acsm files

      unstable.cargo unstable.rust-analyzer

      jetbrains.clion
      jetbrains.idea-ultimate
      jetbrains.rider

      itch
    ];
  };

  nixpkgs.overlays = [
    (final: prev: {
      steam = prev.steam.override ({ extraPkgs ? pkgs': [], ... }: {
        extraPkgs = pkgs': (extraPkgs pkgs') ++ (with pkgs'; [
          libgdiplus
        ]);
      });
    })
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
      parted gparted

      git
      util-linux
      tree
      curl wget
      htop neofetch
      zip unzip
      file
      bc calc
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
      nil      # One Nix LSP
      rnix-lsp # Another Nix LSP
      
      nodePackages.bash-language-server shfmt
      python311Packages.mdformat nodePackages.markdownlint-cli
      gnumake gcc ccls
      nodejs nodePackages.typescript-language-server
      python311 nodePackages.pyright python311Packages.autopep8
      lua lua-language-server

      konsole
      firefox
      thunderbird
      gnome.nautilus-python
      nautilus-open-any-terminal
      authenticator

      papirus-icon-theme
      libsForQt5.breeze-gtk

      # Utils for the thing OBS uses to simulate webcam
      v4l-utils

      libdecor
      pkgs.gnomeExtensions.pop-shell
      pkgs.gnomeExtensions.gsconnect
      pkgs.gnomeExtensions.appindicator
      pkgs.gnomeExtensions.blur-my-shell

      qemu
      virt-manager
      gnome.gnome-boxes
      unstable.epiphany

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
    epiphany    # web browser
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
  programs.direnv = {
    enable = true;
    silent = true;
    loadInNixShell = true;
    nix-direnv.enable = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
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
  networking.firewall.allowedTCPPorts = with pkgs.lib; (
    range 1714 1764 # For GSConnect
  );
  networking.firewall.allowedUDPPorts = with pkgs.lib; (
    range 1714 1764 # For GSConnect
  );
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
