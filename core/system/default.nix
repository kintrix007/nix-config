{ ... }:

{
  imports = [
    ./input

    ./bluetooth.nix
    ./boot.nix
    ./fonts.nix
    ./locale.nix
    ./man.nix
    ./sound.nix
    ./virtualization.nix
  ];
}
