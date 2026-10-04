{ pkgs, ... }:

{
  imports = [
    ./neovim.nix
    ./docs.nix
  ];

  environment.systemPackages = with pkgs; [
    nil # One Nix LSP
    nixd # Apparently better than Nil
    nixfmt
    nixpkgs-fmt
    alejandra # A Nix formatter

    bash-language-server
    shellcheck
    shfmt

    tree-sitter

    # terraform
    # terraform-ls

    # Inline Snapshot Testing/Golden Master Testing tool
    python3Packages.cram

    marksman
    markdownlint-cli
    mdformat

    gcc
    clang-tools

    gdb
    gf # A nice GDB Frontend (exe: gf2)

    nodejs
    typescript-language-server

    python3
    pyright
    python3Packages.flake8
    python3Packages.autopep8

    lua
    lua-language-server

    breezy # A friendly version control system?
    mercurial # Another friendly version control system
    jujutsu # I wanna look into this one too

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
