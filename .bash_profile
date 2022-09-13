if [ -r ~/.profile ]; then . ~/.profile; fi
case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac
[[ $- == *i* ]] && stty -ixon

[ -s "$HOME/.cargo/env" ] && 
[ -s "$HOME/.config/broot/launcher/bash/br" ] && source "$HOME/.config/broot/launcher/bash/br"
. "$HOME/.cargo/env"
