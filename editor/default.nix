{ pkgs, config, ... }:

{
  imports = [
    ./neovim.nix
    ./reports.nix
  ];

  environment.systemPackages = with pkgs; [
    nil # One Nix LSP
    rnix-lsp # Another Nix LSP
    nixpkgs-fmt
    alejandra # A Nix formatter

    nodePackages.bash-language-server
    shellcheck
    shfmt

    marksman
    nodePackages.markdownlint-cli
    python311Packages.mdformat

    gcc
    clang-tools

    nodejs
    nodePackages.typescript-language-server

    python311
    nodePackages.pyright
    python311Packages.flake8
    python311Packages.autopep8

    lua
    lua-language-server

    # commitlint
    # gitlint
    nodePackages.jsonlint
    yamllint

    haskell.compiler.ghc928
    (haskell-language-server.override {
      supportedGhcVersions = [ "928" ];
    })

    (writeShellScriptBin "mkgitignore" ''
      if [[ $# == 0 ]]; then
        echo "Error: Expected at least one arugment but received $@." >&2
        exit 1
      fi

      if [[ -f .gitignore ]]; then
        echo "Error: .gitignore already exists" >&2
        exit 1
      fi

      TOOL="$1"
      shift
      curl -L "https://gitignore.io/api/$TOOL" -o .gitignore "$@"
    '')
  ];
}
