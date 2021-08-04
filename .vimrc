syntax on
filetype plugin indent on

set nocompatible
set relativenumber
set showmode
set nowrap
set tw=80
set smartcase
set smarttab
set smartindent
set autoindent
set softtabstop=4
set shiftwidth=4
set expandtab
set incsearch
set history=1000
set clipboard=unnamedplus,autoselect
set noswapfile

set completeopt=menuone,menu,longest

let &t_ut=''
set termguicolors
set t_Co=256
set t_RV=

set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox
set wildmode=longest,list,full
set wildmenu
set completeopt+=longest

set cmdheight=1
set mouse=nicr
set splitbelow splitright

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'neovimhaskell/haskell-vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'nbouscal/vim-stylish-haskell'
Plug 'ryanoasis/vim-devicons'
Plug 'flazz/vim-colorschemes'
Plug '/home/isaac/.vim/plugged/haskell-syntax/haskell.vim'

call plug#end()

if(strftime("%H") >= 18 || strftime("%H") <= 5)
    colorscheme atom
    let g:airline_theme = 'papercolor'
else
    colorscheme solarized8_light_low
endif


"##################"
"-----Haskell------"
"##################"
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

"##################"
"-----Airline------"
"##################"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_powerline_fonts = 1

let mapleader = " "

" KEY REMAPS
"""" INSERT 
:imap jj <Esc>

"""" NORMAL 
nnoremap <Leader>wj <C-W><C-J>
nnoremap <Leader>wk <C-W><C-K>
nnoremap <Leader>wh <C-W><C-H>
nnoremap <Leader>wl <C-W><C-L>
nnoremap <Leader>. :Explore<CR>
nnoremap <Leader><Tab> :bn<CR>
nnoremap <Leader><Backspace> :bp<CR>
nnoremap <Leader>wd :bd<CR>

