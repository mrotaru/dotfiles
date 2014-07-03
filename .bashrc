[[ $- == *i* ]] && source .bash_interactive

# don't add duplicate entries to history
export HISTCONTROL=ignoreboth:erasedups

# add user's bin/ to $PATH
PATH="$HOME/bin:$PATH"
