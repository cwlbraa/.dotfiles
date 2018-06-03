#!/bin/bash

set -x -e

# get directory this script is in
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# link up git dotfiles to home dotfiles
ln -sf $dir/.gitconfig ~/.gitconfig
ln -sf $dir/zsh/zshrc ~/.zshrc
ln -sf $dir/i3config ~/.i3/config
ln -sf $dir/Xresources ~/.Xresources

# install rust toolchain
# curl https://sh.rustup.rs -sSf | sh
# fast simd ag
#cargo install ripgrep
#export PATH="$HOME/.cargo/bin:$PATH"

# verify this works when there's already shit here...
rm -rf ~/.config/nvim
mkdir -p ~/.config/
ln -s $dir/vim ~/.config/nvim

# command line utilities
#brew install git
#brew install jq
#
#brew tap universal-ctags/universal-ctags
#brew install universal-ctags/universal-ctags
