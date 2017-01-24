" plugins
call plug#begin('~/.vim/plugged')

" Defaults {{{
  Plug 'tpope/vim-sensible'
  call plug#load('vim-sensible') " allows these settings to be overwritten by other plugins
" }}}

" Navigation {{{
  " A tree explorer plugin for vim
  Plug 'scrooloose/nerdtree'

  " Displays tags in a window, ordered by scope
  Plug 'majutsushi/tagbar'

  " :A to swap between header and impl
  Plug 'vim-scripts/a.vim'
  let g:alternateSearchPath = 'reg:|src|include|g|,reg:|include|src|g|,sfr:../source,sfr:../src,sfr:../include,sfr:../inc'

  " A command-line fuzzy finder written in Go
  let g:fzf_command_prefix = 'FZF'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  " Add emacs/bash/cocoa key bindings to vim, in insert and command-line modes.
  Plug 'maxbrunsfeld/vim-emacs-bindings'

  " open filename:lineno
  Plug 'bogado/file-line'
" }}}

" UI Additions {{{
  " Colors {{{
    Plug 'dolio/vim-hybrid'
    Plug 'morhetz/gruvbox'
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
  Plug 'cwlbraa/vim-fugitive' " my version has submodule-ctags hacked into it
  " git changes in gutter
  Plug 'airblade/vim-gitgutter'

  " incremental search highlighting is the swaggiest swag
  Plug 'haya14busa/incsearch.vim'

  " Vim script for text filtering and alignment; e.g. :Tabularize /,
  Plug 'godlygeek/tabular'

  " Vim plugin for the_silver_searcher, 'ag', a replacement for the Perl module / CLI script 'ack'
  Plug 'Numkil/ag.nvim'
  let g:ag_prg="rg --vimgrep --smart-case"
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
  " }}}

  " A solid language pack for Vim.
  " Adds 70+ languages and optimizes loading and installing.
    Plug 'sheerun/vim-polyglot'
" }}}

call plug#end()
