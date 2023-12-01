{ pkgs, config, ... }:

{
  # For OBS virtual webcam
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];

  environment.systemPackages = with pkgs; [
    # Utils for the thing OBS uses to simulate webcam
    v4l-utils
  ];
}
