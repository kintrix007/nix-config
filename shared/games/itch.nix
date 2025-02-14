{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    itch
    # butler # Broken and abandoned upstream
  ];
}
