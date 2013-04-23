[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"
[ -f "$HOME/.bash_functions" ] && source "$HOME/.bash_functions"

# completion
if [ -d "/etc/bash_completion.d" ]; then
    for comp_file in /etc/bash_completion.d/*
    do
        echo "loading completion: $comp_file"
        . "$comp_file"
    done
fi

# custom prompt
if test -z "$WINELOADERNOEXEC"
then
	PS1='\[\033]0;$MSYSTEM:\w\007
\033[32m\]\u@\h \[\033[33m\w\033[0m\]
$ '
else
	PS1='\[\033]0;$MSYSTEM:\w\007
\033[32m\]\u@\h \[\033[33m\w$(__git_ps1)\033[0m\]
$ '
fi

# don't add duplicate entries to history
export HISTCONTROL=ignoreboth:erasedups

#export NODE_PATH=/e/projekts/downloaded/node/Release/node_modules

# add user's bin/ to $PATH
PATH="$HOME/bin:$PATH"
