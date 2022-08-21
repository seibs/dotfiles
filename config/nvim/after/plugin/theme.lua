vim.opt.background = "dark"
-- vim.g.gruvbox_baby_telescope_theme = 1
local status_ok, _ = pcall(require, 'gruvbox')
if status_ok then
    vim.cmd("colorscheme gruvbox")
end
