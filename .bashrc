# ~/.bashrc: executed by bash(1) for non-login shells.
OS=`uname`

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

VIM="$(command -v vim)"

[ -x ~/scoop/shims/gvim ] && VIM="~/scoop/shims/gvim"

export EDITOR=$VIM

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

if [[ "$OS" != "Darwin" ]]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 " (%s)") \$ '
  GIT_PS1_SHOWCOLORHINTS=true
fi

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


[ -x "$(command -v aws_completer)" ] && complete -C $(which aws_completer) aws

[ -f "$HOME/.inputrc" ] && bind -f "$HOME/.inputrc"

[ -x "$(command -v kubectl)" ] && source <(kubectl completion bash)

source ~/dotfiles/git-prompt.sh

if [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

[ -f "$HOME/.bashrc.local" ] && source "$HOME/.bashrc.local"

# Wasmer
export WASMER_DIR="/home/mihai/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

# broot
[ -s "$HOME/.config/broot/launcher/bash/br" ] && source "$HOME/.config/broot/launcher/bash/br"

# The next line updates PATH for the Google Cloud SDK.
[ -s "$HOME/apps/google-cloud-sdk/path.bash.inc" ] && source "$HOME/apps/google-cloud-sdk/path.bash.inc"

# The next line enables shell command completion for gcloud.
[ -s "$HOME/apps/google-cloud-sdk/completion.bash.inc" ] && source "$HOME/apps/google-cloud-sdk/completion.bash.inc"
