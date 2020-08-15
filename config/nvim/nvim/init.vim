" plugin
execute pathogen#infect()

" colorscheme
colorscheme ron

" syntax
filetype plugin indent on
syntax on

set gdefault
set undofile

set expandtab
set tabstop=4
set shiftwidth=4

set breakindent
set breakindentopt=shift:2
set showbreak=

" maps of keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

map ; :Files<CR>

nnoremap <expr> j v:count? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

nnoremap <expr> q ':q<CR>'

xnoremap . :norm.<CR>

set autoread

if has ("autocmd")
	augroup autoRead
		autocmd!
		autocmd CursorHold * silent! checktime
	augroup END
endif

autocmd VimResized * wincmd =

autocmd filetype c nnoremap <F4> :w <bar> exec '!make'<CR>

set nu
set relativenumber
set backspace=indent,eol,start

set synmaxcol=200

set infercase
set smartindent

nnoremap <F2> :w <bar> exec '!../build/make -j8'<CR>

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

let g:limelight_conceal_ctermfg = 'Gray'
let g:limelight_conceal_ctermfg = 240
