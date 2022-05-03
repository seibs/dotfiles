
call plug#begin(stdpath('data') . '/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'lewis6991/gitsigns.nvim'

Plug 'ellisonleao/gruvbox.nvim'
Plug 'folke/lsp-colors.nvim'

Plug 'scrooloose/nerdcommenter'
Plug 'seibs/wide-to-long.nvim'

Plug 'jpalardy/vim-slime'

Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-lualine/lualine.nvim'

Plug 'vim-test/vim-test'

call plug#end()

set completeopt=menu,menuone,noselect

lua << EOF
  local cmp = require'cmp'

  cmp.setup({
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    })
  })

  -- Mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  local opts = { noremap=true, silent=true }
  vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  
  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  end
  
  -- Use a loop to conveniently call 'setup' on multiple servers and
  -- map buffer local keybindings when the language server attaches
  local servers = { 'pyright' }
  for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup {
      on_attach = on_attach,
      flags = {
        -- This will be the default in neovim 0.7+
        debounce_text_changes = 150,
      }
    }
  end

  require('gitsigns').setup{
    on_attach = function(bufnr)
      local function map(mode, lhs, rhs, opts)
	    opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {})
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
      end
  
      -- Navigation
      map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
      map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})
  
      -- Actions
      map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>')
      map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>')
      map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>')
      map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>')
      map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
      map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
      map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
      map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
      map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
      map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
      map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
      map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
      map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')
  
      -- Text object
      map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
  }

  require'nvim-treesitter.configs'.setup {
    ensure_installed = { 'lua', 'python', 'markdown', 'json', 'yaml', 'vim' },
    sync_install = false,
    ignore_install = {},
    highlight = {
      enable = true,
      disable = {},
      additional_vim_regex_highlighting = false,
    },
  }

  require('nvim-tree').setup()
  require('lualine').setup()

  --vim.opt.runtimepath:append("~/Projects/nvim-plugins/wide-to-long.nvim")
  local wtl = require('wide-to-long')
  wtl.setup{
    attach = function(bufnr, lang)
      vim.keymap.set('n', '<leader>tl', wtl.wide_to_long, { noremap=true, silent=true })
      vim.keymap.set('n', '<leader>tw', wtl.long_to_wide, { noremap=true, silent=true })
    end,
  }
EOF


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on
syntax on
set encoding=utf-8

" Colorscheme
set t_Co=256
set background=dark
colorscheme gruvbox

" Remap ESC to jk
inoremap jk <ESC>

" Easier split navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Allow switching buffers without saving first
set hidden

" Show hybrid line number
set number
set relativenumber

" Turn off audio bell
set vb

" Add vertical column at textwidth+1
set colorcolumn=+1

" Allow backspace to delete autoindents
set backspace=indent,start,eol

" Set leader to ,
let mapleader = ","

" Make editing vimrc faster
noremap <leader>ev :vsplit $MYVIMRC<cr>
noremap <leader>sv :source $MYVIMRC<cr>

" Highlight search, turn off of <leader><cr>
set hlsearch
map <silent> <leader><cr> :noh<cr>



" nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDCommenter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" <ctrl>/ to toggle comments
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv

" Align comments flush-left
let g:NERDDefaultAlign = 'left'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-slime
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:slime_target = "tmux"
let g:slime_python_ipython = 1
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
let g:slime_dont_ask_default = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => nvim tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
" NvimTreeOpen, NvimTreeClose, NvimTreeFocus, NvimTreeFindFileToggle, and NvimTreeResize are also available if you need them

set termguicolors " this variable must be enabled for colors to be applied properly

" a list of groups can be found at `:help nvim_tree_highlight`
"highlight NvimTreeFolderIcon guibg=blue

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-test
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let test#strategy = "neovim"
let test#python#runner = "pyunit"
let test#python#pyunit#executable = "bin/pytest --no-cov --no-buffer"

" Hack to get things working, should probably make a custom runner
function! TSTransform(cmd) abort
  return a:cmd->substitute('pytest\.', '', '')
endfunction

let g:test#custom_transformations = {'ts': function('TSTransform')}
let g:test#transformation = 'ts'

nmap <silent> <leader>t :TestNearest<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Filetype-specific
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TODO must be a better way for all of this...
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=87 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

au BufNewFile,BufRead *.groovy,*.gm,*.g
    \ setf groovy

au BufNewFile,BufRead *.groovy,*.gm,*.g
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

au BufNewFile,BufRead *.md
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
    \ set textwidth=87 |
    \ set wrap |

au BufNewFile,BufRead *.tex
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

au BufNewFile,BufRead *.snippets
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=87 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

au BufNewFile,BufRead *.ts,*.tsx
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
