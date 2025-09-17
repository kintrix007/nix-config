{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    simulator = {
      enable = lib.mkOption {
        default = false;
        example = true;
        type = with lib.types; bool;
        description = ''
          Whether to enable to tooling for simulators
        '';
      };
    };
  };
  config = with config.simulator; {
    assertions = [ ];

    environment.systemPackages = lib.mkIf enable [
      pkgs.oversteer
      pkgs.boxflat
    ];

    services.udev.extraRules =
      lib.mkIf enable # udev
        ''
          SUBSYSTEM=="usb", ATTRS{idVendor}=="044f", MODE="0666"
          # Thrustmaster Universal Challenge
          KERNEL=="event*", ATTRS{idProduct}=="b657", ATTRS{idVendor}=="044f", MODE="0666" GROUP="input"
        '';
  };
}
