{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    itch
    butler
  ];
}
