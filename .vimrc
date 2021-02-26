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
set updatetime=500
" Always show sign column (e.g. GitGutter and Ale)
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
set suffixesadd+=.js,.ts,.jsx,.tsx,.json,.html
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
let g:onedark_terminal_italics = 1
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
" Show npm version for package name under cursor
noremap <leader>v yi":!npm show <C-r>0 version<CR>
" Toggle Nerd Tree
noremap <silent> <Leader>n :NERDTreeToggle<CR>
" Reveal in Nerd Tree
noremap <silent> <Leader>. :NERDTreeFind<CR>
" ALE commands
noremap <silent> <Leader>d :ALEGoToDefinition<CR>
noremap <silent> <Leader>r :ALERename<CR>
noremap <silent> <Leader>R :ALEFindReferences -relative<CR>
" Autofix entire buffer with eslint_d:
nnoremap <leader>f mF:%!eslint_d --stdin --fix-to-stdout<CR>`F
" Autofix visual selection with eslint_d:
vnoremap <leader>f :!eslint_d --stdin --fix-to-stdout<CR>gv
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
let g:airline#extensions#default#layout = [
    \ [ 'a', 'b', 'c' ],
    \ [ 'y', 'z', 'error', 'warning' ]
  \ ]
let g:airline#extensions#default#section_truncate_width={
  \ 'b' : 88,
  \ 'x' : 110,
  \ 'y' : 130,
  \ 'z' : 88
  \ }
let g:airline_skip_empty_sections = 1
let g:airline#extensions#branch#displayed_head_limit = 12
let g:airline#extensions#tmuxline#snapshot_file = '~/.tmux/tmuxline.conf'
let g:airline#extensions#ale#error_symbol = ''
let g:airline#extensions#ale#warning_symbol = ''
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.dirty = '*'

" Bufferline
let g:bufferline_echo           = 0
let g:bufferline_rotate         = 1
let g:bufferline_fixed_index    = -1
let g:bufferline_solo_highlight = 1
let g:bufferline_fname_mod      = ':r:s?/index??:t'
" Tmuxline
let g:tmuxline_theme  = 'zenburn'
let g:tmuxline_preset = {
  \ 'a'    : '#(hostname -s)',
  \ 'win'  : ['#I #W'],
  \ 'cwin' : ['#I #W'],
  \ 'x'    : '%d. %b',
  \ 'z'    : '%R'
  \ }
" Snipmate
let g:snipMate = get(g:, 'snipMate', {}) " Allow for vimrc re-sourcing
let g:snipMate.scope_aliases = {
  \ 'typescript': 'javascript',
  \ 'typescriptreact': 'javascript'
  \ }
let g:snipMate.snippet_version = 1
" delimitMate
let g:delimitMate_balance_matchpairs = 1
" NERDtree
let g:NERDTreeMinimalUI        = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeWinSize          = 36
let g:NERDTreeSyntaxDisableDefaultPatternMatches = 1
" DevIcons
let g:DevIconsEnableFoldersOpenClose = 1
" Ale
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✖'
let g:ale_sign_warning = ''
let g:ale_linters_explicit = 1
let g:ale_linters = {
  \ 'javascript'      : ['eslint', 'tsserver'],
  \ 'javascriptreact' : ['eslint', 'tsserver'],
  \ 'typescript'      : ['eslint', 'tsserver'],
  \ 'typescriptreact' : ['eslint', 'tsserver']
  \ }
" Only use LSP on JS files, ignore messages:
let g:ale_linters_ignore = {
  \ 'javascript'      : ['tsserver'],
  \ 'javascriptreact' : ['tsserver']
  \ }
let g:ale_fixers = {
  \ '*'               : ['remove_trailing_lines', 'trim_whitespace'],
  \ 'javascript'      : ['prettier'],
  \ 'javascriptreact' : ['prettier'],
  \ 'typescript'      : ['prettier'],
  \ 'typescriptreact' : ['prettier'],
  \ 'css'             : ['prettier'],
  \ 'html'            : ['prettier'],
  \ 'json'            : ['prettier'],
  \ 'markdown'        : ['prettier'],
  \ 'scss'            : ['prettier'],
  \ 'terraform'       : ['terraform'],
  \ 'yaml'            : ['prettier']
  \ }
let g:ale_lint_on_save = 1
let g:ale_fix_on_save  = 1
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_javascript_eslint_use_global = 1
let g:ale_completion_enabled = 1
" Gitgutter
let g:gitgutter_sign_priority         = 0
let g:gitgutter_sign_added            = '┃'
let g:gitgutter_sign_modified         = '┃'
let g:gitgutter_sign_removed          = '┃'
let g:gitgutter_sign_modified_removed = '┃'
" Ctrlp
let g:ctrlp_open_multiple_files = '1'
" ag
if executable('ag')
  " Use ag for ctrlp
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " Use ag for ack
  let g:ackprg = 'ag --vimgrep --literal'
endif
