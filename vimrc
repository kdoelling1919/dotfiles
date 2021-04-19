" ================================;
" Welcome to Keith's vimrc file
" ================================
set encoding=utf-8
scriptencoding utf-8
" --------------------------------
" Plugins
" --------------------------------

" set the runtime path to include Vundle and initialize
filetype off                  " required
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary' " gc to comment out
Plugin 'tpope/vim-ragtag'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'luochen1990/rainbow'
Plugin 'jiangmiao/auto-pairs'
Plugin 'sheerun/vim-polyglot'   " syntax highlighting in most languages
Plugin 'jpalardy/vim-slime'
Plugin 'joshdick/onedark.vim'
Plugin 'danilo-augusto/vim-afterglow'
Plugin 'raingo/vim-matlab'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'dense-analysis/ale'
Plugin 'iamcco/markdown-preview.nvim'
Plugin 'PeterRincker/vim-argumentative'
call vundle#end()
" All of your Plugins must be added before the following line
filetype plugin indent on
"---------------------------------
" Markdown issues
"---------------------------------
call mkdp#util#install()
let g:os = system('uname')
if g:os ==? 'Darwin\n'
    let g:mkdp_path_to_chrome = 'open -a firefox'
else
    let g:mkdp_path_to_chrome = 'firefox'
endif
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 0
" --------------------------------
" Linters & Fixers
" --------------------------------
let g:ale_linters = {
            \ 'python': ['flake8', 'pydocstyle'],
            \ 'matlab': ['mlint'],
            \ 'javascript': ['eslint'],
            \ }
let g:ale_fixers = {
            \ 'python': ['black', 'isort'],
            \ '*': ['trim_whitespace', 'remove_trailing_lines'],
            \ 'javascript': ['prettier'],
            \ 'html': ['prettier'],
            \ }

let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
command! ALEToggleFixer execute "let g:ale_fix_on_save = get(g:, 'ale_fix_on_save', 0) ? 0 : 1"
" --------------------------------
" Pretty things
" --------------------------------
syntax on
" Let after glow inherit background so tmuxcan gray it out
if exists('$TMUX')
    let g:afterglow_inherit_background = 1
endif
colorscheme afterglow
" Set Airline bar theme
let g:airline_theme = 'afterglow'
"rainbow Plugin Options (luochen1990/rainbow)
let g:rainbow_active = 1

" Colour at column 88
set colorcolumn=88

" Set vim-slime to tmux
let g:slime_target = 'tmux'
let g:slime_python_ipython = 1

" --------------------------------
" Basic stuff
" --------------------------------
let g:mapleader = ' ' " Set leader to spacebar
set spelllang=en_us
set backspace=indent,eol,start " Bring backspace to life
set number          " Line numbers
set relativenumber  " Relative line numbers
set nohlsearch        " Highlight whole word when searching
set ignorecase      " Ignore case when searching...
set smartcase       " ...except when serach query contains a capital letter
set autoread        " Auto load files if they change on disc
map <Leader>p :set paste<CR><esc>"*p:set nopaste<cr>
map <Leader>y "*y  )
map <Leader><Leader> :w<CR>
map <Leader>q :wq<CR>
map <Leader>j <Plug>(ale_next_wrap)
map <Leader>k <Plug>(ale_previous_wrap)
map <Leader>c /%%<CR>
map <Leader>C ?%%<CR>
map <Leader>~ bi~<Esc>
" TODO: This only works if there is a %% on each side. We need to figure out how to
" include beginning and end of file in there.
" map <Leader>sc ?%%<CR>jVnk
inoremap jj <ESC>:w<CR>
" Pasting - indent last pasted
nnoremap ;; @='<C-V><Esc>A;<C-V><Esc>j'<CR>
inoremap ;; <Esc>m`A;<Esc>``
" move to beginning or end of line within insert mode
inoremap <C-E> <ESC>A
inoremap <C-A> <ESC>^i
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><ESC> :noh<cr>
" make big header comments
nnoremap <Leader>h :center 80<CR>0r#<Esc>60A<Space><Esc>a#<Esc>hd78<bar>YppVr#kk.
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
nnoremap <CR> o<Esc>

" Open new splits to right and bottom
set splitbelow
set splitright

"Tab completion
set wildmenu
set wildmode=list:longest,list:full
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~? '\k'
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
nnoremap <leader>ev :tabedit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

augroup vimrc
    autocmd!
    autocmd FileType matlab setlocal commentstring=\%\ %s
    autocmd FileType javascript setlocal commentstring=\%\ %s
    " autocmd CursorHoldI * stopinsert
    " autocmd FileType javascript colorscheme onedark
    autocmd BufEnter *.html :syntax sync fromstart
augroup END
