#!/usr/bin/env bash

set -x -e

# get directory this script is in
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# link up git dotfiles to home dotfiles
ln -sf $dir/.gitconfig ~/.gitconfig
ln -sf $dir/zsh/zshrc ~/.zshrc
ln -sf $dir/i3/config ~/.i3/config
ln -sf $dir/i3/.i3status.conf ~/.i3status.conf
ln -sf $dir/Xresources ~/.Xresources
ln -sf $dir/.spacemacs ~/.spacemacs
