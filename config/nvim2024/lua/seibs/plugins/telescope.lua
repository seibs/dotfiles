local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
            },
            n = {
                ['q'] = actions.close,
            }
        }
    },
    extensions = {
        file_browser = {
            -- theme = "ivy",
            -- theme = "dropdown",
            sorting_strategy = "ascending",
            scroll_strategy = "cycle",
            layout_config = {
                prompt_position = "top",
            },

            -- hijack_netrw = true,  -- TODO breaks gx to follow links
            initial_mode = 'normal',
            -- TODO collapse_dirs is broken, attempts to set cwd to a file
            -- collapse_dirs = true,
            grouped = true,
            hidden = true,
            cwd = '%:p:h',
            path = '%:p:h',
        },
    },
})

telescope.load_extension("file_browser")
require('seibs.mappings').register('telescope')
