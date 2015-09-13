call pathogen#infect()
runtime! plugin/sensible.vim
set nocompatible

" Fix background erase in tmux
set t_ut=
" Smooth redraws
set ttyfast
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
function! ToggleOverLength()
  if exists('w:long_line_match')
    match OverLength //
    unlet w:long_line_match
  else
    match OverLength /\%80v.\+/
    let w:long_line_match = 1
  endif
endfunction
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
" Ignore case in searches except if an uppercase letter is used
set smartcase
" Do not search here
set wildignore=*/node_modules/*

" Set the leader key to ,
let mapleader = ","
" Tab through open buffers
noremap <Leader>b :b<space>
" Find
noremap <Leader>f :find 
" Toggle overlength highlighting
noremap <Leader>h :call ToggleOverLength()<CR>
" Search for word under cursor
map <leader>s :execute "noautocmd vimgrep /\\<" . expand("<cword>") . "\\>/gj **/*.*" <Bar> cw<CR>
" Show npm version for package name under cursor
map <leader>v yi":!npm show <C-r>0 version<CR>
" TODOs
noremap <Leader>t :vimgrep /FIXME\\|TODO/gj **/*.* <Bar> cw<CR>
" Toggle Nerd Tree
noremap <silent> <Leader>n :NERDTreeToggle<CR>
" Reveal in Nerd Tree
noremap <silent> <Leader>. :NERDTreeFind<CR>
" Toggle GitGutter
noremap <silent> <Leader>gg :GitGutterToggle<CR>
" Git log
nnoremap <silent> <Leader>gh :Glog -- %<CR>:set nofoldenable<CR>
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk
" Tern commands
noremap <silent> <Leader>d :TernDef<CR>
noremap <silent> <Leader>r :TernRefs<CR>
noremap <silent> <Leader>R :TernRename<CR>
" Run current file in Mochify
noremap <silent> <Leader>m :!node_modules/.bin/mochify ./%<CR>
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
if system('uname') =~ 'Darwin'
  inoremap ø <C-O>o
  inoremap Ø <C-O>O
  inoremap È <C-O>^
  inoremap å <C-O>$
else
  inoremap <M-o> <C-O>o
  inoremap <M-O> <C-O>O
  inoremap <M-I> <C-O>^
  inoremap <M-A> <C-O>$
endif
" Tabularize on = and :
vnoremap <Leader>= :Tabularize /=<CR>
vnoremap <Leader>: :Tabularize /:<CR>
" Expand %% to directory of current buffer
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Do not keep fugitive Git browsing buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" Diff current buffer with original file
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

" Flavored Markdown by default
augroup markdown
  au!
  au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" Airline
let g:airline_theme           = 'zenburn'
let g:airline_section_z       = '%3p%%'
let g:airline_powerline_fonts = 1
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#default#section_truncate_width={
  \ 'b' : 88,
  \ 'x' : 110,
  \ 'y' : 100,
  \ 'z' : 88
  \ }
" Bufferline
let g:bufferline_echo        = 0
let g:bufferline_rotate      = 1
let g:bufferline_fixed_index = -1
" Tmuxline
let g:tmuxline_theme  = 'zenburn'
let g:tmuxline_preset = {
  \'a'    : '#(hostname -s)',
  \'win'  : ['#I #W'],
  \'cwin' : ['#I #W'],
  \'x'    : '%d. %b',
  \'z'    : '%R'}
" Snipmate
let g:snippets_dir="~/.vim/snippets"
" delimitMate
let g:delimitMate_expand_cr          = 1
let g:delimitMate_balance_matchpairs = 1
" NERDtree
let NERDTreeMinimalUI        = 1
let NERDTreeAutoDeleteBuffer = 1
" Syntastic
if filereadable('.eslintrc')
  let g:syntastic_javascript_checkers = ['eslint']
endif
if filereadable('.jslintrc')
  let g:syntastic_javascript_checkers    = ['jslint']
  let g:syntastic_javascript_jslint_args = '--edition=latest'
endif
let g:syntastic_check_on_open          = 1
let g:syntastic_error_symbol           = 'X'
let g:syntastic_warning_symbol         = '△'
let g:syntastic_loc_list_height        = 5
highlight SyntasticErrorSign ctermfg   = red
highlight SyntasticWarningSign ctermfg = yellow
" JSON
let g:vim_json_syntax_conceal = 0
" Gitgutter
let g:gitgutter_realtime              = 0
let g:gitgutter_eager                 = 0
let g:gitgutter_sign_added            = '┃'
let g:gitgutter_sign_modified         = '┃'
let g:gitgutter_sign_removed          = '┃'
let g:gitgutter_sign_modified_removed = '┃'
" Ctrlp
let g:ctrlp_open_multiple_files = '1'
