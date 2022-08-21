local KEYMAPS = {}
KEYMAPS.general = {
    i = {
        ['jk'] = { '<ESC>', 'Exit to normal mode' },

    },
    n = {
        ['<C-j>'] = { '<C-W>j', 'Move split down' },
        ['<C-k>'] = { '<C-W>k', 'Move split up' },
        ['<C-h>'] = { '<C-W>h', 'Move split left' },
        ['<C-l>'] = { '<C-W>l', 'Move split right' },
        ['<leader><cr>'] = { '<cmd>noh<cr>', 'Hide highlights' },
        ['<leader><ev>'] = { ':vsplit $MYVIMRC<cr>', 'Edit vimrc' },
        ['<leader><sv>'] = { ':source $MYVIMRC<cr>', 'Source vimrc' },
    },
    v = {

    },
}

KEYMAPS.Comment = {
    n = {
        ['<C-_>'] = {
            '<Plug>(comment_toggle_blockwise_current)',
            'Comment line',
            expr = true,
        },
    },
    v = {
        ['<C-_>'] = {
            '<Plug>(comment_toggle_linewise_visual)',
            'Comment line',
            expr = true,
        },
    },
}

KEYMAPS.gitsigns = {
    n = {
        ['<leader>h'] = {
            name = 'gitsigns',
            ['s'] = { ':Gitsigns stage_hunk<CR>', 'Stage hunk' },
            ['r'] = { ':Gitsigns reset_hunk<CR>', 'Reset hunk' },
            ['u'] = { ':Gitsigns undo_stage_hunk<CR>', 'Undo stage hunk' },
            ['p'] = { ':Gitsigns preview_hunk<CR>', 'Preview hunk' },
            ['S'] = { ':Gitsigns stage_buffer<CR>', 'Stage buffer' },
            ['R'] = { ':Gitsigns reset_buffer<CR>', 'Reset buffer' },
            ['b'] = { function() require('gitsigns').blame_line({ full = true }) end, 'Blame hunk' },
            ['d'] = { function() require('gitsigns').diffthis() end, 'Diff this' },
            ['D'] = { function() require('gitsigns').diffthis('~') end, 'Diff this vs. HEAD' },
        },
        ['<leader>tb'] = { ':Gitsigns toggle_current_line_blame', 'Toggle line blame' },
        ['<leader>td'] = { ':Gitsigns toggle_deleted', 'Toggle deleted' },
        [']c'] = {
            function()
                if vim.wo.diff then return ']c' end
                vim.schedule(function() require('gitsigns').next_hunk() end)
                return '<Ignore>'
            end,
            'Next hunk',
            expr = true,
        },
        ['[c'] = {
            function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() require('gitsigns').prev_hunk() end)
                return '<Ignore>'
            end,
            'Prev hunk',
            expr = true,
        }
    },
    v = {
        ['<leader>h'] = {
            name = 'gitsigns',
            ['s'] = { ':Gitsigns stage_hunk<CR>', 'Stage hunk' },
            ['r'] = { ':Gitsigns reset_hunk<CR>', 'Reset hunk' },
        },
    },
    o = { ['ih'] = { ':<C-U>Gitsigns select_hunk<CR>', 'Select hunk' } },
    x = { ['ih'] = { ':<C-U>Gitsigns select_hunk<CR>', 'Select hunk' } },
}

KEYMAPS.toggleterm = {
    n = {
        ['<leader>g'] = { '<cmd>lua _lazygit_toggle()<CR>', 'LazyGit' },
    }
}


KEYMAPS['wide-to-long'] = {
    n = {
        ['<leader>tl'] = { function() require('wide-to-long').wide_to_long() end, 'Wide to long' },
        ['<leader>tw'] = { function() require('wide-to-long').long_to_wide() end, 'Long to wide' },
    }
}

KEYMAPS['lsp'] = {
    i = {
        ['<C-k>'] = { '<cmd>Lspsaga signature_help', 'Signature help' },
    },
    v = {
        ['<leader>ca'] = { '<cmd><C-U>Lspsaga range_code_action<cr>', 'Code action' },
    },
    n = {
        ['gd'] = { vim.lsp.buf.definition, 'Go to definition' },
        ['<space>D'] = { vim.lsp.buf.type_definition, 'Go to type def' },
        ['<space>f'] = { vim.lsp.buf.formatting, 'Format file' },
        ['K'] = { '<cmd>Lspsaga hover_doc<cr>', 'Hover doc' },
        ['gD'] = { '<cmd>Lspsaga lsp_finder<cr>', 'LSP finder' },
        ['gp'] = { '<cmd>Lspsaga preview_definition<cr>', 'Preview definition' },
        ['gr'] = { '<cmd>Lspsaga rename<cr>', 'Rename' },
        ['<leader>ca'] = { '<cmd>Lspsaga code_action<cr>', 'Code action' },
        ['<space>e'] = { '<cmd>Lspsaga show_line_diagnostics<cr>', 'Line diagnostics' },
        ['[e'] = { '<cmd>Lspsaga diagnostic_jump_next<CR>', 'Next diagnostic' },
        [']e'] = { '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'Prev diagnostic' },
    },
}

KEYMAPS['telescope'] = {
    n = {
        ['<C-p>'] = { function() require('telescope.builtin').find_files() end, 'Find files' },
        ['<leader>fg'] = { function() require('telescope.builtin').live_grep() end, 'Telescope grep' },
        ['<leader>fb'] = { function() require('telescope.builtin').buffers() end, 'Telescope buffers' },
        ['<leader>fh'] = { function() require('telescope.builtin').help_tags() end, 'Telescope help tags' },
        ['<C-n>'] = {
            function()
                require('telescope').extensions.file_browser.file_browser({
                    depth = 2,
                    grouped = true,
                    hidden = true,
                })
            end,
            'File browser',
        },
    }
}


local M = {}

M.register = function(name, bufnr)
    local mode_map = KEYMAPS[name]
    if mode_map == nil then
        vim.notify(
            string.format('[mappings.register] Unable to find mappings for "%s"...', name),
            vim.log.levels.WARN,
            { title = 'mappings.lua' }
        )
        return
    end

    -- TODO Replace w/ something that will fallback to keymap.set when which-keys isn't loaded
    local wk = require('which-key')
    for mode, mappings in pairs(mode_map) do
        local opts = { mode = mode, buffer = bufnr }
        wk.register(mappings, opts)
    end
end

return M
