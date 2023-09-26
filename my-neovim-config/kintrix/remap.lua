local telescope = require('telescope.builtin')

-- Leader key
vim.g.mapleader = " "

-- Cursor navigation
-- Navigate editor lines more easily (when linewrap is on)
vim.keymap.set("n", "<A-j>", "gj", {desc = "Go down an editor line"})
vim.keymap.set("n", "<A-k>", "gk", {desc = "Go up an editor line"})

-- Get out of my life
-- I don't want most of what I have typed to disappear when
-- I accidentally hit <C-u> instead of <C-Y>
vim.keymap.set("i", "<C-u>", "<Nop>", { desc = "Remove Ctrl+U" })

-- Project navigation
vim.keymap.set("n", "<leader>fw", vim.cmd.Ex, { desc = "[F]older Vie[w]" })

-- I guess it's LSP?
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show [E]rror" })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "[F]ormat buffer" })
vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format, { desc = "[F]ormat buffer" })

-- Terminal
vim.keymap.set("n", "<leader>cf", ":terminal<CR>", { desc = "[C]onsole [F]ullscreen" })
vim.keymap.set("n", "<leader>cc", ":sp<CR><C-w>j:res 12<CR>:terminal<CR>", { desc = "Open [C]onsole in split view" })
vim.keymap.set("t", [[<C-\><C-\>]], [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Why the hell is this not silent?
vim.keymap.set("n", "<leader>x", function()
    vim.cmd("!chmod +x %")
end, { silent = true, desc = "Make current file executable" })

-- Tab navigation
-- Note to self: g<Tab> cycles between the last used tabs
vim.keymap.set("n", "<leader>t", vim.cmd.tabnew, { desc = "New [T]ab" }) -- May remove this
vim.keymap.set("n", "<leader><C-t>", vim.cmd.tabnew, { desc = "New [T]ab" })
vim.keymap.set("n", "<C-h>", vim.cmd.tabprevious, { desc = "Go to previous tab" })
vim.keymap.set("n", "<C-l>", vim.cmd.tabnext, { desc = "Go to next tab" })

-- System clipbloard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[Y]ank to system clipbloard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "[Y]ank line to system clipbloard" })
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { desc = "[P]aste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", [["+P]], { desc = "[P]aste from system clipboard" })

-- Find and replace visual selection
-- User "very magic" mode by default for searching and 'Find & Replace'
vim.keymap.set("n", "<leader>r", [[:%s/\v//g<Left><Left><Left>]], { desc = "[R]eplace" })
vim.keymap.set("v", "<leader>r", [[:s/\%V\v//g<Left><Left><Left>]], { desc = "[R]eplace in [V]isual Selection" })
vim.keymap.set("n", "/", "/\\v")
vim.keymap.set("v", "/", "/\\v")

-- There has to be a better way than this, right?
-- vim.api.nvim_set_keymap("i", "<C-y>", "copilot#Accept('<CR>')", { expr = true, silent = true })

-- Telescope
vim.keymap.set('n', '<leader><C-p>', telescope.find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<C-p>', telescope.git_files, { desc = 'VSCode Ctrl+P' })

-- Add grep search
-- vim.keymap.set('n', '<leader>fs', builtin.grep_string, {})
-- Or:
vim.keymap.set('n', '<leader>fs', function()
    -- Handle if user does ^C
    local ok, search = pcall(vim.fn.input, "Grep > ")
    if not ok then return end

    telescope.grep_string({ search = search })
end, { desc = '[F]ile [S]earch with grep' })
