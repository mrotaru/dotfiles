#:set syntax=bash
function gbc() {
  git checkout -b "$1"
  local str=$(sed 's/-/\ /g' <<< $1)
  git commit -a -m "$str"
}

function rgi() {
	echo $'\e[1;33m'Imports$'\e[0m'
	echo $'\e[1;33m'-------$'\e[0m'
	rg "import\s+.*$1"
	echo ""

	echo $'\e[1;33m'All results$'\e[0m'
	echo $'\e[1;33m'-----------$'\e[0m'
	rg "$1"
	echo ""
}

function versions() {
	echo "checking versions..."

	echo "kubectl"
	[ -x "$(command -v kubectl)" ] && kubectl version
	echo ""

	echo "rg"
	[ -x "$(command -v rg)" ] && rg --version
	echo ""

	echo "vim"
	[ -x "$(command -v vim)" ] && vim --version
	echo ""

	echo "nvim"
	[ -x "$(command -v nvim)" ] && nvim --version
	echo ""

	echo "tmux"
	[ -x "$(command -v tmux)" ] && tmux -V
	echo ""

	echo "broot"
	[ -x "$(command -v broot)" ] && broot --version
	echo ""
}

function rga() {
  rg --no-ignore --hidden "$@"
}

