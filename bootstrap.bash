#!/bin/bash

# link to github repository
remote="https://raw.github.com/mihai-rotaru/dotfiles/master/"

# which files are to be copied
files=(
 .bash_aliases
 .bash_functions
 .bashrc
 .inputrc
 .profile
 .screenrc
 .gitconfig
 .tmux.conf
 .vimperatorrc
 )

# download a single file in the current directory - use curl or wget
function get_file()
{
    if [ $(command -v curl) ]; then
        curl -s --write-out "%{url_effective} %{http_code}\n" -O "$1"
    else
        if [ $(command -v wget) ]; then
            wget --no-verbose "$1" -O "$2"
        fi
    fi
}
    
# go to home directory and feth the files
cd ~
for file in "${!files[@]}"; do
    url="${remote}${files[file]}"
    get_file "$url" "${files[file]}"
done

[ -f "$HOME/.profile" ] && source "$HOME/.profile"
