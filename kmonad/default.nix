{ pkgs, ... }:

{
  imports = [
    ./nixos-module.nix
  ];

  environment.systemPackages = with pkgs; [
    haskellPackages.kmonad
  ];

  services.kmonad = {
    # enable = true;
    # keyboards = {
    #   myKMonadOutput = {
    #     device = "/dev/input/by-id/my-keyboard-kbd";
    #     config = builtins.readFile /path/to/my/config.kbd;
    #   };
    # };

    # If you've installed KMonad from a different source, update this property
    package = pkgs.haskellPackages.kmonad;
  };
}
