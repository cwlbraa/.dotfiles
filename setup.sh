#!/usr/bin/env bash

set -x -e

# get directory this script is in
dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

pushd $dir
git submodule update --init
popd

# link up git dotfiles to home dotfiles
ln -sf $dir/.gitconfig ~/.gitconfig
ln -sf $dir/zsh/zshrc ~/.zshrc
ln -sf $dir/Xresources ~/.Xresources
ln -sf $dir/nvim ~/.config/
ln -sf $dir/.ideavimrc ~/.ideavimrc
ln -sf $dir/.p10k.zsh ~/.p10k.zsh

case "$(uname -s)" in
Linux*)
	mkdir -p ~/.i3/config
	ln -sf $dir/i3/config ~/.i3/config
	ln -sf $dir/i3/.i3status.conf ~/.i3status.conf
	apt update
	apt install fasd
	;;
Darwin*) ;;
esac
