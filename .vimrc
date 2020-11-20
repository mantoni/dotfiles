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
set updatetime=100
" Always show sign column (e.g. GitGutter and Syntastic)
set signcolumn=yes
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
" Share OS clipboard
set clipboard=unnamed
" Auto append suffixes
set suffixesadd+=.js,.ts,.jsx,.tsx
" Per project .vimrc
set exrc
set encoding=utf-8
setglobal fileencoding=utf-8
set fileencoding=utf-8
" Enable syntax highlighting
syntax on
" Color
let base16colorspace=256
set background=dark
if $ITERM_PROFILE == "Light"
  set background=light
endif
let g:onedark_hide_endofbuffer = 1
packadd! onedark
colorscheme onedark
" Print margin
set colorcolumn=81
" Turn off line wrapping
set nowrap
" Single space after dot when joining lines
set nojoinspaces
" Highlight active line
set cursorline
" Show context around cursor line
set scrolloff=5
set sidescrolloff=1
" Text-mate style display of invisible characters (tab/newline)
set listchars=tab:>\ ,eol:¬
" Change vertical bar to more solid version
set fillchars+=vert:┃
set list
" Enable omni completion
filetype plugin on
set omnifunc=syntaxcomplete#Complete
" Ignore case in searches except if an uppercase letter is used
set ignorecase
set smartcase
" Do not search here
set wildignore=*/node_modules/*,*/build/*,*/source-maps/*,*/coverage/*

" Set the leader key to ,
let mapleader = ","

" Search for word under cursor
noremap <Leader>s :Ack! <cword><cr>
" Search with ag if available
if executable('ag')
  let g:ackprg = 'ag --vimgrep --literal'
endif

" Show npm version for package name under cursor
map <leader>v yi":!npm show <C-r>0 version<CR>
" Toggle Nerd Tree
noremap <silent> <Leader>n :NERDTreeToggle<CR>
" Reveal in Nerd Tree
noremap <silent> <Leader>. :NERDTreeFind<CR>
" Toggle GitGutter
noremap <silent> <Leader>gg :GitGutterToggle<CR>
" Git status
noremap <silent> <Leader>gs :Gstatus<CR>
" Git log
nnoremap <silent> <Leader>gh :Glog -- %<CR>:set nofoldenable<CR>
" Tern commands
noremap <silent> <Leader>d :TernDef<CR>
noremap <silent> <Leader>r :TernRefs<CR>
noremap <silent> <Leader>R :TernRename<CR>
" Copy / Nocopy
function! ToggleCopyMode()
  if &number
    set nolist
    set nonumber
    set colorcolumn=
  else
    set list
    set number
    set colorcolumn=81
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

" Expand %% to directory of current buffer
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Spell checking
autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_us
" Markdown specific settings
autocmd FileType markdown set wrap | set linebreak

" Fish syntax
autocmd BufRead,BufNewFile *.fish setlocal ft=sh

" Do not keep fugitive Git browsing buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" Diff current buffer with original file
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

" Syntax in markdown
let g:markdown_fenced_languages = ['js=javascript', 'bash=sh', 'json']

" Airline
let g:airline_theme           = 'onedark'
let g:airline_section_z       = '%3p%%'
let g:airline_powerline_fonts = 1
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#default#section_truncate_width={
  \ 'b' : 88,
  \ 'x' : 110,
  \ 'y' : 130,
  \ 'z' : 88
  \ }
let airline#extensions#tmuxline#snapshot_file = '~/.tmux/tmuxline.conf'
let airline#extensions#syntastic#error_symbol = ''
let airline#extensions#syntastic#warning_symbol = ''
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.dirty = '*'

" Bufferline
let g:bufferline_echo           = 0
let g:bufferline_rotate         = 1
let g:bufferline_fixed_index    = -1
let g:bufferline_solo_highlight = 1
" Tmuxline
let g:tmuxline_theme  = 'zenburn'
let g:tmuxline_preset = {
  \'a'    : '#(hostname -s)',
  \'win'  : ['#I #W'],
  \'cwin' : ['#I #W'],
  \'x'    : '%d. %b',
  \'z'    : '%R'}
" Snipmate
let g:snipMate = get(g:, 'snipMate', {}) " Allow for vimrc re-sourcing
let g:snipMate.scope_aliases = {
  \ 'typescript': 'javascript',
  \ 'typescriptreact': 'javascript'}
" delimitMate
let g:delimitMate_balance_matchpairs = 1
" NERDtree
let NERDTreeMinimalUI        = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeWinSize          = 36
let NERDTreeLimitedSyntax    = 1
let NERDTreeSyntaxDisableDefaultPatternMatches = 1
" DevIcons
let DevIconsEnableFoldersOpenClose = 1
" Syntastic
if filereadable('.jslintrc')
  let g:syntastic_javascript_checkers    = ['jslint']
  let g:syntastic_javascript_jslint_args = '--edition=latest'
else
  let g:syntastic_filetype_map={
    \ 'javascriptreact': 'javascript',
    \ 'typescriptreact': 'typescript'
    \ }
  let g:syntastic_javascript_checkers    = ['eslint']
  let g:syntastic_javascript_eslint_exec = 'eslint_d'
  let g:syntastic_typescript_checkers    = ['eslint', 'tsuquyomi']
  let g:syntastic_typescript_eslint_exec = 'eslint_d'
endif
" Autofix entire buffer with eslint_d:
nnoremap <leader>f mF:%!eslint_d --stdin --fix-to-stdout<CR>`F
" Autofix visual selection with eslint_d:
vnoremap <leader>f :!eslint_d --stdin --fix-to-stdout<CR>gv

let g:syntastic_check_on_open            = 1
let g:syntastic_check_on_wq              = 0
let g:syntastic_error_symbol             = ''
let g:syntastic_warning_symbol           = ''
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list            = 2 " Auto close only, no auto open
let g:syntastic_loc_list_height          = 5
let g:syntastic_ignore_files             = ['\m/node_modules/']
"highlight SyntasticErrorSign ctermbg=none ctermfg=none
"highlight SyntasticWarningSign ctermbg=none ctermfg=none
let g:tsuquyomi_disable_quickfix = 1
" Prettier
let g:prettier#autoformat = 0
if filereadable('.prettierrc')
  autocmd BufWritePre *.js PrettierAsync
  autocmd BufWritePre *.ts PrettierAsync
  autocmd BufWritePre *.jsx PrettierAsync
  autocmd BufWritePre *.tsx PrettierAsync
endif
" Gitgutter
let g:gitgutter_sign_priority         = 0
let g:gitgutter_sign_added            = '┃'
let g:gitgutter_sign_modified         = '┃'
let g:gitgutter_sign_removed          = '┃'
let g:gitgutter_sign_modified_removed = '┃'
" Ctrlp
let g:ctrlp_open_multiple_files = '1'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
