# ~/.profile: executed by the command interpreter for login shells.

# set PATH so it includes user's private bin directories
[ -d "$HOME/.local/bin" ] && export PATH="$PATH:$HOME/.local/bin"
[ -d "$HOME/bin" ] && export PATH="$PATH:$HOME/bin"
[ -d "$HOME/.npm-global/bin" ] && export PATH="$PATH:$HOME/.npm-global/bin"
[ -d "$HOME/.nimble/bin" ] && export PATH="$PATH:$HOME/.nimble/bin"
[ -d "$HOME/code/Nim/bin" ] && export PATH="$PATH:$HOME/code/Nim/bin"
[ -d "/usr/local/go/bin" ] && export PATH="$PATH:/usr/local/go/bin"

[ -x "$(command -v setxkbmap)" ] && setxkbmap us

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
