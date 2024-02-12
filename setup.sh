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
	sudo apt update
	sudo apt install -y fasd direnv gpg
	sudo mkdir -p /etc/apt/keyrings

	# install eza from source
	wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
	echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
	sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
	sudo apt update
	sudo apt install -y eza

	git clone https://github.com/neovim/neovim ~/src/neovim

	pushd ~/src/neovim
	make CMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make install
	popd
	;;
Darwin*) ;;
esac
