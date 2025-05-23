{ pkgs, config, ... }:

{
  imports = [
    ./neovim.nix
    ./docs.nix
  ];

  environment.systemPackages = with pkgs; [
    nil # One Nix LSP
    nixd # Apparently better than Nil
    nixfmt-rfc-style
    nixpkgs-fmt
    alejandra # A Nix formatter

    nodePackages.bash-language-server
    shellcheck
    shfmt

    # terraform
    # terraform-ls

    # Inline Snapshot Testing/Golden Master Testing tool
    python311Packages.cram

    marksman
    nodePackages.markdownlint-cli
    python311Packages.mdformat

    gcc
    clang-tools

    nodejs
    nodePackages.typescript-language-server

    python311
    pyright
    python311Packages.flake8
    python311Packages.autopep8

    lua
    lua-language-server

    # A Rust REPL
    evcxr

    # commitlint
    # gitlint
    nodePackages.jsonlint
    yamllint

    ghc
    haskell-language-server

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
