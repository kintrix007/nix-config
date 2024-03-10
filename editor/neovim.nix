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

    telescope-nvim
    # Needed for telescope
    plenary-nvim
    undotree

    nvim-treesitter
    nvim-treesitter-context
    nvim-treesitter-endwise
    playground

    indent-blankline-nvim
    vim-surround
    nvim-autopairs

    lualine-nvim
    # Needed for lualine
    nvim-web-devicons

    copilot-lua
  ] ++ parsers ++ themes;
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = false;
    vimAlias = true;

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
