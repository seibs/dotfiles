local PLUGIN_NAME = 'Comment'
require(PLUGIN_NAME).setup({
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    -- mappings = false,
})
-- TODO mapping comment toggle to <C-_> is not working..
-- require('mappings').register(PLUGIN_NAME)
