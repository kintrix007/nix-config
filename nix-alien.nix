{ ... }:

let
  nix-alien-pkgs = import (
    builtins.fetchTarball "https://api.github.com/repos/thiagokokada/nix-alien/tarball/master"
  ) { };
in
{
  environment.systemPackages = with nix-alien-pkgs; [
    nix-alien
  ];

  # Optional, but this is needed for `nix-alien-ld` command
  programs.nix-ld.enable = true;
}
