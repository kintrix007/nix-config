{ ... }:

{
  programs.bash = {
    # enable = true; # Should not be explicitly enabled
    blesh.enable = false;
    completion.enable = true;
    enableLsColors = true;
    undistractMe = {
      enable = false;
      timeout = 60;
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableLsColors = true;
    syntaxHighlighting = {
      enable = true;
      highlighters = [
        "main"
        "brackets"
      ];
    };
  };

  # users.defaultUserShell = pkgs.bash;

  programs.direnv = {
    enable = true;
    silent = true;
    loadInNixShell = true;
    nix-direnv.enable = true;
  };
}
