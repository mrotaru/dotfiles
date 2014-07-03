[[ $- == *i* ]] && source .bash_interactive

# unlimited entries in history
export HISTFILESIZE=
export HISTSIZE=

# timestam history entries
export HISTTIMEFORMAT="%d-%m-%Y %T "

# don't add duplicate entries to history
export HISTCONTROL=ignoreboth:erasedups

# add user's bin/ to $PATH
PATH="$HOME/bin:$PATH"
