#!/bin/bash

export PATH="$HOME/.linuxbrew/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# neovim setup
alias emc="emacsclient -c"
export VISUAL="emacsclient -c"
export EDITOR="emacsclient -t"
alias vim=emc

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
alias g='rg'
alias cleanswap='rm -rf /var/tmp/*.swp'

type pbcopy >/dev/null 2>&1 || alias pbcopy='xsel --clipboard --input'
type pbpaste >/dev/null 2>&1 || alias pbpaste='xsel --clipboard --output'

# git autocomplete
source ~/.dotfiles/git-completion.bash

# install bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# populates v v fast
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_CTRL_R_OPTS='--sort'

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# do this last because fzf, git-bash-prompt, iterm, etc, muck with $PROMPT_COMMAND
PROMPT_COMMAND="$PROMPT_COMMAND history -a;"

# PS1 import
if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

# do this extra last because other changes to te prompt can clobber it
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || [ "$TERM_PROGRAM" = "iTerm.app" ]; then
    source ~/.iterm2_shell_integration.`basename $SHELL`
fi

