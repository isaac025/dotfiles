syntax on
filetype plugin indent on

set nocompatible
set relativenumber
set nowrap
set showmode
set tw=80
set smartcase
set smarttab
set smartindent
set autoindent
set softtabstop=2
set shiftwidth=2
set expandtab
set incsearch
set mouse=a
set history=1000
set clipboard=unnamedplus,autoselect

set completeopt=menuone,menu,longest

set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox
set wildmode=longest,list,full
set wildmenu
set completeopt+=longest

set t_Co=256

set cmdheight=1
set termguicolors

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'neovimhaskell/haskell-vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'nbouscal/vim-stylish-haskell'
Plug 'mhartington/oceanic-next'

call plug#end()

if (strftime("%H") >= 18) || (strftime("%H") <= 4)
  let g:airline_theme = 'oceanicnext'
  colorscheme OceanicNext
else
  let g:airline_theme = 'papercolor'
  colorscheme pencil
endif


"##################"
"-----Airline------"
"##################"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_powerline_fonts = 1

let mapleader = " "

