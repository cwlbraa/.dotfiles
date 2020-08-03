#!/bin/bash

set -x -e

# get directory this script is in
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# link up git dotfiles to home dotfiles
ln -sf $dir/.gitconfig ~/.gitconfig
ln -sf $dir/zsh/zshrc ~/.zshrc
ln -sf $dir/i3config ~/.i3/config
ln -sf $dir/i3status ~/.i3status.conf
ln -sf $dir/Xresources ~/.Xresources
ln -sf $dir/.spacemacs ~/.spacemacs

# install rust toolchain
# curl https://sh.rustup.rs -sSf | sh
# fast simd ag
#cargo install ripgrep
#export PATH="$HOME/.cargo/bin:$PATH"
