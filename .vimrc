call pathogen#infect()
set nocompatible

" Indentation
set autoindent smartindent
set shiftwidth=2 softtabstop=2 tabstop=2 expandtab
" Show next search match while typing
set incsearch
" Show line numbers
set number
" Put buffers with changes in the background without warning
set hidden
set history=100
" Do not create swap files
set nobackup
set nowritebackup
set noswapfile
" Automatically load changes
set autoread
" Remember undo chains between sessions
set undofile
" Enable mouse
set mouse=nv
" Share OS clipboard
set clipboard=unnamed
" Auto append suffixes
set suffixesadd+=.js
" No delay on ESC
set ttimeout
set ttimeoutlen=50

" Enable syntax highlighting
syntax on
filetype plugin on
filetype indent on
" Color
colorscheme Tomorrow-Night
highlight CursorLineNr ctermfg=yellow
" Print margin
set colorcolumn=80
" Highlight text exceeding the print margin
highlight OverLength ctermbg=red ctermfg=white
match OverLength /\%81v.\+/
" Highlight active line
set cursorline
" Text-mate style display of invisible characters (tab/newline)
set listchars=tab:▸\ ,eol:¬
set list
if has("macunix")
  highlight NonText ctermfg=black
else
  highlight NonText ctermfg=238
endif
" Status bar
set laststatus=2
set encoding=utf-8
"set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
let g:Powerline_symbols = "fancy"

" Set the leader key to ,
let mapleader = ","
" Toggle Nerd Tree
noremap <Leader>n :NERDTreeToggle<CR>
" Reveal in Nerd Tree
noremap <Leader>f :NERDTreeFind<CR>
" Expand %% to diretory of current buffer
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" File types
autocmd BufEnter *.json set filetype=javascript
" Do not keep fugitive Git browsing buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" Diff current buffer with original file
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

