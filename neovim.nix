{ config, pkgs, ... }:
let
  haskellPackages = with pkgs; [
    (haskell-language-server.override { supportedGhcVersions = [ "8107" ]; })
  ];
in {
  environment.systemPackages = haskellPackages ++ (with pkgs; [
    neovim
    vimPlugins.packer-nvim
  ]);

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = false;
    vimAlias = true;
    withNodeJs = true; # Needed for coc-nvim
#    configure = {
#      packages.myPlugins = with pkgs.vimPlugins; {
#        start = [
#          kanagawa-nvim
#          telescope-nvim
#          plenary-nvim
#          nvim-treesitter
#          nvim-treesitter-context
#          playground
#          undotree
#          lualine-nvim
#          nvim-autopairs
#          vim-commentary
#          vim-fugitive
#          lsp-zero-nvim
#          nvim-lspconfig
#          nvim-cmp
#          cmp-nvim-lsp
#          luasnip
#          copilot-lua
#          (pkgs.vimUtils.buildVimPlugin {
#            name = "my-config";
#            src = ./my-neovim-config;
#          })
#        ];
#        opt = [];
#      };
#      customRC = ''
#        lua require("init")
#      '';
#    };
  };
}
