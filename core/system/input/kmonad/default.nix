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
      bluetoothKeyboard = {
        # TODO: Change to a permanent device path
        device = "/dev/bt-keyboard";
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

  services = {
    udev.extraRules = # udev
      ''
        # bluebuilt keyboard at work
        SUBSYSTEMS=="input", ATTRS{uniq}=="26:23:73:37:7b:63", SYMLINK+="bt-keyboard"
      '';
  };
}
