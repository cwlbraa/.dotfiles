" ----------------------------------------
" Regular Vim Configuration (No Plugins Needed)
" ----------------------------------------

" filetypes
autocmd BufNewFile,BufRead *.cppt,*.ht,*.cpptx,*.htx   set syntax=cpp
autocmd BufNewFile,BufRead *.cppt,*.ht,*.cpptx,*.htx   set filetype=cpp
autocmd BufNewFile,BufRead *.mkt,         set filetype=make

" the big hax
nnoremap ; :

" Config {{{
if has('persistent_undo')
  set undofile
  set undodir=~/.vim/.undo
endif

" We rely on bash for some things, make sure we use that for shelling out
set shell=/bin/bash
" }}}

" Backups {{{
set swapfile                    " Keep swapfiles
set directory=~/.vim-tmp,~/tmp,/var/tmp,/tmp
set backupdir=~/.vim-tmp,~/tmp,/var/tmp,/tmp
" }}}

" UI {{{
set nu             " Line numbers on
set nowrap         " Line wrapping off
set cmdheight=1    " Make the command area two lines high
set noshowmode     " don't need to show mode since we have airline
set numberwidth=4
set encoding=utf-8
set guioptions=acg
set cursorline
set lazyredraw
set guicursor=
" }}}

" Behaviors {{{
filetype plugin indent on  " Automatically detect file types. (must turn on after Vundle)
set wildmode=list:longest " use emacs-style tab completion when selecting files, etc
set hidden             " Change buffer - without saving
set autowriteall       " Writes on make/shell commands
set foldmethod=syntax
set foldlevel=20
set formatoptions=crql
set iskeyword+=$,@,-     " Add extra characters that are valid parts of variables
set splitright
if version >= 704
  set completeopt=menu,noinsert,noselect
endif
" }}}

" Text Format {{{
set tabstop=6
set shiftwidth=4 " Tabs under smart indent
set softtabstop=4 " Tabs under smart indent
set expandtab
" }}}

" Searching {{{
set ignorecase
set smartcase  " Non-case sensitive search
set hlsearch
set wildignore+=.final_builds/*,*/node_modules/*,*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.sass-cache,*.class,*.scssc,*/Godeps/*
if executable('rg')
  set grepprg=rg\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
elseif executable('ag')
  set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
  set grepformat=%f:%l:%c:%m
endif
if exists('&inccommand')
  set inccommand=split
endif
" }}}

" Visual {{{
set noshowmatch " Disable jumping to matching bracket when typing
" }}}

" Sounds {{{
set noerrorbells
set novisualbell
" }}}

" Mouse {{{
set mousehide  " Hide mouse after chars typed
set mouse=a  " Mouse in all modes
" }}}

" deoplete {{{
let g:deoplete#enable_at_startup = 1

let g:deoplete#omni_patterns = {}

" autocomplete on just about any character
let g:deoplete#omni_patterns.go = '[a-zA-Z_\.]{3,}'

" autocomplete only on attributes; doesn't seem to complete local vars
let g:deoplete#omni_patterns.elm = '\.'

" tab for cycling through options
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" enter closes options if present and inserts linebreak
" apparently this has to be that complicated
inoremap <silent> <CR> <C-r>=<SID>close_and_linebreak()<CR>
function! s:close_and_linebreak()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction

" }}}

" neomake {{{
" open list automatically but preserve cursor position
let g:neomake_open_list = 2
let g:neomake_list_height = 5
" }}}

" clang-check {{{
function! ClangCheckImpl(cmd)
  if &autowrite | wall | endif
  echo "Running " . a:cmd . " ..."
  let l:output = system(a:cmd)
  cexpr l:output
  cwindow
  let w:quickfix_title = a:cmd
  if v:shell_error != 0
    cc
  endif
  let g:clang_check_last_cmd = a:cmd
endfunction

function! ClangCheck()
  let l:filename = expand('%')
  if l:filename =~ '\.\(cpp\|cxx\|cc\|c\)$'
    call ClangCheckImpl("clang-check -p build/compile_commands.json " . l:filename)
  elseif exists("g:clang_check_last_cmd")
    call ClangCheckImpl(g:clang_check_last_cmd)
  else
    echo "Can't detect file's compilation arguments and no previous clang-check invocation!"
  endif
endfunction

nmap <silent> <F5> :call ClangCheck()<CR><CR>
" }}}
