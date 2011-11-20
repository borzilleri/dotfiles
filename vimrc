" Don't use vi-compatible mode
set nocompatible
" Turn off filetype detection for Pathogen.
filetype off

" Set VimBall home to bundles directory.
"let g:vimball_home = expand("$HOME/.vim/bundle") ."/".
"			\ expand('%:t:s!\(\w\+\)\.vba\(\.\w\+\)\?!\1!')

" Call Pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

function SetColor(scheme, bg)
	set background a:bg
	colorscheme a:scheme
endfunction

" Re-Enable filetype detection after Pathogen is done
filetype plugin indent on

" General Behavior
" Enable Hidden Buffers
set hidden
" Don't use backup files.
set nobackup
" Don't use swap files.
set noswapfile
" Command history
set history=1000
" Undo history
set undolevels=1000
set encoding=utf-8


" Autocomplete commands
set wildmenu
set wildmode=list:longest
" Ignore these patterns.
set wildignore=*.swp,*.bak
set wildignore+=.hg,.git,.svn
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.DS_Store
set wildignore+=*.luac
set wildignore+=*.pyc

" Show cursor column & line number
set ruler
" Command line height
set cmdheight=2
" Show line numbers
set number
" Show current mode
set showmode
" Show keyboard input in command
set showcmd
" Make backspace saner.
set backspace=indent,eol,start
" Backspace across line boundaries
set whichwrap+=<,>,h,l
" Enable mouse everywhere!
set mouse=a
" Avoid the "press a key" prompt
set shortmess=atI
" Use screen flash for alerts.
set visualbell
" Don't make noise.
set noerrorbells
" Highlight the current line
set cursorline
" Show matching brackets/braces/parens
set showmatch
" Blink matching brackets for 5/10ths
set matchtime=5
" Min lines above/below the cursor
set scrolloff=10
set sidescrolloff=10
" Set the Terminal Title
"set title
" Enable Syntax Highlighting
syntax on
" Disable syntax highlighting after the 100th column
set synmaxcol=200

set shell=/bin/bash
" Show this character at the start of lines that have been wrapped
set showbreak=↪
" Put new windows to the right of the current one
set splitright

set autowrite
set autoread

" TODO: check this on OSX
"set dictionary=/usr/share/dict/words

" GUI Options
if has('gui_running')
	" If we're running in GTK2, use Anonymous Pro, 11pt.
	" Otherwise, use "h13", whatever that means.
	if has('gui_gtk2')
		set gfn=Anonymous\ Pro\ 11
	else
		" MacVim UI Options
		set fuoptions=maxvert,maxhorz
		set gfn=Anonymous\ Pro:h14
	endif
	set guioptions=
endif

" Encoding
if has("multi_byte")
	if &termencoding == ""
		let &termencoding = &encoding
	endif
	set encoding=utf-8
	setglobal fileencoding=utf-8
	set fileencodings=ucs-bom,utf-8,latin1
endif

" Colors
set background=dark
colorscheme ir_black

" Formatting & Layout
set autoindent
set copyindent
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set noexpandtab
set nowrap
" Tabs at the start of a line, spaces elsewhere.
set smarttab
set formatoptions=croqn

" Folding
" TODO: Fix This
set foldenable
set foldmethod=syntax
set foldlevel=100
"set foldopen-=search
"set foldopen-=undo

" Searching
set incsearch
set ignorecase
set smartcase
" Highlight search terms.
set hlsearch

match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Gist Options
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_show_privates = 1

" Editing Behavior
set tags=tags;/

let completeopt="menuone,longest"

" NERDTree Settings
let NERDTreeChDirMode = 2

" Lusty Juggler & Explorer Settings
let g:LustyExplorerSuppressRubyWarning = 1
let g:LustyJugglerSuppressRubyWarning = 1

" Key Bindings
" Comma as leader key.
let mapleader = ","
"Semicolon as colon (no more shift!)
nnoremap ; :
"Open & Move to new vertical split
nnoremap <leader>w <c-w>v<c-w>l

nnoremap / /\v
vnoremap / /\v
" Global subsitutions by default
set gdefault

nnoremap <tab> %
vnoremap <tab> %

" Map del/yank/put commands with leader
" prefixes for global clipboard
map <silent> <leader>p "+p
map <silent> <leader>d "+d
map <silent> <leader>y "+y

"Navigate splits with C-h/j/k/l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <leader>t :NERDTreeToggle<cr>
inoremap <F1> ESC
nnoremap <silent> <F1> :NERDTreeToggle<cr>
vnoremap <F1> ESC

" Remove all trailing whitespace
nnoremap <silent> <F3> :let _s=@\<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

"F4 Toggles Pastemode
set pastetoggle=<F4>
nnoremap <F4> :set invpaste paste?<cr>

" Backslash turns off higlighted search results
nnoremap <silent> \ :noh<cr>

" Fast Editing of vimrc
map <silent> <leader>e :e! ~/.vim_runtime/vimrc<cr>

" Highlight SQL in PHP Strings.
"let php_sql_query = 1
" Highlight HTML in PHP strings.
let php_htmlInStrings = 1

function! JavascriptFold()
	setl foldmethod=syntax
	setl foldlevelstart=1
	syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

	function! FoldText()
		return substitute(getline(v:foldstart), '{.*', '{...}', '')
	endfunction
	setl foldtext=FoldText()
endfunction
au FileType javascript call JavascriptFold()
au FileType javascript setl fen

" Auto Commands
" Source vimrc as soon as it's written.
autocmd! BufWritePost vimrc source ~/.vim_runtime/vimrc

"autocmd FileType php noremap <c-L> :!php -l %<cr>

" Highlight Lines that go over 80 Characters.
au BufWinEnter * let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
" Save file when focus is lost.
au FocusLost * :wa
" CD to a file when editing it.
"au BufEnter * lcd %:p:h

" Force certain file types.
augroup filetype
	autocmd BufNewFile,BufRead */ssh/config set filetype=sshconfig
"	autocmd BufNewFile,BufRead *.html set filetype=php
	autocmd BufNewFile,BufRead *.json set filetype=javascript
	autocmd BufNewFile,BufRead *.tpl  set filetype=html
augroup END

" Set omni completion
augroup omni
	autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
	autocmd FileType css set omnifunc=csscomplete#CompleteCSS
	autocmd FileType xml set omnifunc=xmlcommplete#CompleteTags
	autocmd FileType php set omnifunc=phpcomplete#CompletePHP
augroup END
