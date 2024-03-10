{ pkgs }:

with pkgs.vimPlugins.nvim-treesitter-parsers; [
    lua
    c
    rust
    haskell
    nix
]
