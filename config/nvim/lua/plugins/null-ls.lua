local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.formatting.black.with({
            extra_args = { "-S" },
        }),
        -- null_ls.builtins.diagnostics.mypy,  -- TODO Integrate w/ work setup
        -- null_ls.builtins.diagnostics.flake8,  -- TODO Revisit
        -- null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.diagnostics.eslint,
        -- null_ls.builtins.completion.spell,
    },
})
