local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local MENU_FORMAT_OPTS = {
    buffer        = "[Buffer]",
    nvim_lsp      = "[LSP]",
    luasnip       = "[LuaSnip]",
    nvim_lua      = "[Lua]",
    latex_symbols = "[Latex]",
    _typeshed     = "[Typeshed]",
    typing        = "[Typing]",
}


local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require('lspkind')

vim.o.completeopt = "menu,menuone,noselect"

cmp.setup({
    completion = { autocomplete = false },  -- TODO revisit whether i like this
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        -- TODO Maybe have <CR> fallback if no item is selected and the first item == the current word
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
    }, {
        { name = "orgmode" },
    }, {
        { name = "path" },
    }, {
        { name = "nvim_lua" },
    }, {
        { name = "luasnip" },
    }, {
        { name = "buffer" },
    }),
    formatting = {
        format = lspkind.cmp_format({
            before = function(entry, vim_item)
                vim_item.menu = MENU_FORMAT_OPTS[vim_item.menu or entry.source.name]
                return vim_item
            end,
            mode = "symbol_text",
        }),
    },
})
