if [ -r ~/.profile ]; then . ~/.profile; fi
case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac
[[ $- == *i* ]] && stty -ixon
. "$HOME/.cargo/env"
