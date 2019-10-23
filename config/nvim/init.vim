" colorscheme
colorscheme ron

filetype on
set undofile
syntax on

set gdefault

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

nnoremap <expr> j v:count? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

nnoremap <expr> q ':wq<CR>'

xnoremap . :norm.<CR>

set autoread

if has ("autocmd")
	augroup autoRead
		autocmd!
		autocmd CursorHold * silent! checktime
	augroup END
endif

autocmd VimResized * wincmd =

set nu
set relativenumber
set backspace=indent,eol,start

set synmaxcol=200

set infercase
set smartindent


nnoremap <F7> :'<,'>s/^/^#/<CR>
