call plug#begin('~/.vim/plugged')

" colorscheme luna
colorscheme pyte

" Plugin Setup
Plug 'valloric/youcompleteme'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'chrisbra/colorizer'

let g:ycm_python_binary_path = '/usr/bin/python3.5'
let g:airline_theme = 'luna'
let g:airline_powerline_fonts = 1
let g:colorizer_auto_filetype='css,html'

call plug#end()

set nocompatible

" Tabbing
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Relative number shows relative distances from one spot to another
set relativenumber
" undofile creates a file with a history of undoable options
set undofile

nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

"Down with arrow keys!
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
   
" Remap the godawful Esc key to something better
imap ii <Esc>
nmap ii <ESC>
vmap ii <ESC>

" Make ; great again!
nnoremap ; :

" Make parens rainbow colored so nesting is obvious
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']']]
