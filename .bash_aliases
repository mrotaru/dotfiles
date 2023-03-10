OS=`uname`

#------------------------
# Frequently edited files
#------------------------
alias eb='vim ~/.bashrc'
alias sb='source ~/.bashrc'
alias ea='vim ~/.bash_aliases'
alias eal='vim ~/.bash_aliases.local'
alias sa="source ~/.bash_aliases"
alias ef='vim ~/.bash_functions'
alias ddj='vim $NOTES/diary/$(date -I).md'
alias ddk='vim $NOTES/todos/$(date "+%Y-W%V").md'

#-----------
# Disk usage
#-----------
alias duhs='du -hs'
alias dfh='df -h'
alias duh='find . -maxdepth 1 -exec du -hs {} \;'
alias dus="du -k * | sort -nr | cut -f2 | xargs -d '\n' du -sh"

#--------
# General
#--------
alias e='vim'
alias cls='clear'                    # a bit redunant; use CTRL+L
alias mex='sudo chmod +x'            # make executable
alias rmd='rm -rf'                   # remive folder, recursivelly
alias md='mkdir'
alias nicepath="echo \$PATH | tr ':' '\n'"

#-----------------------------------------------------------------
# Navigation
#-----------------------------------------------------------------
alias ..="cd .."               # parent dir
alias ...="cd ../.."           # grandparent dir
alias ....="cd ../../.."       # 
alias .....="cd ../../../.."   # 
alias -- -="cd -"              # previous dir
alias cddo="cd ~/dotfiles"     # dotfiles
if [[ "$OS" = MINGW* ]]
then
    #alias exp="explorer \"`pwd | sed -e 's:^\/::' | sed -e 's:^\([a-z]\):\1\::' | sed -e 's:\/:\\\\:g'`\""
    alias nav='explorer . 2> /dev/null'
#elif [command -v xdg-open >/dev/null 2>&1  ]; then
elif [ -x "$(command -v xdg-open)" ]; then
    alias nav='xdg-open $(pwd)'
else
    alias nav='nautilus ./ 2> /dev/null'
fi

#-----------------------------------------------------------------
# The 'ls' zoo
#-----------------------------------------------------------------
alias l='ls -CF'
alias l.='ls -d .*'     # list hidden files/folders
alias la='ls -A'     	# list files, including hidden files/folders
alias ll='ls -AlgGht'   # sort by modified time, human-readable 
alias llo='ls -lht'     # like ll, but show owner/group info
alias lld='ls -ludh */' # list directories
alias lsa='ls -A'       # list all files ( including hidden )
alias l='ls -Ct'        # columns; sort by size 
if [[ "$OS" != "Darwin" ]]; then
  alias ls='ls --color=auto'
  alias llr='ls -lAgGht --time-style=+"%H:%M"'
  alias lla='ls -lAgGht --time-style=+"%d-%b-%y"'
else
  alias llr='ls -lAgGht'
  alias lla='ls -lAgGht'
fi

# Windows has no tput
if [[ "$OS" == 'Linux' ]]; then 
    # sort by modified time, human-readable, don't wrap
    alias ll='(tput rmam; ls -lgGht --time-style=+"%d-%b-%y"; tput smam)'
    alias lln='(tput rmam; ls -lgGh --time-style=+"%d-%b-%y"; tput smam)'
fi

#-----------------------------------------------------------------
# git
#-----------------------------------------------------------------

# hub - https://github.com/github/hub
[ -x "$(command -v hub)" ] && { alias git=hub; }

alias gs='git status'
alias gpl='git pull'
alias gps='git push origin HEAD'
alias g='git status'
alias ga='git add'
alias gc='git commit'
alias gb='git branch'
alias gd='git diff'
alias gdp='git diff HEAD^1' # diff from previous commit
alias gdpf='git diff --stat HEAD^1' # show only changed files
alias gcm='git commit -a -v -m'
alias co='git checkout'
alias cop='git checkout -' # same effect as git checkout @{-1}' (number can be used to go back/forward multiple branches)
alias gdc='git diff --cached'
alias gst='git status -s' # git >1.7.0
alias pull='git pull'
alias push='git push'
alias gd='git diff'
alias gca='git commit -v -a'
alias gb='git branch'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gba='git branch -a'
alias gap='git add --patch'
alias gl="git log --pretty=format:'%Cred%h%Creset%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative -n 10"
alias gls="git log --pretty=format:'%Cred%h%Creset%C(yellow)%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative -n 30"
alias gll="git log --pretty=format:'%Cred%h%Creset%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative -n 30"
alias gld="git log --pretty=format:'%Cred%h%Creset%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit -n 10"
alias gla="git log --pretty=format:'%Cred%h%Creset%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias glaa="git log --pretty=format:'%>(20)%an %Cred%h%Creset%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gh='find .git/hooks -type f ! -name "*.sample"'
alias gdev='git checkout developmnet'
alias scrum="git log --since=yesterday --format=oneline --abbrev-commit --author=mihai --no-merges"
alias gp="git push origin HEAD" # pushes current branch to origin, creating it if it does not exist

# git-forest or git-foresta
GIT_FOREST_PATH=""
[ -x "$(command -v git-forest)" ] && GIT_FOREST_PATH="$(command -v git-forest)"
[ -x "$(command -v git-foresta)" ] && GIT_FOREST_PATH="$(command -v git-foresta)"
[ -f "~/bin/git-foresta" ] && GIT_FOREST_PATH="~/bin/git-foresta"
if [ -n "$GIT_FOREST_PATH" ]; then
    alias   gf="$GIT_FOREST_PATH -n 12"
    alias  gfl="$GIT_FOREST_PATH | less -RS"
    alias  gfa="$GIT_FOREST_PATH -a"
    alias gfal="$GIT_FOREST_PATH -a | less -RS"
    alias  gfs="$GIT_FOREST_PATH --sha"
fi

#-----------------------------------------------------------------
# Kubernetes
#-----------------------------------------------------------------
alias k="kubectl"

#-----------------------------------------------------------------
# Tools
#-----------------------------------------------------------------
if [[ "$OS" = MINGW* ]]; then
    alias http="winpty http"
    [ -f "/c/pdev/bin/ack" ] && alias ack='perl /c/pdev/bin/ack'
fi

if [ -x "$(command -v rg)" ]; then
    alias ack='rg'
    alias s='clear && rg'
fi

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# vim on mac
command -v mvim >/dev/null 2>&1 && alias vim='mvim -v'

[ -f ~/.bash_aliases.local ] && source ~/.bash_aliases.local
