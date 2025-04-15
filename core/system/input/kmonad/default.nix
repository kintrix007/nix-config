{ pkgs, ... }:

{
  services.kmonad = {
    enable = true;
    keyboards = {
      builtinKeyboard = {
        device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
        config = builtins.readFile ./config.kbd;

        defcfg = {
          enable = true;
          allowCommands = false;
          fallthrough = true;
        };
      };
    };

    package = pkgs.kmonad;
  };

  # services = {
  #   udev.extraRules = # udev
  #     ''
  #       # bluebuilt keyboard at work
  #       # ATTRS{address}=="37:31:62:67:EA:58", SYMLINK+="bluebuilt-kbd"
  #       DEVPATH=="/devices/virtual/misc/uhid/0005:04E8:7021.0008/input/input32", SYMLINK+="bluebuilt-kbd"
  #     '';
  # };
}
