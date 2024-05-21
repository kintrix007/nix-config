{ pkgs, ... }:

{
  imports = [
    ./nixos-module.nix
  ];

  environment.systemPackages = with pkgs; [
    haskellPackages.kmonad
  ];

  services.kmonad = {
    enable = true;
    keyboards = {
      builtinKeyboard = {
        device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
        config = builtins.readFile ./config.kbd;
      };
    };

    package = pkgs.haskellPackages.kmonad;
  };
}
