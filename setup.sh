#!/bin/bash

set -x -e

# get directory this script is in
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# link up git dotfiles to home dotfiles
ln -sf $dir/.bash_profile ~/.bash_profile
ln -sf $dir/.gitconfig ~/.gitconfig

# install brew of some kind
# OSX: ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# linux:
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
PATH="$HOME/.linuxbrew/bin:$PATH"

# install nvim
brew install neovim/neovim/neovim

# verify this works when there's already shit here...
rm -rf ~/.config/nvim
mkdir -p ~/.config/nvim
ln -s $dir/vim ~/.config/nvim

# command line utilities
brew install git
brew install fasd
brew install ag
brew install jq
brew install aria2
brew install bash-git-prompt

# iterm shell integration
curl -L https://iterm2.com/misc/`basename $SHELL`_startup.in \
-o ~/.iterm2_shell_integration.`basename $SHELL`
