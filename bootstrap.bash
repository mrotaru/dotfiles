#!/bin/bash

# link to github repository
remote="https://github.com/mihai-rotaru/dotfiles/blob/master/"

# which files are to be copied
files=(
 .bash_aliases
 .bash_functions
 .bashrc
 .inputrc
 .profile
 .screenrc
 )

# go to home directory and feth the files
cd ~
for file in "${!files[@]}"; do
    curl -O "${remote}${host[idx]}"
done
