# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="%d-%m-%Y %T "
export HISTCONTROL=ignoreboth:erasedups
export HISTFILE=~/.bash_eternal_history
shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
stophistory () {
  PROMPT_COMMAND="bash_prompt_command"
  echo 'History recording stopped.'
}

export PATH="$HOME/bin:$PATH"

[ -f "$HOME/.bashrc_local" ] && source "$HOME/.bashrc_local"

export EDITOR=vim

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

source ~/dotfiles/git-prompt.sh
