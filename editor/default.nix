{ pkgs, config, ... }:

{
  imports = [
    ./neovim.nix
  ];

  environment.systemPackages = with pkgs; [
    nil # One Nix LSP
    rnix-lsp # Another Nix LSP

    nodePackages.bash-language-server
    shfmt

    python311Packages.mdformat
    nodePackages.markdownlint-cli

    gnumake
    gcc
    clang-tools

    nodejs
    nodePackages.typescript-language-server

    python311
    nodePackages.pyright
    python311Packages.autopep8

    lua
    lua-language-server

    # unstable.cargo
    # unstable.rust-analyzer

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
