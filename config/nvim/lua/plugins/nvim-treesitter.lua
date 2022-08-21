require("nvim-treesitter.configs").setup({
    ensure_installed = "all",
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "org" }, -- Required since TS highlighter doesn"t support all syntax features (conceal)
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    autotag = { enable = true },
    -- indent = { enable = true },  -- TODO try again later? didn't work quite right as of 2022-08
    textobjects = {
        select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
            -- You can choose the select mode (default is charwise 'v')
            selection_modes = {
                ['@parameter.outer'] = 'v', -- charwise
                ['@function.outer'] = 'V', -- linewise
                ['@class.outer'] = '<c-v>', -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding xor succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            -- include_surrounding_whitespace = true,
        },
    },
})
