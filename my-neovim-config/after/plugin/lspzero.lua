local lsp = require('lsp-zero').preset('recommended')

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
end)

-- lsp.ensure_installed({'tsserver'})

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

local servers = {
    'bashls',
    'tsserver',
    'pyright',
    'rust_analyzer',
    -- 'hls', -- Takes forever to compile
    -- 'clangd', -- Not supported on aarch64
    -- 'vls', -- Not supported on aarch64
}

lsp.ensure_installed(servers)
-- lsp.setup_servers(servers)

lsp.set_sign_icons({
    error = '!!',
    warn = '!',
    hint = '?',
    info = 'i',
})

local cmp = require('cmp')
-- local cmp_action = require('lsp-zero').cmp_action()
cmp.setup({
    mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        -- Yes, I know. I am new to Vim, I need my tab to autocomplete.
        -- Let's try going back to the default <C-y>...
        -- ['<Tab>'] = cmp.mapping.confirm({select = true}),
    }
})

lsp.on_attach(function(client, bufnr)
    local _ = client
    local opts = { buffer = bufnr, remap = false }

    -- If lsp-zero is not available, try doing those actions with vim lsp.
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()
