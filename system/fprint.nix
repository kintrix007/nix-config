{ config, pkgs, ... }:

{
  # Enable the services for the fingerprint reader
  services.fprintd = {
    enable = true;
    package = pkgs.fprintd-tod;
    tod.enable = true;
    tod.driver = pkgs.libfprint-2-tod1-goodix;
    # tod.driver = pkgs.libfprint-2-tod1-vfs0090;
  };
}
