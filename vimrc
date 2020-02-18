" ================================
" Welcome to Keith's vimrc file
" ================================

" --------------------------------
" Plugins
" --------------------------------
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary' " gc to comment out
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'luochen1990/rainbow'
Plugin 'jiangmiao/auto-pairs'
Plugin 'sheerun/vim-polyglot'   " syntax highlighting in most languages
Plugin 'jpalardy/vim-slime'
Plugin 'joshdick/onedark.vim'
Plugin 'danilo-augusto/vim-afterglow'
Plugin 'raingo/vim-matlab'
call vundle#end()
" All of your Plugins must be added before the following line
filetype plugin indent on

" --------------------------------
" Pretty things
" --------------------------------
syntax on
colorscheme afterglow
" Set Airline bar theme
let g:airline_theme = 'afterglow'
"rainbow Plugin Options (luochen1990/rainbow)
let g:rainbow_active = 1    " 0 if you want to enable it later via :RainbowToggle

" Colour at column 80
set colorcolumn=80

" Set vim-slime to tmux
let g:slime_target = "tmux"
let g:slime_python_ipython = 1
" --------------------------------
" Basic stuff
" --------------------------------
let g:mapleader = " " " Set leader to spacebar
set spelllang=en_us
set backspace=indent,eol,start " Bring backspace to life
set number          " Line numbers
set relativenumber  " Relative line numbers
set hlsearch        " Highlight whole word when searching
set ignorecase      " Ignore case when searching...
set smartcase       " ...except when serach query contains a capital letter
set autoread        " Auto load files if they change on disc
map <Leader>p :set paste<CR><esc>"*p:set nopaste<cr>
map <Leader>y "*y  )
map <Leader><Leader> :w<CR>
map <Leader>q :wq<CR>
inoremap jj <ESC>:w<CR>
" Pasting - indent last pasted
nnoremap gz '[=']
nnoremap <leader>; @='A;<C-V><Esc>j'<CR>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><ESC> :noh<cr>

"Cursor
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

map <C-j> <C-w>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Simplify using tabs
nnoremap ˙ gT
nnoremap ¬ gt
nnoremap T :tabnew<cr>
nnoremap Te :tabedit<Space>
" split lines
nnoremap K i<CR><Esc>
nnoremap <CR> m`o<Esc>``

" Open new splits to right and bottom
set splitbelow
set splitright

"Tab completion
set wildmenu
set wildmode=list:longest,list:full
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
    endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Tab size
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Disable swap files
set noswapfile

" Set timeouts to be 100 ms
set ttimeout
set ttimeoutlen=100
" Disable arrow keys in Escape mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" make it easy to edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
