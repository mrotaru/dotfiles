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
 )

# go to home directory and feth the files
cd ~
for file in "${!files[@]}"; do
    url="${remote}${files[file]}"
    curl -s --write-out "%{url_effective} %{http_code}\n" -O "$url"
done

[ -f "$HOME/.profile" ] && source "$HOME/.profile"
