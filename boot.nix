{ ... }:

{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Boot splash
  boot.plymouth = {
    enable = true;
  };

  boot.blacklistedKernelModules = [
    "hid-sensor-hub" # To make the brightness buttons work on Framework 13
  ];
}
