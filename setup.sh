#!/bin/bash

set -x -e

# get directory this script is in
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# link up git dotfiles to home dotfiles
ln -sf $dir/.bash_profile ~/.bash_profile
ln -sf $dir/.gitconfig ~/.gitconfig
ln -sf $dir/zsh/zshrc ~/.zshrc
mkdir -p ~/.config/terminator/ # obvi unnecessary on mac but whatever
ln -sf $dir/terminator/config ~/.config/terminator/

# install brew of some kind
# OSX: ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# linux:
#ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
PATH="$HOME/.linuxbrew/bin:$PATH"

# install rust toolchain
curl https://sh.rustup.rs -sSf | sh
# fast simd ag
cargo install ripgrep
export PATH="$HOME/.cargo/bin:$PATH"

# install nvim
if ! brew install neovim/neovim/neovim
    then echo "neovim depends on gperf"; fi

# verify this works when there's already shit here...
rm -rf ~/.config/nvim
mkdir -p ~/.config/
ln -s $dir/vim ~/.config/nvim

# command line utilities
brew install git
brew install fasd
brew install jq
brew install aria2
brew install bash-git-prompt
# we could add zsh here later if it seems like a good idea...

brew tap universal-ctags/universal-ctags
brew install universal-ctags/universal-ctags
