local PLUGIN_NAME = 'gitsigns'
require(PLUGIN_NAME).setup({
    on_attach = function(bufnr)
        require('mappings').register(PLUGIN_NAME, bufnr)
    end
})
