-- TODO not in kickstarter, unnecessary?
-- vim.cmd [[syntax enable]]
-- vim.cmd [[filetype plugin indent on]]

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
vim.opt.fileformat = 'unix'  -- TODO?
vim.opt.wrap = false
vim.opt.hlsearch = true  -- Highlight search, turn off of <leader><cr>

-- Set leader to ,
vim.g.mapleader = ","

vim.opt.scrolloff = 4  -- don't let cursor get to the bottom
vim.opt.colorcolumn = "88"  -- add default soft line length limit

-- added from kickstarter
vim.opt.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
