{ config, pkgs, ... }:

let
  themes = with pkgs.vimPlugins; [
    sonokai
    kanagawa-nvim
    catppuccin-nvim
    onedarkpro-nvim
  ];
  parsers = import ./ts-parsers.nix { inherit pkgs; };
  plugins = with pkgs.vimPlugins; [
    vim-fugitive
    comment-nvim

    dressing-nvim
    telescope-nvim
    # Needed for telescope
    plenary-nvim
    undotree

    pkgs.vimPlugins.nvim-treesitter
    pkgs.vimPlugins.nvim-treesitter-context
    pkgs.vimPlugins.nvim-treesitter-endwise
    pkgs.vimPlugins.nvim-treesitter-refactor
    pkgs.vimPlugins.playground

    nvim-lint
    nvim-dap

    indent-blankline-nvim
    vim-surround
    nvim-autopairs

    lualine-nvim
    # Needed for lualine
    nvim-web-devicons

    # copilot-lua

    # For the KMonad configuration language
    kmonad-vim
  ] ++ parsers ++ themes;
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = false;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;

    configure = {
      packages.myVimPackage = {
        start = plugins;
        # opt = plugins;
      };
      customRC = ''
        source ~/.config/nvim/init.lua
      '';
    };
  };
}
