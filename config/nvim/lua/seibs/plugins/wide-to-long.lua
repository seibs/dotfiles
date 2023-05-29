--vim.opt.runtimepath:append("~/Projects/nvim-plugins/wide-to-long.nvim")
local PLUGIN_NAME = 'wide-to-long'
local wtl = require(PLUGIN_NAME)
wtl.setup({
    attach = function(bufnr, lang)
        require('seibs.mappings').register(PLUGIN_NAME, bufnr)
    end,
})
