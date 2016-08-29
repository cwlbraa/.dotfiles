#!/bin/bash
set -x

# get directory this script is in
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# link up git dotfiles to home dotfiles
ln -s $dir/.bash_profile ~/.bash_profile 
ln -s $dir/.gitconfig ~/.gitconfig 

# install brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install nvim
brew install nvim/nvim/nvim
ln -s .vimrc .nvimrc
ln -s .vim .nvim

# command line utilities
brew install git
brew install fasd
brew install ag
brew install jq
brew install aria2
brew install bash-git-prompt
