-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    require('seibs.mappings').register('lsp', bufnr)
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig')['pyright'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
require('lspconfig')['tsserver'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "npm", "exec", "--package=typescript-language-server", "--", "typescript-language-server", "--stdio" }
}
require('lspconfig')['sumneko_lua'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
        },
    },
}
require('lspconfig')['rust_analyzer'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { 'rustup', 'run', 'nightly', 'rust-analyzer' },
}
