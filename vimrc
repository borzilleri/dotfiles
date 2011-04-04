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

" UI Options

" Autocomplete commands
set wildmenu
set wildmode=list:longest
" Ignore these patterns.
set wildignore=*.swp,*.bak
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
" Set the Terminal Title
"set title
" Enable Syntax Highlighting
syntax on

" GUI Options
if has('gui_running')
	" If we're running in GTK2, use Anonymous Pro, 11pt.
	" Otherwise, use "h13", whatever that means.
	if has('gui_gtk2')
		set gfn=Anonymous\ Pro\ 11
	else
		set gfn=Anonymous\ Pro:h13
	endif
	set guioptions=
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

" Folding
" TODO: Fix This
"set foldenable
"set foldmethod=syntax
"set foldlevel=100
"set foldopen-=search
"set foldopen-=undo

" Searching
set incsearch
set ignorecase
set smartcase
" Highlight search terms.
set hlsearch

" Editing Behavior
set tags=tags;/

"let completeopt="menuone,longest"     "TODO: Do I need this?
" SuperTab Settings
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabLeadingSpaceCompletion = 0

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

"Navigate splits with C-h/j/k/l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"F1 does NOT trigger help
inoremap <F1> ESC
nnoremap <F1> ESC
vnoremap <F1> ESC

"F2 Toggles Pastemode
set pastetoggle=<F2>
nnoremap <F2> :set invpaste paste?<cr>

" Remove all trailing whitespace
nnoremap <silent> <F5> :let _s=@\<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Close the QuickFix & Preview Windows
nnoremap <silent> <expr> <F6> :ccl<cr>:pc<cr>
" Toggle NERDTree
nnoremap <silent> <F8> :NERDTreeToggle<cr>

nnoremap <silent> \ :noh<cr>

" Fast Editing of vimrc
map <silent> <leader>e :e! ~/.vim_runtime/vimrc<cr>

" Highlight SQL in PHP Strings.
"let php_sql_query = 1
" Highlight HTML in PHP strings.
let php_htmlInStrings = 1

" Auto Commands
" Source vimrc as soon as it's written.
autocmd! BufWritePost vimrc source ~/.vim_runtime/vimrc

" Highlight Lines that go over 80 Characters.
au BufWinEnter * let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
" Save file when focus is lost.
au FocusLost * :wa
" CD to a file when editing it.
au BufEnter * lcd %:p:h

" Force certain file types.
augroup filetype
"	autocmd BufNewFile,BufRead *.html set filetype=php
	autocmd BufNewFile,BufRead *.json set filetype=javascript
	autocmd BufNewFile,Bufread *.tpl  set filetype=html
augroup END

" Set omni completion
augroup omni
	autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
	autocmd FileType css set omnifunc=csscomplete#CompleteCSS
	autocmd FileType xml set omnifunc=xmlcommplete#CompleteTags
	autocmd FileType php set omnifunc=phpcomplete#CompletePHP
augroup END
