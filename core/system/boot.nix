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
}
