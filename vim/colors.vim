let &t_Co=256

let g:base16_shell_path=$HOME.'/.vim/scripts/base16-shell/scripts'

let s:colors = [
      \ 'hybrid',
      \ 'gruvbox',
      \ ]

function! colors#_change(index)
  let l:idx = a:index
  if idx < 0
    let l:idx = len(s:colors) - 1
  elseif idx > len(s:colors) - 1
    let l:idx = 0
  endif

  let l:name = s:colors[idx]
  silent! execute "colorscheme ".name
endfunction

function! colors#_callback()
  let l:name = g:colors_name
  if !has('gui_running') && name == 'hybrid'
    silent !bash $HOME/.vim/scripts/shell-colors-vim-hybrid/shell-colors-vim-hybrid.sh
  endif
  if !has('gui_running') && name == 'gruvbox'
    let g:gruvbox_italic=1
    silent !bash $HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh
  endif
  hi MatchParen cterm=underline ctermbg=none ctermfg=none gui=underline guifg=NONE guibg=NONE
endfunction


function! colors#next()
  let l:next_index = index(s:colors, g:colors_name) + 1
  call colors#_change(next_index)
endfunction

function! colors#prev()
  let l:prev_index = index(s:colors, g:colors_name) - 1
  call colors#_change(prev_index)
endfunction

function! colors#toggle_background()
  if &background == 'light'
    set background=dark
  else
    set background=light
  endif
endfunction

function! colors#peek()
  echo g:colors_name . ' - ' . &background
endfunction

command! ColorsPrev call colors#prev()
command! ColorsNext call colors#next()
command! ColorsToggleBG call colors#toggle_background()
command! ColorsPeek call colors#peek()

map <silent><F2> :ColorsPrev<cr>
map <silent><F3> :ColorsNext<cr>
map <silent><F4> :ColorsToggleBG<cr>
map <silent><F1> :ColorsPeek<cr>
set background=dark

if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
else
  let g:base16colorspace=256
  autocmd! ColorScheme * silent! call colors#_callback()
endif

try
  colorscheme hybrid
catch
  colorscheme evening
endtry
