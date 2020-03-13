OS=`uname`

#------------------------
# Frequently edited files
#------------------------
alias eb='vim ~/.bashrc'
alias sb='source ~/.bashrc'
alias ea='vim ~/.bash_aliases'
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
alias ..="cd .."        # go to parent dir
alias ...="cd ../.."    # go to grandparent dir
alias -- -="cd -"       # go to previous dir
if [[ "$OS" = MINGW* ]]
then
    #alias exp="explorer \"`pwd | sed -e 's:^\/::' | sed -e 's:^\([a-z]\):\1\::' | sed -e 's:\/:\\\\:g'`\""
    alias nav='explorer . 2> /dev/null'
else
    alias nav='nautilus ./ 2> /dev/null'
fi

#-----------------------------------------------------------------
# The 'ls' zoo
#-----------------------------------------------------------------
alias l='ls -CF'
alias ls='ls --color=auto' # assuming colour support
alias l.='ls -d .*'     # list hidden files/folders
alias la='ls -A'     	# list files, including hidden files/folders
alias ll='ls -AlgGht'   # sort by modified time, human-readable 
alias llo='ls -lht'     # like ll, but show owner/group info
alias lld='ls -ludh */' # list directories
alias lsa='ls -A'       # list all files ( including hidden )
alias l='ls -Ct'        # columns; sort by size 
alias llr='ls -lAgGht --time-style=+"%H:%M"'
alias lla='ls -lAgGht --time-style=+"%d-%b-%y"'

# Windows has no tput
if [[ "$OS" == 'Linux' ]]; then 
    # sort by modified time, human-readable, don't wrap
    alias ll='(tput rmam; ls -lgGht --time-style=+"%d-%b-%y"; tput smam)'
    alias lln='(tput rmam; ls -lgGh --time-style=+"%d-%b-%y"; tput smam)'
fi

#-----------------------------------------------------------------
# Vagrant
#-----------------------------------------------------------------
alias vu="vagrant up"
alias vd="vagrant halt && vagrant destroy"
alias vdu="vagrant halt && vagrant destroy -f && vagrant up"
alias vh="vagrant halt"
alias vs="vagrant status"
alias vss="vagrant ssh"
alias vsu="vagrant suspend"
alias vup="vagrant up --provision"
alias vdup="vagrant destroy -f && vagrant up --provision"

#-----------------------------------------------------------------
# git
#-----------------------------------------------------------------

# hub - https://github.com/github/hub
[ -x "$(command -v hub)" ] && { alias git=hub; }

alias gs='git status'
alias g='git status'
alias ga='git add'
alias gc='git commit'
alias gb='git branch'
alias gd='git diff'
alias gdp='git diff HEAD^1' # diff from previous commit
alias gcm='git commit -a -v -m'
alias co='git checkout'
alias gdc='git diff --cached'
alias gst='git status -s' # git >1.7.0
alias pull='git pull'
alias push='git push'
alias gd='git diff'
alias gca='git commit -v -a'
alias gb='git branch'
alias gbd='git branch -d'
alias gba='git branch -a'
alias gap='git add --patch'
alias gl="git log --pretty=format:'%Cred%h%Creset%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative -n 10"
alias gla="git log --pretty=format:'%Cred%h%Creset%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
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
alias t='todo.sh'

# vim on mac
command -v mvim >/dev/null 2>&1 && alias vim='mvim -v'

[ -f ~/.local-bash-aliases ] && source ~/.local-bash-aliases