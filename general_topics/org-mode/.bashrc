# Enable tab completion
source ~/git-completion.bash
# export PATH="$HOME/miniconda3/bin:$PATH"
# colors!
green="\[\033[0;32m\]"
blue="\[\033[0;34m\]"
purple="\[\033[0;35m\]"
reset="\[\033[0m\]"

# Change command prompt
source ~/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
# '\u' adds the name of the current user to the prompt
# '\$(__git_ps1)' adds git-related stuff
# '\W' adds the name of the current directory
export PS1="$purple\u$green\$(__git_ps1)$blue \W $ $reset"
PATH=/usr/racket/bin:$PATH
# export PATH="~/.cargo/bin:$PATH"
# export PATH="/home/dinesh/.cask/bin:$PATH"
# export PATH="/home/dinesh/.edm/envs/edm/bin:$PATH"
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

alias ..="cd .."
alias ...="cd ..."
alias sl="ls"
alias l="ls"
alias s="ls"
alias p="pysph view"

# added by Miniconda3 4.1.11 installer
export PATH="/home/dinesh/anaconda2/bin:$PATH"
# export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export PATH="/home/dinesh/blender-2.78c-linux-glibc219-x86_64:$PATH"
export PATH="/home/dinesh/.edm/envs/edm/bin:$PATH"
