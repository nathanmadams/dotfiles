source ~/.bashrc

#adjust socket location for SSH agent forwarding if we're in the arbos chroot
if [[ -d "/arbos-tmp" && -n $SSH_AUTH_SOCK ]]; then
    if [[ ! $SSH_AUTH_SOCK = /arbos-tmp* ]]; then
        SSH_AUTH_SOCK=$(echo $SSH_AUTH_SOCK | sed 's/tmp/arbos-tmp/')
    fi
fi
