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
      builtinKeyboard = rec {
        device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
        # config = builtins.readFile /path/to/my/config.kbd;
        config = ''
          (defcfg
            input (device-file "${device}")
            output (uinput-sink "My KMonad Output")

            ;; Comment this if you want unhandled events not to be emitted
            fallthrough true

            ;; Set this to false to disable any command-execution in KMonad
            allow-cmd false
          )

          (defsrc)

          (deflayer layer1)
        '';
      };
    };

    # package = pkgs.haskellPackages.kmonad;
  };
}
