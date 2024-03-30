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

    nvim-treesitter
    nvim-treesitter-context
    nvim-treesitter-endwise
    playground

    nvim-lint

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
