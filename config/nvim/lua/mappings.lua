-- Set leader to ,
vim.g.mapleader = ","

vim.keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true })  -- Remap ESC to jk
vim.keymap.set("n", "<leader><cr>", "<cmd>noh<cr>", { noremap = true, silent = true })

-- Easier split navigation
vim.keymap.set("n", "<C-j>", "<C-W>j")
vim.keymap.set("n", "<C-k>", "<C-W>k")
vim.keymap.set("n", "<C-h>", "<C-W>h")
vim.keymap.set("n", "<C-l>", "<C-W>l")


vim.keymap.set("n", "<leader>ev", ":vsplit $MYVIMRC<cr>")
vim.keymap.set("n", "<leader>sv", ":source $MYVIMRC<cr>")

-- TODO move to nvim-tree configs?
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>")

-- Toggle current line or with count
-- TODO renable fancier comment.nvim keymappings? e.g. block vs. line?
vim.keymap.set({ 'n' }, '<C-_>', function() return '<Plug>(comment_toggle_linewise_current)' end, { expr = true })
vim.keymap.set({ 'v' }, '<C-_>', function() return '<Plug>(comment_toggle_linewise_visual)' end, { expr = true })
