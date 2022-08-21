local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
    vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(function(use)
    use({ 'wbthomason/packer.nvim' })

    use({ 'kyazdani42/nvim-web-devicons' })
    use({
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
        config = function() require('plugins.nvim-treesitter') end,
        requires = {
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
    })
    use({ 'nvim-treesitter/nvim-treesitter-textobjects' })
    use({ "windwp/nvim-ts-autotag" })
    use({
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup({}) end
    })

    use({
        'hrsh7th/nvim-cmp',
        config = function() require('plugins.nvim-cmp') end,
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'saadparwaiz1/cmp_luasnip',
            'onsails/lspkind-nvim',
        },
    })

    use({
        'L3MON4D3/LuaSnip',
        config = function() require('plugins.lua-snip') end,
    })
    use({ 'rafamadriz/friendly-snippets' })

    use({
        'neovim/nvim-lspconfig',
        config = function() require('plugins.lsp') end,
    })
    use({ 'folke/lsp-colors.nvim' })

    use({
        'glepnir/lspsaga.nvim',
        branch = 'main',
        -- TODO Prevent write on finder open?
        config = function() require('lspsaga').init_lsp_saga({
                finder_action_keys = {
                    open = { "o", "<CR>" },
                },
            })
        end,
    })

    use({ 'ellisonleao/gruvbox.nvim' })
    use({ 'luisiacc/gruvbox-baby' })

    use({
        'seibs/wide-to-long.nvim',
        config = function() require('plugins.wide-to-long') end,
    })

    use({
        'nvim-lualine/lualine.nvim',
        config = function() require('lualine').setup({}) end,
    })

    use({
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = function() require('plugins.telescope') end,
    })
    use({
        'nvim-telescope/telescope-file-browser.nvim',
        requires = { 'nvim-telescope/telescope.nvim' },
    })

    use({
        'nvim-orgmode/orgmode',
        config = function()
            require('orgmode').setup_ts_grammar()
            require('orgmode').setup({
                org_agenda_files = { '~/org/*' },
                org_default_notes_file = '~/org/refile.org',
            })
        end,
    })

    use({
        'lewis6991/gitsigns.nvim',
        config = function() require('plugins.gitsigns') end,
        after = 'which-keys.nvim',
    })

    use({
        'numToStr/Comment.nvim',
        config = function() require('plugins.comment') end,
        requires = { 'JoosepAlviste/nvim-ts-context-commentstring' },
        after = 'which-keys.nvim',
    })
    use({ 'vim-scripts/indentpython.vim' })

    use({
        'jose-elias-alvarez/null-ls.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = function() require('plugins.null-ls') end,
    })

    -- TODO try this again some time. initial "extract variable" testing was buggy
    -- use({
    --     'ThePrimeagen/refactoring.nvim',
    --     config = function() require('refactoring').setup({}) end,
    -- })

    use({
        "akinsho/toggleterm.nvim",
        tag = 'v2.*',
        config = function() require("plugins.toggleterm") end
    })

    use({
        'jpalardy/vim-slime',
        config = function()
            vim.g.slime_target = 'tmux'
            vim.g.slime_python_ipyton = 1
            vim.g.slime_default_config = {
                socket_name = "default",
                target_pane = "{right-of}",
            }
            vim.g.slime_dont_ask_default = 1
        end
    })
    use({ 'vim-test/vim-test' })

    use({
        "folke/which-key.nvim",
        config = function() require("which-key").setup({}) end,
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
