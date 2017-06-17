source ~/.bashrc

#adjust socket location for SSH agent forwarding if we're in the arbos chroot
if [[ -d "/arbos-tmp" && -n $SSH_AUTH_SOCK ]]; then
    if [[ ! $SSH_AUTH_SOCK = /arbos-tmp* ]]; then
        SSH_AUTH_SOCK=$(echo $SSH_AUTH_SOCK | sed 's/tmp/arbos-tmp/')
    fi
fi

export PATH="/usr/local/bin:$PATH"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
