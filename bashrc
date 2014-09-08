export PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] "

export ARBSVN="svn+ssh://svnuser@svn.arbor.net"
alias ls='ls -G'
alias ll='ls -la'

alias tl='tail -500 /var/log/syslog'

if [[ "$OSTYPE" == "darwin"* ]]; then
    export CLICOLOR=1
    export LSCOLORS=GxFxCxDxBxegedabagaced

    source .bash/arbordev
else
    alias ls='ls --color'
fi
