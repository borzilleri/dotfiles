" Ensure FileType detection is OFF before Pathogen does it's thing
filetype off
" Set the VimBall home, so Vim installs VBA files in the bundles dir.
let g:vimball_home = expand("$HOME/.vim/bundle") ."/". 
			\ expand('%:t:s!\(\w\+\)\.vba\(\.\w\+\)\?!\1!')
" Call Pathogen 
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Re-enable FileType
filetype on
filetype plugin indent on

set nocompatible " Don't use vi-compatible mode
set hidden
set number
set showmode
set nobackup
set noswapfile

" Vim UI
set ruler "Show Col & Line number of the cursor
set cmdheight=2 "Number of lines to use for command-line
set number "Show line numbers
set showmode "Show current mode
set showcmd
set backspace=indent,eol,start "Make backspace work like normal..??
set whichwrap+=<,>,h,l "Allow backspace & cursor to cross line boundaries
set mouse=a "Use the mouse everywhere
set shortmess=atI "Avoid 'press a key' prompt
set visualbell
set noerrorbells "don't make noise on errors
set cursorline "Hightlight current line

set history=1000
set undolevels=1000
set wildignore=*.swp,*.bak
set title
"set winwidth=80


" Visual Cues
set showmatch "show matching brackets
set matchtime=5 "blink matching brackets for this many tenths of a sec.
set hlsearch
set scrolloff=20 "Min number of lines to keep above/below cursor

" Colors
set background=dark
syntax on
colorscheme ir_black

" Formatting & Layout
set autoindent
set copyindent
set smartindent

set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set nowrap "Do not wrap lines
set smarttab "Tabs at the start of a line, spaces elsewhere

" Folding
set foldenable
set foldmethod=indent
set foldlevel=100
set foldopen-=search
set foldopen-=undo

" Searching
set ignorecase
set smartcase 

" Editing Behavior
"set list
" set listchars=trail:.,extends:#,nbsp:.
set pastetoggle=<F2>

" Remap some Keys
" Semicolon as colon key, no more shift!
nnoremap ; :
" F1 is NOT a help trigger anymore
inoremap <F1> ESC
nnoremap <F1> ESC
vnoremap <F1> ESC

" Set leader key to comma
let mapleader = ","

" Open a new vertical split, and move to that split.
nnoremap <leader>w <C-w>v<C-w>l

" Navigate Splits with CTRL-h/j/k/l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" SuperTab & OmniComplete Functionality
let completeopt = "menu,longest"
let g:SuperTabDefaultCompletionType = 'context'
"let g:SuperTabCompletionContexts = ['s:Contexttext', 's:ContextDiscover']
"let g:SuperTabContextTextomniPrecedence = ['&omnifunc', '&completefunc']
"let g:SuperTabContextDiscoverDiscovery = 
"			\ ['&completefunc:<c-x><c-u>', '&omnifunc:<c-x><c-o>']
"<C-X><C-O>"

" Taglist Settings
nnoremap <silent> <F8> :TlistToggle<CR>
let Tlist_Use_Right_Window = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Inc_Winwidth = 0

" NERDTree Settings
nnoremap <silent> <F7> :NERDTreeToggle<CR>
let NERDTreeChDirMode = 2

" autocmd filetype html,xml set listchars-=tab:>.
" Turn on "intellisense" completion for php
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
let php_sql_query = 1
let php_htmlInStrings = 1

" Save open windows when focus is lost.
au FocusLost * :wa
au BufWinEnter * let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
"au BufEnter * lcd %:p:h

augroup mkd
	autocmd BufRead *.text  set ai formatoptions=tcroqn2 comments=n:>
augroup END

augroup filetype
	autocmd BufNewFile,BufRead *.html set filetype=php
	autocmd BufNewFile,BufRead *.json set filetype=javascript
	autocmd BufNewFile,Bufread *.tpl  set filetype=smarty
augroup END
