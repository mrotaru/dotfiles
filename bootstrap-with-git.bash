[ -d ~/dotfiles ] && { echo "~/dotfiles already exists, exiting..."; exit 1; }

git clone git@github.com:mrotaru/dotfiles.git ~/dotfiles

echo ""
echo "Dotfiles"
echo "-------"

backup_dir="$HOME/dotfiles-backup-$(date +"%Y-%m-%dT%k-%M")"

files=(
 .bash_profile
 .bashrc
 .bash_interactive
 .bash_aliases
 .bash_functions
 .inputrc
 .profile
 .screenrc
 .gitconfig
 .tmux.conf
 .vimperatorrc
 .pdbrc
 )

for file in "${!files[@]}"; do
    existing="$HOME/${files[file]}"
    new="$HOME/dotfiles/${files[file]}"
    if [ -f "$existing" -o -h "$existing" ]; then
        # compute md5 checksums
        md5_existing=($(md5sum "$existing")) || { echo "failed md5 for \"$existing\", exiting..."; exit 1; }
        md5_new=($(md5sum "$new")) || { echo "failed md5 for \"$new\", exiting..."; exit 1; }

        # if different, create backup and remove existing file; then crete
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
        echo "not existing: $existing"
        ln -s "$new" "$existing" || exit 1
    fi
done

[ -f "$HOME/.profile" ] && source "$HOME/.profile"
