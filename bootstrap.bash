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
 .pdbrc
 )

# set download method - curl or wget
command -v curl >/dev/null 2>&1
if [ $? -eq 0 ]; then
   get_method="curl"
else
    command -v wget >/dev/null 2>&1
    [ $? -eq 0 ] && get_method="wget"
fi
[ -z "$get_method" ] && { echo "Neither wget nor curl found. Exiting..."; exit 1; }

# backups folder - to be used for files which already exist
backup_dir=$(date +"%Y-%m-%dT%k-%M")

# download a single file in the current directory
function get_file()
{
    [ -f "$2" ] && { [ ! -d "$backup_dir" ] && mkdir "$backup_dir"; cp "$2" "$backup_dir"; }
    case "$get_method" in
        "curl") curl -s --write-out "%{url_effective} %{http_code}\n" -O "$1" ;;
        "wget") wget --no-verbose "$1" -O "$2" ;;
    esac
}

# go to home directory and feth the files
cd ~
for file in "${!files[@]}"; do
    url="${remote}${files[file]}"
    get_file "$url" "${files[file]}"
done

[ -f "$HOME/.profile" ] && source "$HOME/.profile"
