--vim.opt.runtimepath:append("~/Projects/nvim-plugins/wide-to-long.nvim")
local wtl = require('wide-to-long')
wtl.setup({
    attach = function(bufnr, lang)
        vim.keymap.set('n', '<leader>tl', wtl.wide_to_long, { noremap=true, silent=true })
        vim.keymap.set('n', '<leader>tw', wtl.long_to_wide, { noremap=true, silent=true })
    end,
})
