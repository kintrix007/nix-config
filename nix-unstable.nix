{ config, pkgs, ... }:

let
  unstableChannel = fetchTarball "channel:nixpkgs-unstable";
in
{
  nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = import unstableChannel {
        config = config.nixpkgs.config;
      };
    };
  };
}
