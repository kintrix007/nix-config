# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, pkgs, ... }:

let
  rev = "nixos-25.05-small";
  oldpkgs = import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    sha256 = "sha256:0v6bd1xk8a2aal83karlvc853x44dg1n4nk08jg3dajqyy0s98np";
  }) { };
in
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
        nmap # For ncat
        openssl
        parted
        patchelf
        poppler-utils # e.g. pdfunite
        rename
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

        # kdePackages.konsole # Ligatures are broken on the QT 6 version
        oldpkgs.libsForQt5.konsole # use old konsole because it is not broken.
        foot
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

      # Some file managers
      ranger
      mc
      lazygit # For when I feel like it

      authenticator
      diffpdf
      kdePackages.filelight
      libdecor
      zenity
      # tzclock # Analog clock
      w3m # A nice text-based browser
    ];

  services = {
    # avahi = {
    #   enable = true;
    #   nssmdns4 = true;
    # };

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

    localsend = {
      enable = true;
      openFirewall = true;
    };

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

    ssh = {
      extraConfig = ''
        Host git.boldi.dev
          HostName git.boldi.dev
          User git
          Port 443
      '';
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
  networking.firewall.allowedTCPPorts = (lib.range 16500 16600) ++ [ ];
  networking.firewall.allowedUDPPorts = (lib.range 16500 16600) ++ [ ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;
}
