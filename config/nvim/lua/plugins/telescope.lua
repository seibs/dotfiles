local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        mappings = {
            n = {
                ['q'] = actions.close,
            }
        }
    },
    extensions = {
        file_browser = {
            -- theme = "ivy",
            theme = "dropdown",
            -- hijack_netrw = true,  -- TODO breaks gx to follow links
            initial_mode = 'normal',
            -- TODO collapse_dirs is broken, attempts to set cwd to a file
            -- collapse_dirs = true,
        },
    },
})

telescope.load_extension("file_browser")
require('mappings').register('telescope')
