vim.cmd [[syntax enable]]
vim.cmd [[filetype plugin indent on]]

-- set t_Co=256
vim.opt.termguicolors = true

vim.opt.hidden = true  -- Allow switching buffers without saving first
vim.opt.number = true  -- Show hybrid line number
vim.opt.relativenumber = true
vim.opt.vb = true  -- Turn off audio bell
--TODO vim.o.colorcolumn = +1  -- Add vertical column at textwidth+1

--TODO set backspace=indent,start,eol  -- Allow backspace to delete autoindents

vim.opt.tabstop = 4  -- Defaults for all, filetype specific configs in ftplugins
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.fileformat = 'unix'  -- TODO
vim.opt.wrap = false
vim.opt.hlsearch = true  -- Highlight search, turn off of <leader><cr>

-- set completeopt=menu,menuone,noselect


