# ~/.profile: executed by the command interpreter for login shells.

# set PATH so it includes user's private bin directories
if [ -d "$HOME/.npm-global/bin" ]; then
    export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.npm-global/bin:$HOME/.nimble/bin:$PATH"
fi

# Nim binaries
if [ -d "$HOME/code/Nim/bin" ]; then
    export PATH="$PATH:$HOME/code/Nim/bin"
fi

# go binaries
if [ -d "/usr/local/go/bin" ]; then
    export PATH="$PATH:/usr/local/go/bin"
fi

[ -x "$(command -v setxkbmap)" ] && setxkbmap us

# https://help.github.com/en/github/authenticating-to-github/working-with-ssh-key-passphrases#auto-launching-ssh-agent-on-git-for-windows 

env=~/.ssh/agent.env

agent_load_env () {
    test -f "$env" && . "$env" >| /dev/null ;
}

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ;
}

agent_load_env

agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?) # ->
    # 0 - running with key
    # 1 - running without key
    # 2 - not running

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env

[ -f "$HOME/.inputrc.local" ] && source "$HOME/.inputrc.local"

[ -f "$HOME/.profile.local" ] && source "$HOME/.profile.local"
. "$HOME/.cargo/env"
