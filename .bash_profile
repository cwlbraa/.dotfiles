
# neovim setup
alias vim=nvim

# fasd init
eval "$(fasd --init auto)"

# partial up arrow bash completion
echo '# arrow up
"\e[A":history-search-backward
## arrow down
"\e[B":history-search-forward' > ~/.inputrc

# shell color
export CLICOLOR=1

# aliases
alias gst='git status'

# git autocomplete
source ~/.dotfiles/git-completion.bash

# install bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi
