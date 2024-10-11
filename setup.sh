#!/usr/bin/env bash

set -x -e

# get directory this script is in
dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

pushd $dir
git submodule update --init
popd

# link up git dotfiles to home dotfiles
if [ ! -f ~/.gitconfig ]; then
    ln -sf $dir/gitconfig ~/.gitconfig
else
    if ! grep "/gitconfig" ~/.gitconfig; then
        cat <<EOF >>~/.gitconfig
[include]
    path = $dir/gitconfig
EOF
    fi
fi

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
    sudo apt install -y fasd direnv gpg gettext ripgrep xsel bat htop
    sudo mkdir -p /etc/apt/keyrings

    # install eza from source
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza

    pushd $(mktemp -d)
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    popd

    git clone -b stable https://github.com/neovim/neovim ~/src/neovim

    pushd ~/src/neovim
    sudo make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
    popd

    nvim --headless "+Lazy! restore" +qa

    if [ -d "/usr/local/go" ]; then
        mkdir -p /usr/lib/
        ln -sf /usr/local/go /usr/lib
    fi
    ;;
Darwin*) ;;
esac
