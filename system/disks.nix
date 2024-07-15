{ pkgs, config, ... }:

{
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];

  fileSystems."/games" = {
    device = "/dev/disk/by-uuid/fbdff21a-1844-4b94-b28a-59c1bc9cef8c";
    fsType = "auto";
    options = [ "defaults" "rw" "nofail" "user" "exec" ];
  };
}
