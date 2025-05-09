{ config, pkgs, ... }:


let
  protonDir = "/games/kin/proton";
in
{
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    # intel-media-driver
    # vaapiIntel
    ocl-icd
    intel-compute-runtime
  ];
  hardware.graphics.enable32Bit = true; # Enables support for 32bit libs that steam uses

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    gamescopeSession.enable = true;
  };

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = protonDir;
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-run"
  ];
}
