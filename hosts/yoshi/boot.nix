{ ... }:

{
  boot.blacklistedKernelModules = [
    "hid-sensor-hub" # To make the brightness buttons work on Framework 13
  ];
}
