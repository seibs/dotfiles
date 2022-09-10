local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
    cmd = "lazygit",
    direction = "float",
    float_opts = {
        border = "double",
    },
    on_open = function(term)
        vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = term.bufnr })
    end,
})

function _lazygit_toggle()
    lazygit:toggle()
end

require('seibs.mappings').register('toggleterm')

-- TODO custom terminal for ipython?
