[[ $- == *i* ]] && source ~/.bash_interactive

# unlimited entries in history
export HISTFILESIZE=
export HISTSIZE=

# timestam history entries
export HISTTIMEFORMAT="%d-%m-%Y %T "

# don't add duplicate entries to history
export HISTCONTROL=ignoreboth:erasedups

# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history

# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
shopt -s histappend
stophistory () {
  PROMPT_COMMAND="bash_prompt_command"
  echo 'History recording stopped.'
}

# add user's bin/ to $PATH
PATH="$HOME/bin:$PATH"

# load local bashrc, if existing
[ -f "$HOME/.bashrc_local" ] && source "$HOME/.bashrc_local"

# user-specific settings
_BASH_USER_SETTINGS="$HOME/dotfiles/.bash_user_settings_$USER"
[ -f "$_BASH_USER_SETTINGS" ] && source "$_BASH_USER_SETTINGS"

export EDITOR=vim

MDS="10.255.160.224"
#SEO_CI_IP="10.225.160.97"
SEO_CI_IP="seo-ci.cloud.platforms.gamesys.corp"
MONOPOLY_DB_IP="monopoly-db.cloud.platforms.gamesys.corp"
L3="http://localhost:3000"
