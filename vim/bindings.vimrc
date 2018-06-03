" ----------------------------------------
" Bindings
" ----------------------------------------

"make neovim terminal useful
tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
" nnoremap <A-h> <C-w>h
" nnoremap <A-j> <C-w>j
" nnoremap <A-k> <C-w>k
" nnoremap <A-l> <C-w>l

" clang format with ctrl-k works real good in visual mode hopefully?
map <C-K> :pyf /usr/share/clang/clang-format-3.8/clang-format.py<cr>

" replace word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
" function! s:buflist()
"   redir => ls
"   silent ls
"   redir END
"   return split(ls, '\n')
" endfunction

" function! s:bufopen(e)
"   execute 'buffer' matchstr(a:e, '^[ 0-9]*')
" endfunction

" fzf remaps
nnoremap <C-p>     :FZFFiles<cr>
nnoremap <leader>f :FZFFiles<cr>
nnoremap <leader>m :FZFHistory<cr>
nnoremap <leader>T :FZFBTags<cr>
nnoremap <leader>t :FZFTags<cr>
nnoremap <leader>l :FZFLines<cr>
nnoremap <leader>L :FZFBLines<cr>
nnoremap <leader>b :FZFBuffers<cr>
nnoremap <leader>r :FZFRg<cr>

nmap <C-\> :TagbarToggle<CR>

set pastetoggle=<F6>
map <F6> :set invpaste<CR>:set paste?<CR>

nnoremap j gj
nnoremap k gk
" }}}

" incsearch {{{
set hlsearch
set incsearch
" }}}

" Common typos {{{
command! W w
command! Q q
command! Qa qa
command! QA qa
command! WQ wq
command! Wq wq
command! Wqa wqa
command! WQa wqa
command! WQA wqa
command! Vs vs

" its all about that key repeat
imap jjj <Esc>
imap kkk <Esc>

" Remove doc lookup binding because it's easy to fat finger
map <F1> <Esc>
imap <F1> <Esc>

" hold down control and use directions to change splits
nnoremap <silent> <C-l> <c-w>l
nnoremap <silent> <C-h> <c-w>h
nnoremap <silent> <C-k> <c-w>k
nnoremap <silent> <C-j> <c-w>j
nnoremap <silent> <C-Right> <c-w>l
nnoremap <silent> <C-Left> <c-w>h
nnoremap <silent> <C-Up> <c-w>k
nnoremap <silent> <C-Down> <c-w>j

" }}}

" Other {{{
" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14

vnoremap < <gv
vnoremap > >gv
" make Y consistent with C and D. See :help Y.
nnoremap Y y$
" Y in visual mode copies to system clipboard
vmap Y "+y
" }}}

" Open files in current directory {{{
cnoremap %% <C-R>=expand('%:h').'/'<cr>
nmap <leader>e :edit %%
nmap <leader>v :view %%

nnoremap <leader><leader> <c-^>
" }}}

" goto file under cursor {{{
nnoremap <leader>g :IH<cr>
" }}}

" ---------------
" Leader Commands
" ---------------

" {{{ File Jumping
"Move back and forth through previous and next buffers
"with ,z and ,
nnoremap <silent> <leader>z :bp<CR>
nnoremap <silent> <leader>x :bn<CR>
" }}}

" Window {{{
" Window Movement
" Equal Size Windows
nmap <silent> <leader>w= :wincmd =<CR>
" Swap Windows
nmap <silent> <leader>wx :wincmd x<CR>

" Other {{{
map <leader>Y :let @* = expand("%").":".line(".")<CR>:echo "Copied: ".expand("%")<CR>
map <leader>C :let @* = expand("%").":".line(".")<CR>:echo "Copied: ".expand("%").":".line(".")<CR>
" }}}
