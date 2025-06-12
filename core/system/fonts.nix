{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    fira
    fira-code
    fira-code-symbols
    nerd-fonts.fira-code
    nerd-fonts.space-mono
    noto-fonts-cjk-sans
    cantarell-fonts
    source-code-pro
    dejavu_fonts
    carlito
    roboto

    # Nix pixel font
    fixedsys-excelsior

    # Minecraft fonts
    monocraft
    miracode # Vectorized

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
