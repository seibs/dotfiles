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
        ['<leader>ev'] = { ':vsplit $MYVIMRC<cr>', 'Edit vimrc' },
        ['<leader>sv'] = { ':source $MYVIMRC<cr>', 'Source vimrc' },
        ['<Tab>'] = { ':bn<cr>', 'Next buffer' },
        ['<S-Tab>'] = { ':bp<cr>', 'Next buffer' },
        ['<leader>b'] = { ':ls<cr>:b<space>', 'Jump to buffer' },
    },
    v = {

    },
}

KEYMAPS.Comment = {
    n = {
        ['<C-_>'] = {
            '<Plug>(comment_toggle_blockwise_current)',
            'Comment line',
            opts = { expr = true },
        },
    },
    v = {
        ['<C-_>'] = {
            '<Plug>(comment_toggle_linewise_visual)',
            'Comment line',
            opts = { expr = true },
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
        ['<leader>tb'] = { ':Gitsigns toggle_current_line_blame<cr>', 'Toggle line blame' },
        ['<leader>td'] = { ':Gitsigns toggle_deleted<cr>', 'Toggle deleted' },
        [']c'] = {
            function()
                if vim.wo.diff then return ']c' end
                vim.schedule(function() require('gitsigns').next_hunk() end)
                return '<Ignore>'
            end,
            'Next hunk',
            opts = { expr = true },
        },
        ['[c'] = {
            function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() require('gitsigns').prev_hunk() end)
                return '<Ignore>'
            end,
            'Prev hunk',
            opts = { expr = true },
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
        ['<leader>rl'] = { function() require('wide-to-long').wide_to_long() end, 'Wide to long' },
        ['<leader>rw'] = { function() require('wide-to-long').long_to_wide() end, 'Long to wide' },
    }
}

KEYMAPS['lsp'] = {
    i = {
        ['<C-k>'] = { vim.lsp.buf.signature_help, 'Signature help' },
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

KEYMAPS['true-zen'] = {
    n = {
        ['<leader>z'] = {
            name = 'TrueZen+Focus',
            ['n'] = { ':TZNarrow<cr>', 'Narrow' },
            ['f'] = { ':TZFocus<cr>', 'Focus' },
            ['m'] = { ':TZMinimalist<cr>', 'Minimalist' },
            ['a'] = { ':TZAtaraxis<cr>', 'Ataraxis' },
        },
    },
    v = {
        ['<leader>zn'] = { ":'<,'>TZNarrow<cr>", 'TrueZen Narrow' },
    }
}

KEYMAPS['twilight'] = {
    n = { ['<leader>zt'] = { ':Twilight<cr>', 'Twilight' } }
}
KEYMAPS['pencil'] = {
    n = { ['<leader>zp'] = { ':TogglePencil<cr>', 'Pencil' } }
}

KEYMAPS['nvim-dap'] = {
    n = {
        ['<leader>d'] = {
            name = 'debug',
            ['b'] = { ':lua require("dap").toggle_breakpoint()<cr>', 'Set Breakpoint' },
            ['c'] = { ':lua require("dap").continue()<cr>', 'Continue' },
            -- ['B'] = { '', 'Set Conditional Breakpoint' },
            -- ['']
            ['o'] = { ':lua require("dapui").toggle()<cr>', 'Toggle UI' },
        },
        ['<F2>'] = { ':lua require("dap").step_over()<cr>', 'Step Over' },
        ['<F3>'] = { ':lua require("dap").step_into()<cr>', 'Step Into' },
        ['<F4>'] = { ':lua require("dap").step_out()<cr>', 'Step Out' },
    },
}

KEYMAPS['symbols-outline'] = {
    n = {
        ['<leader>tt'] = { '<cmd>SymbolsOutline<cr>', 'Toggle Tag Tree' },
    }
}

KEYMAPS['harpoon'] = {
    n = {
        ['<leader>'] = {
            -- TODO change to one keypress?
            ['5'] = { function() require('harpoon.ui').nav_file(1) end, 'Harpoon: File 1' },
            ['4'] = { function() require('harpoon.ui').nav_file(2) end, 'Harpoon: File 2' },
            ['3'] = { function() require('harpoon.ui').nav_file(3) end, 'Harpoon: File 3' },
            ['2'] = { function() require('harpoon.ui').nav_file(4) end, 'Harpoon: File 4' },
            ['1'] = { function() require('harpoon.ui').nav_file(5) end, 'Harpoon: File 5' },
            ['th'] = { require('harpoon.ui').toggle_quick_menu, 'Toggle Harpoon' },
            ['a'] = { require('harpoon.mark').add_file, 'Add to Harpoon' },
        }
    }
}

local M = {}

local DEFAULT_OPTS = {
    buffer = nil,
    desc = nil,
    silent = true,
    noremap = true,
    nowait = false,
}

local function parse_mappings(mappings, group_names, entry, opts, prefix)
    for key, value in pairs(entry) do
        if #value == 0 then
            parse_mappings(mappings, group_names, value, opts, prefix .. key)
        else
            if key ~= 'name' then
                local mapping_opts = vim.tbl_deep_extend("force", opts, value.opts or {})
                mapping_opts.desc = value[2]
                local mapping = {
                    lhs = prefix .. key,
                    rhs = value[1],
                    opts = mapping_opts,
                }
                table.insert(mappings, mapping)
            else
                group_names[prefix] = { name = value }
            end
        end
    end
end

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

    for mode, mappings in pairs(mode_map) do
        local opts = vim.tbl_deep_extend('force', DEFAULT_OPTS, { buffer = bufnr })
        local parsed_mappings = {}
        local parsed_group_names = {}
        parse_mappings(parsed_mappings, parsed_group_names, mappings, opts, '')

        for _, parsed_mapping in pairs(parsed_mappings) do
            vim.keymap.set(mode, parsed_mapping.lhs, parsed_mapping.rhs, parsed_mapping.opts)
        end

        local wk_exists, wk = pcall(require, 'which-key')
        if wk_exists then
            wk.register(parsed_group_names, { mode = mode })
        end

    end
end

return M
