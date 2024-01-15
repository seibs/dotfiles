local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    "kyazdani42/nvim-web-devicons",
    {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            integrations = {
                cmp = true,
                gitsigns = true,
                treesitter = true,
                telescope = true,
                which_key = true,
                harpoon = true,
            }
        },
        config = function(plugin, opts)
            require("catppuccin").setup(opts)
            vim.g.catppuccin_flavour = "mocha"
            vim.cmd("colorscheme catppuccin")
        end,
    },

    { "folke/which-key.nvim", opts = {} },
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "JoosepAlviste/nvim-ts-context-commentstring",
            -- { "windwp/nvim-autopairs", opts = {} },  -- html autoclose/autorename

            {
                "seibs/wide-to-long.nvim",
                -- dir = "~/Projects/nvim-plugins/wide-to-long.nvim/",
                opts = {
                    attach = function(bufnr)
                        require("seibs.mappings").register("wide-to-long", bufnr)
                    end,
                }
            },

            {
                "nvim-orgmode/orgmode",
                event = 'VeryLazy',
                opts = {
                    org_agenda_files = { '~/org/*' },
                    org_default_notes_file = '~/org/refile.org',
                    org_todo_keywords = {'TODO(t!)', 'NEXT(n!)', 'BACKLOG(b!)', '|', 'DONE(d!)', 'CANCELED(c!)', 'MEETING(m!)'}
                },
            },
        },
        build = ":TSUpdate",
        config = function() require("seibs.plugins.nvim-treesitter") end,
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "j-hui/fidget.nvim", opts = {} },
            { "folke/neodev.nvim", opts = {} },
            { "lvimuser/lsp-inlayhints.nvim", opts = {} },
        },
        -- TODO what"s the lazy way to do this?
        config = function() require("seibs.plugins.lsp") end,
    },

    {
        -- Autocompletion
        "hrsh7th/nvim-cmp",
        dependencies = {
            -- Adds LSP completion capabilities
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "onsails/lspkind-nvim",

            -- Snippet Engine & its associated nvim-cmp source
            -- "L3MON4D3/LuaSnip",
            -- {
            --     "L3MON4D3/LuaSnip",
            --     config = function()
            --         require("luasnip.loaders.from_vscode").lazy_load()
            --
            --         require("luasnip").config.set_config({
            --             delete_check_events = "TextChanged",
            --             region_check_events = "InsertEnter",
            --         })
            --     end,
            -- },
            -- "saadparwaiz1/cmp_luasnip",
            -- Adds a number of user-friendly snippets
            -- "rafamadriz/friendly-snippets",
        },
        config = function() require("seibs.plugins.nvim-cmp") end,
    },

    {
        "nvim-lualine/lualine.nvim",
        opts = { options = { theme = "catppuccin", globalstatus = true } }
    },

    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
        },
        config = function() require("seibs.plugins.telescope") end,
        after = "which-key.nvim",
    },

    {
        'numToStr/Comment.nvim',
        config = function() require('seibs.plugins.comment') end,
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            on_attach = function(bufnr) require('seibs.mappings').register('gitsigns', bufnr) end,
        },
    },

    {
        'jpalardy/vim-slime',
        config = function()
            vim.g.slime_target = 'tmux'
            vim.g.slime_python_ipython = 1
            vim.g.slime_default_config = {
                socket_name = "default",
                target_pane = "{right-of}",
            }
            vim.g.slime_dont_ask_default = 1
        end
    },

    'vim-test/vim-test',

    {
        'Pocco81/true-zen.nvim',
        opts = { integrations = { tmux = true, lualine = true, } },
        config = function(plugin, opts)
            require('true-zen').setup(opts)
            require('seibs.mappings').register('true-zen')
        end,
    },
    {
        'preservim/vim-pencil',
        config = function()
            vim.g['pencil#wrapModeDefault'] = 'soft'
            require('seibs.mappings').register('pencil')
        end
    },

    {
        'mfussenegger/nvim-dap',
        config = function() require('seibs.plugins.nvim-dap') end,
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'mfussenegger/nvim-dap' },
        config = function() require('seibs.plugins.nvim-dap-ui') end,
    },
    {
        'theHamsta/nvim-dap-virtual-text',
        dependencies = { 'nvim-treesitter' },
        opts = {},
    },

    {
        'ThePrimeagen/harpoon',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('seibs.mappings').register('harpoon')
        end,
    },

    {
        'scalameta/nvim-metals',
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function() require("seibs.plugins.metals") end,
    },

    {
        "mbbill/undotree",
        config = function() require("seibs.mappings").register("undotree") end,
    },

    -- Stuff I"m dropping but may want to revisit for other solutions
    -- TODO Dropping lspsaga, should find replacements for useful things like
    -- definitions/refererences box, code actions popup, etc.

    -- TODO dropping null-ls due to archiving, new solution for linting/formatting?
    -- TODO dropping Diffview, never really used it
    -- TODO not sure what indentpython.vim was doing for me
};

require("lazy").setup(plugins)
