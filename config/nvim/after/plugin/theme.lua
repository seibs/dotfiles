vim.opt.background = "dark"
-- vim.g.gruvbox_baby_telescope_theme = 1
-- local status_ok, _ = pcall(require, 'gruvbox')
-- if status_ok then
--     vim.cmd("colorscheme gruvbox")
-- end

local status_ok, _ = pcall(require, 'catppuccin')
if status_ok then
    vim.g.catppuccin_flavour = 'mocha'
    vim.cmd("colorscheme catppuccin")
end
