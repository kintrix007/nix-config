{ config, pkgs, ... }:


let
  protonDir = "/games/kin/proton";
in
{
  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = with pkgs; [
    intel-media-driver
    vaapiIntel
    ocl-icd
    intel-compute-runtime
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
    protonup
    # The following is wrong incorrect
    # (writeShellScriptBin "protonup" ''
    #   ${protonup}/bin/protonup -d "${protonDir}" "$@"
    # '')
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = protonDir;
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-run"
  ];

  hardware.opengl.driSupport32Bit = true; # Enables support for 32bit libs that steam uses
}
