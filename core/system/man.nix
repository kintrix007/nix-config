{ config, pkgs, ... }:

{
  documentation.enable = true;
  documentation.man.enable = true;
  # documentation.man.generateCaches = true; # Might be necessary?
  documentation.dev.enable = true;

  environment.systemPackages = with pkgs; [
    # Oh wow, didn't realize this is not default
    man-pages
    man-pages-posix
    # linux-doc
    linux-manual
    linuxHeaders

    # For some reason this is separate from clang
    clang-manpages
  ];
}
