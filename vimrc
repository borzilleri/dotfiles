" Don't use vi-compatible mode
set nocompatible                       "Don't use vi-compatible mode.
filetype off                           "Make sure filetype is off for pathogen

" Set VimBall home to bundles directory.
"let g:vimball_home = expand("$HOME/.vim/bundle") ."/". 
"			\ expand('%:t:s!\(\w\+\)\.vba\(\.\w\+\)\?!\1!')

" Call Pathogen 
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()               "Generate Help Tags
filetype plugin indent on              "Re-Enable filetype after pathogen

" General Behavior
set hidden                             "Enable hidden buffers
set nobackup                           "Don't use backup files.
set noswapfile                         "Don't use swap files.
set history=1000                       "Lots of history
set undolevels=1000                    "Lots of undo
set wildignore=*.swp,*.bak             "Ignore these file patterns

" UI Options
set wildmenu
set wildmode=list:longest
set ruler                              "Show Cursor Column & Line Number
set cmdheight=2                        "Command Line Height
set number                             "Show line numbers
set showmode                           "Show current mode
set showcmd
set backspace=indent,eol,start         "Make backspace work like normal (?)
set whichwrap+=<,>,h,l                 "Backspace across line boundaries
set mouse=a                            "Enable mouse everywhere
set shortmess=atI                      "Avoid 'press a key' prompt
set visualbell                         "Use a screen flash alert
set noerrorbells                       "Don't Make Noise
set cursorline                         "Hightlight current line
set showmatch                          "Show matching brackets
set matchtime=5                        "Blink matching brackets for 5/10ths sec
set scrolloff=20                       "Min Lines above/below cursor
set title                              "Set the terminal title
syntax on                              "Enable Syntax Highlighting

let php_sql_query = 1                  "Highlight SQL in PHP Strings
let php_htmlInStrings = 1              "Highlight PHP in HTML Strings

if has('gui_running')                  "GUI Options
	set gfn=Anonymous\ Pro\ 11           "Set GUI Font
	set guioptions-=T                    "Remove the toolbar from the GUI
endif

" Colors
set background=dark                    "Set Background Color
colorscheme ir_black                   "Set Color Scheme

" Formatting & Layout
set autoindent
set copyindent
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set noexpandtab
set nowrap                             "Do not wrap lines
set smarttab                           "Tabs to start a line, spaces elsewhere

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
set hlsearch                           "Highlight search terms

" Editing Behavior
set tags=tags;/

"let completeopt="menuone,longest"     "TODO: Do I need this?
" SuperTab Settings
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

" Taglist Settings
let Tlist_Use_Right_Window = 1         "Taglist window on Right
let Tlist_Exit_OnlyWindow = 1          "Exit VIM if Taglist is the only window
let Tlist_Inc_Winwidth = 0

" NERDTree Settings
let NERDTreeChDirMode = 2

" Lusty Juggler & Explorer Settings
let g:LustyExplorerSuppressRubyWarning = 1
let g:LustyJugglerSuppressRubyWarning = 1

" Key Bindings
let mapleader = ","                    "Comma as leader key
nnoremap ; :                           "Semicolon as colon (no more shift!)
nnoremap <leader>w <c-w>v<c-w>l        "Open & Move to new vertical split

nnoremap <C-h> <C-w>h                  "Navigate splits with C-h/j/k/l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

inoremap <F1> ESC                      "F1 does NOT trigger help
nnoremap <F1> ESC
vnoremap <F1> ESC

set pastetoggle=<F2>                   "Toggle Paste Option with F2
nnoremap <F2> :set invpaste paste?<cr>

" Close the QuickFix & Preview Windows
nnoremap <silent> <expr> <F6> :ccl<cr>:pc<cr>
" Toggle the TagList
nnoremap <silent> <F7> :TlistToggle<cr>
" Toggle NERDTree
nnoremap <silent> <F8> :NERDTreeToggle<cr>

" Fast Editing of vimrc
map <silent> <leader>e :e! ~/.vim_runtime/vimrc<cr>

" Call an Ant target.
" TODO: Make this less dumb.
"nnoremap <F5> :call SetBuildTarget()<cr>

" Auto Commands
" Source vimrc as soon as it's written.
autocmd! BufWritePost vimrc source ~/.vim_runtime/vimrc
" Highlight Lines that go over 80 Characters.
au BufWinEnter * let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
au FocusLost * :wa                     "Save file when focus is lost.
au BufEnter * lcd %:p:h                "CD to a file when editing it.

augroup filetype                       "Force certain filetypes
"	autocmd BufNewFile,BufRead *.html set filetype=php
	autocmd BufNewFile,BufRead *.json set filetype=javascript
	autocmd BufNewFile,Bufread *.tpl  set filetype=html
augroup END

augroup omni                           "Set Omni Completion
	autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
	autocmd FileType css set omnifunc=csscomplete#CompleteCSS
	autocmd FileType xml set omnifunc=xmlcommplete#CompleteTags
	autocmd FileType php set omnifunc=phpcomplete#CompletePHP
augroup END
