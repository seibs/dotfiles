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
        -- config = function() require('plugins.nvim-treesitter') end,
    })
    use({
        'nvim-orgmode/orgmode',
        -- config = function() require('plugins.orgmode') end,
        config = function() require('plugins.nvim-treesitter') end,
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
        after = 'which-key.nvim',
    })

    use({
        'seibs/wide-to-long.nvim',
        config = function() require('plugins.wide-to-long') end,
        after = { 'which-key.nvim', 'nvim-treesitter', 'orgmode' },
    })

    use({
        'nvim-lualine/lualine.nvim',
        config = function() require('lualine').setup({}) end,
    })

    use({
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = function() require('plugins.telescope') end,
        after = 'which-key.nvim',
    })
    use({
        'nvim-telescope/telescope-file-browser.nvim',
        requires = { 'nvim-telescope/telescope.nvim' },
    })

    use({
        'lewis6991/gitsigns.nvim',
        config = function() require('plugins.gitsigns') end,
        after = 'which-key.nvim',
    })

    use({
        'numToStr/Comment.nvim',
        config = function() require('plugins.comment') end,
        after = { 'which-key.nvim', 'nvim-ts-context-commentstring' },
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
        config = function() require("plugins.toggleterm") end,
        after = 'which-key.nvim',
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

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
