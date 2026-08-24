{ pkgs, ... }:

{
  services.svnserve.enable = true;

  environment.systemPackages = with pkgs; [
    subversion
  ];
}
