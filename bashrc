export PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] "

alias ls='ls -G'
alias ll='ls -la'

alias glog='git log --color --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset'\'' --abbrev-commit'

export PATH="$HOME/.rbenv/shims:$PATH:$HOME/dotfiles/bin"

export LESS="-Mr"

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

if [[ "$OSTYPE" == "darwin"* ]]; then
    export CLICOLOR=1
    export LSCOLORS=GxFxCxDxBxegedabagaced
else
    alias ls='ls --color'
    LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
    export LS_COLORS
fi

