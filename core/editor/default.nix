{ pkgs, ... }:

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
    python3Packages.cram

    marksman
    nodePackages.markdownlint-cli
    python3Packages.mdformat

    gcc
    clang-tools

    gdb
    gf # A nice GDB Frontend

    nodejs
    nodePackages.typescript-language-server

    python3
    pyright
    python3Packages.flake8
    python3Packages.autopep8

    lua
    lua-language-server

    # A Rust REPL
    evcxr

    # commitlint
    # gitlint
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
