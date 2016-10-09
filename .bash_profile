#!/bin/bash

export PATH="$HOME/.linuxbrew/bin:$PATH"

# neovim setup
alias vim=nvim
export EDITOR=nvim

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

# PS1 import
if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || [ "$TERM_PROGRAM" = "iTerm.app" ]; then
    source ~/.iterm2_shell_integration.`basename $SHELL`
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# do this last because fzf, git-bash-prompt, iterm, etc, muck with $PROMPT_COMMAND
PROMPT_COMMAND="$PROMPT_COMMAND; history -a; history -r;"
