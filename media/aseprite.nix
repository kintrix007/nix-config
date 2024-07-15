{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [
    aseprite
    libresprite
  ];

  # nixpkgs.config.permittedInsecurePackages = [
  #   "python-2.7.18.6"
  # ];
}
