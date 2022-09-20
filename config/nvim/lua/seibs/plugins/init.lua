local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    _PACKER_BOOTSTRAP = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
    vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(function(use)
    use({ 'wbthomason/packer.nvim' })

    use({ 'kyazdani42/nvim-web-devicons' })
    use({ 'ellisonleao/gruvbox.nvim' })
    use({ 'luisiacc/gruvbox-baby' })
    use({ 'folke/lsp-colors.nvim' })

    use({
        "folke/which-key.nvim",
        config = function() require("which-key").setup({}) end,
    })

    -- TODO treesitter/orgmode configuration is a mess
    -- the ordering must be:
    -- - load TS
    -- - load orgmode
    -- - orgmode setup ts grammer
    -- - ts setup
    -- - orgmode setup
    -- eesh...
    use({
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
        -- config = function() require('seibs.plugins.nvim-treesitter') end,
    })
    use({
        'nvim-orgmode/orgmode',
        -- config = function() require('seibs.plugins.orgmode') end,
        config = function() require('seibs.plugins.nvim-treesitter') end,
        after = 'nvim-treesitter',
    })

    use({ 'JoosepAlviste/nvim-ts-context-commentstring', after = { 'nvim-treesitter', 'orgmode' } })
    use({ 'nvim-treesitter/nvim-treesitter-textobjects', after = { 'nvim-treesitter', 'orgmode' } })
    use({ "windwp/nvim-ts-autotag", after = { "nvim-treesitter", 'orgmode' } })
    use({
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup({}) end
    })

    use({
        'hrsh7th/nvim-cmp',
        config = function() require('seibs.plugins.nvim-cmp') end,
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
        config = function() require('seibs.plugins.lua-snip') end,
    })
    use({ 'rafamadriz/friendly-snippets' })

    use({
        'neovim/nvim-lspconfig',
        config = function() require('seibs.plugins.lsp') end,
    })

    use({
        'glepnir/lspsaga.nvim',
        branch = 'main',
        -- TODO Prevent write on finder open?
        config = function() require('lspsaga').init_lsp_saga({
                finder_action_keys = {
                    open = { "o", "<CR>" },
                },
                code_action_lightbulb = {
                    enable = false,
                    virtual_text = false,
                },
            })
        end,
        after = 'which-key.nvim',
    })
    use({
        "j-hui/fidget.nvim",
        config = function() require('fidget').setup({}) end,
    })
    use({
        'lvimuser/lsp-inlayhints.nvim',
        config = function() require('lsp-inlayhints').setup() end,
    })

    use({
        'seibs/wide-to-long.nvim',
        config = function() require('seibs.plugins.wide-to-long') end,
        after = { 'which-key.nvim', 'nvim-treesitter', 'orgmode' },
    })

    use({
        'nvim-lualine/lualine.nvim',
        config = function() require('lualine').setup({ options = { globalstatus = true } }) end,
    })

    use({
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = function() require('seibs.plugins.telescope') end,
        after = 'which-key.nvim',
    })
    use({
        'nvim-telescope/telescope-file-browser.nvim',
        requires = { 'nvim-telescope/telescope.nvim' },
    })

    use({
        'lewis6991/gitsigns.nvim',
        config = function() require('seibs.plugins.gitsigns') end,
        after = 'which-key.nvim',
    })

    use({
        'numToStr/Comment.nvim',
        config = function() require('seibs.plugins.comment') end,
        after = { 'which-key.nvim', 'nvim-ts-context-commentstring' },
    })
    use({ 'vim-scripts/indentpython.vim' })

    use({
        'jose-elias-alvarez/null-ls.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = function() require('seibs.plugins.null-ls') end,
    })

    -- TODO try this again some time. initial "extract variable" testing was buggy
    -- use({
    --     'ThePrimeagen/refactoring.nvim',
    --     config = function() require('refactoring').setup({}) end,
    -- })

    use({
        "akinsho/toggleterm.nvim",
        tag = 'v2.*',
        config = function() require("seibs.plugins.toggleterm") end,
        after = 'which-key.nvim',
    })

    use({
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
    })
    use({ 'vim-test/vim-test' })

    use({
        'Pocco81/true-zen.nvim',
        config = function()
            require('true-zen').setup({
                integrations = {
                    tmux = true,
                    lualine = true,
                }
            })
            require('seibs.mappings').register('true-zen')
        end,
    })
    use({
        "folke/twilight.nvim",
        config = function()
            require("twilight").setup({})
            require('seibs.mappings').register('twilight')
        end
    })
    use({
        'preservim/vim-pencil',
        config = function()
            vim.g['pencil#wrapModeDefault'] = 'soft'
            require('seibs.mappings').register('pencil')
        end
    })

    use({ 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' })
    use({
        'mfussenegger/nvim-dap',
        config = function() require('seibs.plugins.nvim-dap') end,
    })
    use({
        'rcarriga/nvim-dap-ui',
        requires = { 'mfussenegger/nvim-dap' },
        config = function() require('seibs.plugins.nvim-dap-ui') end,
    })
    use({
        'theHamsta/nvim-dap-virtual-text',
        after = { 'nvim-treesitter' },
        config = function() require("nvim-dap-virtual-text").setup({}) end,
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if _PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
