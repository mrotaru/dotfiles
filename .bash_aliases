#-----------------------------------------------------------------
# this file is sourced by the shell at startup ( see .bashrc )
#-----------------------------------------------------------------

OS=`uname`

#-----------------------------------------------------------------
# first, some general aliases that didn't fit anywhere else
#-----------------------------------------------------------------
alias eb='vim ~/.bashrc'
alias bashrc='vim ~/.bashrc && source ~/.bashrc'
alias sb='source ~/.bashrc'
alias ea='vim ~/.bash_aliases'
alias ef='vim ~/.bash_functions'
alias ei='vim ~/.inputrc'
alias duhs='du -hs'
alias dfh='df -h'
alias duh='find . -maxdepth 1 -exec du -hs {} \;'
alias dus="du -k * | sort -nr | cut -f2 | xargs -d '\n' du -sh"
alias e='vim'
alias cls='clear'                    # a bit redunant; use CTRL+L
alias mex='sudo chmod +x'            # make executable
alias rmd='rm -rf'                   # remive folder, recursivelly
alias md='mkdir'
# the following aliases are for functions defined in ~/.bash_functions
alias md='mkdir_cd'
alias bak='backup_current_dir'
alias rbak='restore_backup'
alias exp="explorer \"`pwd | sed -e 's:^\/::' | sed -e 's:^\([a-z]\):\1\::' | sed -e 's:\/:\\\\:g'`\""
alias ec="cat /dev/clipboard | bash"
alias ea="source ~/.bash_aliases"
alias vim="vi"
alias nicepath="echo \$PATH | tr ':' '\n'"

#-----------------------------------------------------------------
# navigation
#-----------------------------------------------------------------
alias ..="cd .."        # go to parent dir
alias ...="cd ../.."    # go to grandparent dir
alias -- -="cd -"       # go to previous dir
alias cdh='cd ~'        # go to home dir
alias cdp='cd ~/Projects'
if [[ "$OS" = MINGW* ]]
then
    alias nav='explorer . 2> /dev/null' # open a nautilus window in current dir
    alias nt="/c/pdev/apps/Total\ CMA\ Pack/TOTALCMD.EXE /L=\"`pwd | sed -e 's:^\/::' | sed -e 's:^\([a-z]\):\1\::' | sed -e 's:\/:\\\\:g'`\" /I='c:\pdev\apps\Total CMA Pack\cfg\Total CMA Pack.ini' &"
else
    alias nav='nautilus ./ 2> /dev/null' # open a nautilus window in current dir
fi

#-----------------------------------------------------------------
# the 'ls' zoo
#-----------------------------------------------------------------
alias l.='ls -d .*'     # list hidden files/folders
alias la='ls -a'     	# list files, including hidden files/folders
alias ll='ls -lgGht'    # sort by modified time, human-readable 
alias llo='ls -lht'     # like ll, but show owner/group info
alias lld='ls -ludh */' # list directories
alias lsa='ls -A'       # list all files ( including hidden )
alias l='ls -Ct'        # columns; sort by size 
alias llr='ls -lAgGht --time-style=+"%H:%M"'
alias lla='ls -lAgGht --time-style=+"%d-%b-%y"'
# sort by modified time, human-readable, don't wrap
# Windows has no tput, so these won't work
#alias ll='(tput rmam; ls -lgGht --time-style=+"%d-%b-%y"; tput smam)'
#alias lln='(tput rmam; ls -lgGh --time-style=+"%d-%b-%y"; tput smam)'

#-----------------------------------------------------------------
# vagrant
#-----------------------------------------------------------------
alias vu="vagrant up"
alias vd="vagrant destroy"
alias vdu="vagrant destroy -f && vagrant up"
alias vs="vagrant status"
alias vss="vagrant ssh"
alias vsu="vagrant suspend"
alias vup="vagrant up --provision"
alias vdup="vagrant destroy -f && vagrant up --provision"

#-----------------------------------------------------------------
# git
#-----------------------------------------------------------------
alias gobj="find .git/objects/ | egrep -o '/[0-9a-f]{2}/[0-9a-f]{38}' | tr -d '/'"
alias got='gobj | while read git_obj_id; do toex="git cat-file -t $git_obj_id"; echo $git_obj_id `$toex`; done'
alias gf='git-forest'
alias gfl='git-forest | less -RS'
alias gfa='git-forest -a'
alias gfal='git-forest -a | less -RS'
alias gfs='git-forest --sha'
alias gs='git status'  # by default, gs is associated to 'ghost script'
alias ga='git add'
alias gc='git commit'
alias gb='git branch'
alias gd='git diff'
alias gdp='git diff HEAD^1' # diff from previous commit
alias gcm='git commit -a -v -m'
alias co='git checkout'
# from http://meitsinblawg.wordpress.com/2010/04/20/my-setup-for-git-on-command-line/
alias gdc='git diff --cached'
alias gst='git status -s' # git >1.7.0
#alias glr='git pull --rebase'
#alias gl='git pull'
#alias gp='git push'
alias gd='git diff'
#alias gc='git commit -v'
alias gca='git commit -v -a'
alias gb='git branch'
alias gba='git branch -a'
alias gap='git add --patch'
alias gl="git log --pretty=format:'%Cred%h%Creset%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative -n 10"
alias gla="git log --pretty=format:'%Cred%h%Creset%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
# <<
