" --- Basic Settings

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Set the global encoding and file encodings to UTF-8.
setglobal encoding=utf-8
setglobal fileencodings=utf-8
scriptencoding utf-8

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on


" --- Status Line

" Command line height
set cmdheight=2
" Show the command being typed in the status line.
set showcmd
" Show the current mode in the status line.
set showmode




" --- Editor Display Settings

" Backspace across indents, line endings, line starts
set backspace=indent,eol,start

" Turn syntax highlighting on.
syntax on
" Set the background color for the editor.
set background=dark
" Set the color scheme
colorscheme ir_black

" Add numbers to each line on the left-hand side.
set number
" Show cursor position in the status line.
set ruler
" Highlight cursor line underneath the cursor horizontally.
set cursorline
" Highlight cursor column underneath the cursor vertically.
set cursorcolumn

" --- Line Wrapping

" Enable wrapping long lines
set wrap
" Set the character to display at the start of wrapped lines.
set showbreak=↪

" Display a minimum number of lines above and below the cursor.
set scrolloff=10


" --- Searching

" Ignore case when searching
set ignorecase
" Override ignorecase if a capital letter is used
set smartcase
" Incrementally highlight matching caracters as you type
set incsearch
" Highlight search results
set hlsearch

" --- Command Completion

" Enable automatic command completion.
set wildmenu
" Sets completion to list the longest match first
set wildmode=list:longest
" Ignore these file extensions for command completion
set wildignore=*.swp,*.bak
set wildignore+=.hg,.git,.svn
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.docx,*.xlsx
set wildignore+=*.DS_Store
set wildignore+=*.luac
set wildignore+=*.pyc,

" --- File Management

" Do not save backup files.
set nobackup
" Set command history size
set history=1000

" --- Editing Settings

" Format Options, see |fo-table|:
" https://vimdoc.sourceforge.net/htmldoc/change.html#fo-table
set formatoptions=tcroqn

" Text width for automatic line wrapping
set textwidth=100

" Set tab-related settings for consistent indentation.
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Enable automatic indentation based on the file type.
set autoindent
" Enable smart indentation based on the syntax of the file.
set smartindent
" Preserve the indentation of the previous line when creating a new line.
set copyindent
" Enable smart tab behavior. Tabs at the start of a line, spaces elsewhere.
set smarttab
" Round indentation to the nearest multiple of 'shiftwidth'.
set shiftround

" Do not convert tabs to spaces.
set noexpandtab


" --- Key Mappings

" Map leader key to comma.
let mapleader = ","

" Map 'jj' to escape insert mode.
imap jj <Esc>

" zO: recursively open top level folds
nnoremap zO zCzO

" Disable arrow keys in normal and insert modes
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Open & Move to new vertical split
nnoremap <leader>w <c-w>v<c-w>l
" Navigate window splits with C-h/j/k/l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Map leader+yank/put/delete commands for global clipboard
map <silent> <leader>p "+p
map <silent> <leader>P "+P
map <silent> <leader>d "+d
map <silent> <leader>y "+y