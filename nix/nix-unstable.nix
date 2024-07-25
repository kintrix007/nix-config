{ config, pkgs, ... }:

# Note: It seems it will not even require an `--upgrade` for
# it to fetch the latest unstable?
# A: I think it indeed does not. It is not a local channel after all.

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
