{ pkgs, ... }:

let
  kmonad = fetchGit {
    url = "https://github.com/kmonad/kmonad";
    rev = "07cd1cb4fddb46a8d9de3bb9d06196d08b7a8ed2";
    ref = "master";
  };
in
{
  imports = [
    "${kmonad}/nix/nixos-module.nix"
  ];

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
