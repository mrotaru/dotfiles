# ~/.profile: executed by the command interpreter for login shells.

# set PATH so it includes user's private bin directories
[ -d "$HOME/.local/bin" ] && export PATH="$PATH:$HOME/.local/bin"
[ -d "$HOME/bin" ] && export PATH="$PATH:$HOME/bin"
[ -d "$HOME/.npm-global/bin" ] && export PATH="$PATH:$HOME/.npm-global/bin"
[ -d "$HOME/.nimble/bin" ] && export PATH="$PATH:$HOME/.nimble/bin"
[ -d "$HOME/code/Nim/bin" ] && export PATH="$PATH:$HOME/code/Nim/bin"
[ -d "/usr/local/go/bin" ] && export PATH="$PATH:/usr/local/go/bin"

if [ -d "$HOME/.npm-global/bin" ]; then
    export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.npm-global/bin:$HOME/.nimble/bin"
fi

# Nim binaries
if [ -d "$HOME/code/Nim/bin" ]; then
    export PATH="$PATH:$HOME/code/Nim/bin"
fi

[ -x "$(command -v setxkbmap)" ] && setxkbmap us

[ -x "$(command -v rg)" ] && export RIPGREP_CONFIG_PATH=~/.ripgreprc

# https://help.github.com/en/github/authenticating-to-github/working-with-ssh-key-passphrases#auto-launching-ssh-agent-on-git-for-windows 
if [[ "$OSTYPE" == "msys" ]]; then
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
fi

[ -s "$HOME/.inputrc.local" ] && source "$HOME/.inputrc.local"
[ -s "$HOME/.profile.local" ] && source "$HOME/.profile.local"
[ -s "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
[ -f "$HOME/.profile.local" ] && source "$HOME/.profile.local"

[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
[ -d "$HOME/.rvm/bin" ] && export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

[ -x "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
 
