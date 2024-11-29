{ config, pkgs, ... }:

{
  programs.bash = {
    # enable = true; # Should not be explicitly enabled
    blesh.enable = true;
    enableCompletion = true;
    enableLsColors = true;
    undistractMe = {
      enable = true;
      timeout = 15;
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableLsColors = true;
    syntaxHighlighting = {
      enable = true;
      highlighters = [ "main" "brackets" ];
    };
  };

  # users.defaultUserShell = pkgs.bash;

  programs.direnv = {
    enable = true;
    silent = true;
    loadInNixShell = true;
  };
}
