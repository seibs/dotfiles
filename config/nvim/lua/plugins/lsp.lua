-- TODO pulled from README, customize
-- TODO setup formatters, etc.

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
  -- TODO what's a workspace?
  -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  -- vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)

  -- lspsaga overrides
  vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<cr>', bufopts)
  vim.keymap.set('n', 'gD', '<cmd>Lspsaga lsp_finder<cr>', bufopts)
  vim.keymap.set('i', '<C-k>', '<cmd>Lspsaga signature_help<cr>', bufopts)
  vim.keymap.set('n', 'gp', '<cmd>Lspsaga preview_definition<cr>', bufopts)
  vim.keymap.set('n', 'gr', '<cmd>Lspsaga rename<cr>', bufopts)
  vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<cr>', bufopts)
  vim.keymap.set('v', '<leader>ca', '<cmd><C-U>Lspsaga range_code_action<CR>', bufopts)

  vim.keymap.set('n', '<space>e', '<cmd>Lspsaga show_line_diagnostics<CR>', bufopts)
  vim.keymap.set('n', '[e', '<cmd>Lspsaga diagnostic_jump_next<CR>', bufopts)
  vim.keymap.set('n', ']e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', bufopts)

end


-- TODO hardcode snippet support? https://github.com/jemag/dotfiles/blob/master/neovim/.config/nvim/lua/lsp/handlers.lua#L157
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    capabilities = capabilities,
}
require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "npm", "exec", "--package=typescript-language-server", "--", "typescript-language-server", "--stdio" }
}
require('lspconfig')['sumneko_lua'].setup{
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = {'vim'} },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
        },
    },
}
