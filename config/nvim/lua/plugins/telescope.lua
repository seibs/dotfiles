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
-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
telescope.load_extension("file_browser")

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<C-p>", require("telescope.builtin").find_files, opts)
vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, opts)
vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, opts)
vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, opts)
vim.keymap.set("n", "<C-n>", function()
    telescope.extensions.file_browser.file_browser({
        depth = 2,
        grouped = true,
        hidden = true,
    })
end, opts)
