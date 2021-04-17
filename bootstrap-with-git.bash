#!/bin/bash

command -v git >/dev/null 2>&1 || { echo >&2 "git not found in path, exiting."; exit 1; }

if [ -d ~/dotfiles ]; then 
    echo "~/dotfiles already exists, trying to git pull...";
    cd ~/dotfiles && git pull || exit 1;
else
    REPO="mrotaru/dotfiles.git"
    echo "Cloning $REPO..."
    git clone git@github.com:$REPO ~/dotfiles >/dev/null 2>&1  || {
      echo "Could not clone via SSH, trying HTTPS..."
      git clone https://github.com/mrotaru/dotfiles.git >/dev/null 2>&1 || { echo "Failed to clone, exiting."; exit 1; }
    }
fi

echo ""
echo "Dotfiles"
echo "-------"

backup_dir="$HOME/dotfiles-backup-$(date +"%Y-%m-%dT%k-%M")"

files=(
 .bash_profile
 .bashrc
 .bash_aliases
 .inputrc
 .profile
 .screenrc
 .gitconfig
 .tmux.conf
 .ackrc
 )

MD5=md5sum
(command -v $MD5 > /dev/null 2>&1;) || MD5=md5
(command -v $MD5 > /dev/null 2>&1;) || { echo "md5 command not installed; exiting"; exit 1; }

function md5 () {
  sum= eval($md5  $existing | awk '{print $1}') || { echo "failed to compute md5, exiting."; exit 1; }
  echo $sum
}

for file in "${!files[@]}"; do
    existing="$HOME/${files[file]}"
    new="$HOME/dotfiles/${files[file]}"

    if [ -f "$existing" -o -h "$existing" ]; then
        # compute md5 checksums
        md5_existing=$(md5 $existing)
        md5_new=$(md5 $new)

        # if different, create backup and remove existing file; then create link
        if [ "$md5_existing" != "$md5_new" ]; then
            echo "\"$existing\" exists and is different from \"$new\","
            echo "copying to \"$backup_dir\"..."
            [ ! -d "$backup_dir" ] && mkdir "$backup_dir"
            cp "$existing" "$backup_dir" || { echo "Could not backup, exiting..."; exit 1; }
            echo "removing \"$existing\"..."
            rm "$existing" || { echo "Could not remove $existing, exiting..."; exit 1; }
            ln -s "$new" "$existing"
        else
            echo "\"$existing\" exists but is the same as \"$new\" (md5: $md5_existing)"
        fi
    else
        echo "creating link to $new..."
        ln -s "$new" "$existing" || { echo "failed to create link \"$new\", exiting."; exit 1; }
    fi
done

ln -s "$HOME/dotfiles/.i3" "$HOME/.3"

echo "Cloning tmux-plugin-manager..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

[ -f "$HOME/.profile" ] && source "$HOME/.profile"
