{ config, pkgs, ... }:

{
  documentation.enable = true;
  documentation.man.enable = true;
  documentation.dev.enable = true;

  environment.systemPackages = with pkgs; [
    # Oh wow, didn't realize this is not default
    man-pages
    linux-doc
    linux-manual
    linuxHeaders
    kernel-headers

    # For some reason this is separate from clang
    clang-manpages
  ];
}
