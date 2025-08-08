{ lib, ... }:

{
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];

  # Old broken drive
  # fileSystems."/games" = {
  #   device = "/dev/disk/by-uuid/fbdff21a-1844-4b94-b28a-59c1bc9cef8c";
  #   fsType = lib.mkDefault "auto";
  #   options = [ "defaults" "rw" "nofail" "user" "exec" ];
  # };
  fileSystems."/games" = {
    device = "/dev/disk/by-uuid/72c34b64-9cf3-403d-9707-f7bc1edc8ec3";
    fsType = lib.mkDefault "auto";
    options = [ "defaults" "rw" "nofail" "user" "exec" ];
  };
}
