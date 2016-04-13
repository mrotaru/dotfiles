[ -d ~/dotfiles ] && { echo "~/dotfiles already exists, exiting..."; exit 1; }

git clone git@github.com:mrotaru/dotfiles.git ~/dotfiles

backup_dir="~/$(date +"%Y-%m-%dT%k-%M")"

files=(
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
    [ -f "~/$file" ] && { [ ! -d "$backup_dir" ] && mkdir "$backup_dir"; cp "~/$file" "$backup_dir"; }
    ln -s "~/dotfiles/$file" "~/$file"
done

[ -f "$HOME/.profile" ] && source "$HOME/.profile"
