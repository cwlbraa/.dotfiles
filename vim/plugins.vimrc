" plugins
call plug#begin('~/.vim/plugged')

" Navigation {{{
  " A tree explorer plugin for vim
  Plug 'scrooloose/nerdtree'

  " Displays tags in a window, ordered by scope
  Plug 'majutsushi/tagbar'

  " <leader>a to swap between header and impl
  Plug 'vim-scripts/FSwitch'
  " {{{
  nmap <silent> <leader>a :FSHere<cr>
  augroup mycppfiles
    au!
    au BufEnter *.h let b:fswitchdst  = 'cpp,cc,C'
    au BufEnter *.h let b:fswitchlocs = 'reg:|include|src|,reg:|include.*|src/**|'
    au BufEnter *.cpp let b:fswitchdst  = 'h'
    au BufEnter *.cpp let b:fswitchlocs = 'reg:|src|include|,reg:|src.*|include/**|'
    au BufEnter *.ht let b:fswitchdst  = 'cppt'
    au BufEnter *.ht let b:fswitchlocs = 'reg:|include|src|,reg:|include.*|src/**|'
    au BufEnter *.cppt let b:fswitchdst  = 'ht'
    au BufEnter *.cppt let b:fswitchlocs = 'reg:|src|include|,reg:|src.*|include/**|'
  augroup END
  " }}}


  " A command-line fuzzy finder written in Go
  let g:fzf_command_prefix = 'FZF'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
  command! -bang -nargs=* FZFRg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading -u --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

  " Add emacs/bash/cocoa key bindings to vim, in insert and command-line modes.
  Plug 'maxbrunsfeld/vim-emacs-bindings'

  " open filename:lineno
  Plug 'bogado/file-line'

  " run a command in a terminal split
  Plug 'vimlab/split-term.vim'
" }}}

" UI Additions {{{
  " rainbow parentheses improved, shorter code, no level limit, smooth and fast, powerful configuration.
  Plug 'luochen1990/rainbow'
  let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
  let g:rainbow_conf = {
  \   'operators': '_,\|=\|+\|\*\|-\|\.\|;\||\|&\|?\|:\|<\|>\|%\|<<\|>>\|!_',
  \   'parentheses': [['(', ')'], ['\[', '\]'], ['{', '}']],
  \   'separately': {
  \       '*': {},
  \       'html': {
  \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
  \       },
  \       'css': 0,
  \   }
  \}

  " Colors {{{
    Plug 'dolio/vim-hybrid'
    Plug 'morhetz/gruvbox'
    let g:gruvbox_contrast_dark = "hard"
    let g:gruvbox_invert_signs = 1
    let g:gruvbox_invert_tabline = 1
    Plug 'flazz/vim-colorschemes'
  " }}}

  " lean & mean status/tabline for vim that's light as air
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1

  " Better whitespace highlighting for Vim
  Plug 'ntpeters/vim-better-whitespace'
  " detect indent and set buffer options
  Plug 'tpope/vim-sleuth'
  " visible tabs
  set listchars=tab:>-
  set list

  " rainbow parentheses improved, shorter code, no level limit, smooth and fast, powerful configuration.
  Plug 'luochen1990/rainbow'
  let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
  let g:rainbow_conf = {
  \   'operators': '_,\|=\|+\|\*\|-\|\.\|;\||\|&\|?\|:\|<\|>\|%\|<<\|>>\|!_',
  \   'parentheses': [['(', ')'], ['\[', '\]'], ['{', '}']],
  \   'separately': {
  \       '*': {},
  \       'cpp': {
  \             'parentheses': [['(', ')'], ['\[', '\]'], ['{', '}']],
  \       },
  \       'tex': {
  \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
  \       },
  \       'lisp': {
  \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
  \       },
  \       'vim': {
  \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
  \       },
  \       'html': {
  \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
  \       },
  \       'css': 0,
  \   }
  \}
" }}}

" Commands {{{

  " comment stuff out (via leader-/)
  Plug 'tpope/vim-commentary'
  autocmd FileType c,cpp,cs,java          setlocal commentstring=//\ %s

  " quoting/parenthesizing made simple; e.g. ysiw) to wrap word in parens
  Plug 'tpope/vim-surround'
  " easily search for, substitute, and abbreviate multiple variants of a word
  Plug 'tpope/vim-abolish'
  " Vim sugar for the UNIX shell commands that need it the most; e.g. :Find, :Wall
  Plug 'tpope/vim-eunuch'


  " a Git wrapper so awesome, it should be illegal; :Gblame, etc
  Plug 'tpope/vim-fugitive' " my version has submodule-ctags hacked into it
  " git changes in gutter
  Plug 'airblade/vim-gitgutter'

  " incremental search highlighting is the swaggiest swag
  " Plug 'haya14busa/incsearch.vim'

  " Vim script for text filtering and alignment; e.g. :Tabularize /,
  Plug 'godlygeek/tabular'

  " Vim plugin for the_silver_searcher, 'ag', a replacement for the Perl module / CLI script 'ack'
  Plug 'Numkil/ag.nvim'
  let g:ag_prg="rg --vimgrep --no-heading --smart-case -u"
" }}}

" Automatic Helpers {{{
  " wisely add "end" in ruby, endfunction/endif/more in vim script, etc
  Plug 'tpope/vim-endwise'

  " enable repeating supported plugin maps with '.'
  Plug 'tpope/vim-repeat'

   " provides an asynchronous keyword completion system in the current buffer
   Plug 'Shougo/deoplete.nvim'
   Plug 'Shougo/neopairs.vim'
   let g:deoplete#omni_input_patterns = {}
   let g:deoplete#omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

   " Speed up Vim by updating folds only when called-for.
   let g:fastfold_savehook = 0
   let g:fastfold_fold_command_suffixes = []
   let g:fastfold_fold_movement_commands = []
   Plug 'Konfekt/FastFold'
" }}}

" Language specific {{{

  " Go {{{
    Plug 'fatih/vim-go'
    Plug 'godoctor/godoctor.vim'
  " }}}

  " Rust {{{
    Plug 'rust-lang/rust.vim'
    let g:rustfmt_autosave = 1
    Plug 'sebastianmarkow/deoplete-rust'
    let g:deoplete#sources#rust#racer_binary='/home/cbraa/.cargo/bin/racer'
    let g:deoplete#sources#rust#rust_source_path='/home/cbraa/ws/rust/rust/src'
    Plug 'neomake/neomake'
    let g:neomake_ft_maker_remove_invalid_entries = 0
    autocmd BufWritePost *.rs Neomake! cargo
  " }}}

  " A solid language pack for Vim.
  " Adds 70+ languages and optimizes loading and installing.
    Plug 'sheerun/vim-polyglot'
" }}}

call plug#end()
