{ ... }:

{
  services.guix = {
    enable = true;
    gc = {
      enable = true;
      dates = "weekly";
    };
    storeDir = "/gnu/store";
    stateDir = "/gnu/var";
  };
}
