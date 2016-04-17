# sourced by shells; bash should source ~/.bash_profile
[ -n "$BASH_VERSION" -a -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
