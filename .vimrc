call pathogen#infect()
runtime! plugin/sensible.vim
set nocompatible

" Fix background erase in tmux
set t_ut=
" Smooth redraws
set ttyfast
" Faster escape sequences
set ttimeoutlen=10
augroup FastEscape
  autocmd!
  au InsertEnter * set timeoutlen=0
  au InsertLeave * set timeoutlen=500
augroup END
" Update things faster (e.g. GitGutter)
set updatetime=1000
" Leave --insert-- to AirLine
set noshowmode
" Sound off
set noerrorbells
" Indentation
set smartindent
set shiftwidth=2 softtabstop=2 tabstop=2 expandtab
" Show line numbers
set number
" Put buffers with changes in the background without warning
set hidden
set history=100
" Do not create backup and swap files
set nobackup
set nowritebackup
set noswapfile
" Enable mouse
set mouse=nv
if $TMUX == ''
  " Share OS clipboard if not running under tmux
  set clipboard=unnamed
endif
" Auto append suffixes
set suffixesadd+=.js
" Per project .vimrc
set exrc
set encoding=utf-8
" Enable syntax highlighting
syntax on
" Color
colorscheme Tomorrow-Night
highlight CursorLineNr ctermfg=yellow
" Print margin
set colorcolumn=80
" Highlight text exceeding the print margin
highlight OverLength ctermbg=red ctermfg=white
match OverLength /\%80v.\+/
" Turn off line wrapping
set nowrap
" Highlight active line
set cursorline
" Show context around cursor line
set scrolloff=5
set sidescrolloff=1
" Text-mate style display of invisible characters (tab/newline)
set listchars=tab:>\ ,eol:¬
set list
highlight NonText ctermfg=238
" Enable omni completion
filetype plugin on
set omnifunc=syntaxcomplete#Complete
" Do not search here
set wildignore=node_modules/**

" Set the leader key to ,
let mapleader = ","
" Find
noremap <Leader>f :find 
" Search for word under cursor
map <leader>s :execute "noautocmd vimgrep /\\<" . expand("<cword>") . "\\>/gj **/*.*" <Bar> cw<CR>
" TODOs
noremap <Leader>t :vimgrep /FIXME\\|TODO/gj **/*.* <Bar> cw<CR>
" Toggle Nerd Tree
noremap <Leader>n :NERDTreeToggle<CR>
" Reveal in Nerd Tree
noremap <Leader>. :NERDTreeFind<CR>
" Toggle GitGutter
noremap <Leader>g :GitGutterToggle<CR>
" Copy / Nocopy
function! ToggleCopyMode()
  if &number
    set nolist
    set nonumber
    set colorcolumn=
  else
    set list
    set number
    set colorcolumn=80
  endif
endfunction
noremap <Leader>c :call ToggleCopyMode()<CR>
" Paste / Nopaste
function! TogglePasteMode(below)
  if &paste
    set nopaste
  else
    set paste
    if a:below
      normal o
    else
      normal O
    endif
    startinsert
  endif
endfunction
noremap <Leader>p :call TogglePasteMode(1)<CR>
noremap <Leader>P :call TogglePasteMode(0)<CR>
" Move around in insert mode
inoremap <M-o> <C-O>o
inoremap ø <C-O>o
inoremap <M-O> <C-O>O
inoremap Ø <C-O>O
inoremap <M-I> <C-O>^
inoremap È <C-O>^
inoremap <M-A> <C-O>$
inoremap å <C-O>$
" Tabularize on = and :
vnoremap <Leader>= :Tabularize /=<CR>
vnoremap <Leader>: :Tabularize /:<CR>
" Expand %% to directory of current buffer
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" File types
autocmd BufEnter *.json set filetype=javascript
" Do not keep fugitive Git browsing buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" Diff current buffer with original file
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

" Flavored Markdown by default
augroup markdown
  au!
  au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" Powerline
let g:Powerline_symbols="fancy"
call Pl#Theme#RemoveSegment('fileformat')
call Pl#Theme#RemoveSegment('lineinfo')
" Snipmate
let g:snippets_dir="~/.vim/snippets"
" delimitMate
let g:delimitMate_expand_cr=1
let g:delimitMate_balance_matchpairs=1
" NERDtree
let NERDTreeMinimalUI=1
let NERDTreeAutoDeleteBuffer=1
