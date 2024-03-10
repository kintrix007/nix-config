{ pkgs, config, ... }:

{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      gmp
    ];
  };
}
