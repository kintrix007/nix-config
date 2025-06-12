# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, pkgs, ... }:

{
  imports = [
    ./nix

    ./editor
    ./media
    ./postgres.nix
    ./system
    ./terminal
  ];

  # Nix settings
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
    "pipe-operators"
  ];
  nixpkgs.config.allowUnfree = true;

  time.timeZone = lib.mkDefault "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  environment.systemPackages =
    with pkgs;
    let
      essentials = [
        bc
        btop
        busybox
        calc
        coreutils
        curl
        dos2unix
        file
        gnumake
        gparted
        htop
        imagemagick
        jq
        libxml2
        nano
        neofetch
        nix-index
        nix-prefetch-scripts
        nixos-option
        parted
        patchelf
        poppler_utils # e.g. pdfunite
        ripgrep
        tree
        unstable.jujutsu # Because of GHSA-794x-2rpg-rfgr
        unzip
        usbutils
        util-linux
        websocat
        wget
        yj # Tool to convert between YAML, JSON, and TOML
        zip
      ];
    in

    essentials
    ++ [
      cifs-utils
      cowsay
      exfat
      fd
      gvfs
      moreutils
      ntfs3g
      pwgen
      sl
      sshfs
      tldr
      wl-clipboard

      authenticator
      kdePackages.filelight
      kdePackages.konsole
      libdecor
      thunderbird
      # tzclock # Analog clock
      w3m # A nice text-based browser
    ];

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
    };

    # Firmware updater
    fwupd.enable = true;

    # tlp.enable = true;

    # Enable the OpenSSH daemon.
    openssh = {
      enable = false;
      # require public key authentication for better security
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
    };

    flatpak.enable = true;
  };

  # For flatpak
  # ! NOTE: Instead enable it where you enable your desktop!
  # xdg.portal.enable = true;

  programs = {
    firefox.enable = true;
    java.enable = true;
    dconf.enable = true;
    ydotool.enable = true;

    git = {
      enable = true;
      package = pkgs.gitFull;
      config = {
        pull.rebase = true;
        core.autocrlf = "input";

        alias = {
          unstage = "restore --staged";
        };
      };
    };

    appimage = {
      enable = true;
      binfmt = true;
    };
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
}
