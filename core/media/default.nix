{ pkgs, ... }:

{
  imports = [
    ./vlc.nix
  ];

  environment.systemPackages = with pkgs; [
    foliate # Epub reader
    gimp
    inkscape
    mpv
    kdePackages.okular
    tiv # A nice terminal image-viewer

    ffmpeg
    libgourou # To remove DRM from .acsm files
  ];
}
