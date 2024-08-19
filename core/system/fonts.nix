{ pkgs, config, ... }:

{
  fonts.packages = with pkgs; [
    fira
    fira-code
    fira-code-symbols
    fira-code-nerdfont
    noto-fonts-cjk-sans
    cantarell-fonts
    source-code-pro
    dejavu_fonts
    carlito

    # For JP, apparently?
    ipafont
    kochi-substitute
    ttf_bitstream_vera
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [
        "FiraCode Nerd Font"
        "Fira Code"
        "Source Code Pro"
        "IPAGothic"
      ];
      sansSerif = [
        "Cantarell"
        "IPAPGothic"
      ];
      serif = [
        "DejaVu Serif"
        "IPAPMincho"
      ];
    };
  };
}
