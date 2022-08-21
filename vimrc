"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on
syntax on
set encoding=utf-8

" Colorscheme
set t_Co=256

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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Filetype-specific
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
