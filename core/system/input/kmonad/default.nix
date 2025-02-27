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
}
