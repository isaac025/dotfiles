syntax on filetype plugin indent on
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
set clipboard=unnamed,autoselect
set noswapfile
highlight Comment ctermfg=green
set ruler
set ai
set completeopt=menuone,menu,longest

let &t_ut=''
set t_RV=
set encoding=UTF-8

set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox

set wildmode=longest,list,full
set wildmenu
set completeopt+=longest

set cmdheight=1
set mouse=nicr
set splitbelow splitright

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

let g:airline_powerline_fonts = 1
let g:airline_theme='tomorrow'

colorscheme acme
let mapleader = " "

" Don't automatically indent on save, since vim's autoindent for haskell is buggy
autocmd FileType haskell let b:autoformat_autoindent=0

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

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

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-f> :NERDTreeFind<CR>

nmap <C-t> :TagbarToggle<CR>

let g:ctrlp_root_markers = ['stack.yaml', '*.cabal']
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_user_command = 'find %s -type f'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'i:instance:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type',
        \ 'i' : 'instance'
    \ },
    \ 'scope2kind' : {
        \ 'module'   : 'm',
        \ 'class'    : 'c',
        \ 'data'     : 'd',
        \ 'type'     : 't',
        \ 'instance' : 'i'
    \ }
\ }
