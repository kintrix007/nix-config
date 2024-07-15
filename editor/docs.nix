{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    texlive.combined.scheme-full
    pandoc
    quarto # Has nicer default formatting than pandoc
  ];
}
