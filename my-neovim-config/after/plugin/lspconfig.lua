local lspconfig = require("lspconfig")

lspconfig.hls.setup {
    cmd = {"haskell-language-server-wrapper", "--lsp"},
    filetypes = { "haskell", "lhaskell" },
    settings = {
        haskell = {
            cabalFormattingProvider = "cabalfmt",
            formattingProvider = "stylish-haskell",
        }
    }
}

-- lspconfig.csharp_ls.setup {}

