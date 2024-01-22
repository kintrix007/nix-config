{ pkgs, config, ... }:

{
  services.xserver = {
    xkb = {
      layout = "us";
      options = "caps:swapescape";
    };
  };
}
