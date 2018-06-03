" the root initializer

" get the plugin manager if we dont have it
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Note: This line MUST come before any <leader> mappings
let g:mapleader=","

" load the rest of the config
source $HOME/.config/nvim/plugins.vimrc
source $HOME/.config/nvim/bindings.vimrc
source $HOME/.config/nvim/general.vimrc
source $HOME/.config/nvim/colors.vim
