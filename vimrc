
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Definitions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Ensure vim.plug is installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Begin plugin spec
call plug#begin('~/.vim/plugged')

" Vim Improvements
Plug 'vim-airline/vim-airline'

" Navigation-related
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'ctrlpvim/ctrlp.vim'

" Coding helpers
Plug 'scrooloose/nerdcommenter'
Plug 'w0rp/ale'
Plug 'ycm-core/youcompleteme'
Plug 'jpalardy/vim-slime'

" Git-related
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Prose-related
Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-pencil'

" Colorschemes
Plug 'morhetz/gruvbox'

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on
syntax on
set encoding=utf-8

" Colorscheme
set t_Co=256
colorscheme gruvbox
set background=dark
let g:airline_theme='gruvbox'

" Remap ESC to jk
inoremap jk <ESC>

" Easier split navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Allow switching buffers without saving first
set hidden

" Show line number
set number
set relativenumber

" Turn off audio bell
set vb

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
" => NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <C-n> :NERDTreeToggle<CR>

" close NERDTree if it's the only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDCommenter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" <ctrl>/ to toggle comments
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv

" Align comments flush-left
let g:NERDDefaultAlign = 'left'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fugitive
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

noremap <leader>gs :Gstatus<cr>
noremap <leader>gc :Gcommit<cr>
noremap <leader>gd :Gdiff<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" let g:airline_powerline_fonts = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => GitGutter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:gitgutter_max_signs = 750


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDCommenter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:tagbar_ctags_bin = "/home/aseibert/bin/ctags"
noremap <silent> <leader>b :TagbarToggle<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-slime
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:slime_target = "tmux"
let g:slime_python_ipython = 1
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
let g:slime_dont_ask_default = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ale
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ale_enabled = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Pencil
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:pencil#wrapModeDefault = 'soft'

augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init()
augroup END

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
