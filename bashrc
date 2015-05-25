export PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] "

export ARBSVN="svn+ssh://svnuser@svn.arbor.net"
alias ls='ls -G'
alias ll='ls -la'

alias tl='tail -500 /var/log/syslog'

alias psa-syslog='cat /var/log/syslog | grep -vE "kernel|redis|CRON|dhclient|sshd|rsyslogd|auditcomsh" | less'

alias dl='devbox_login'
alias push_env='devbox_setup'

alias glog='git log --color --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset'\'' --abbrev-commit'

if [[ "$OSTYPE" == "darwin"* ]]; then
    export CLICOLOR=1
    export LSCOLORS=GxFxCxDxBxegedabagaced

    export PATH="$PATH:$HOME/dotfiles/bin"
else
    alias ls='ls --color'
    LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
    export LS_COLORS
fi

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export NVM_DIR="/Users/nadams/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
