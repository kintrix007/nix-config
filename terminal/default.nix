{ config, pkgs, ... }:

{
  imports = [
    ./shell.nix
  ];

  programs.tmux = {
    enable = true;
    clock24 = true;
  };
}
