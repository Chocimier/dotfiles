#!/bin/sh

tools_necessary="
git
rcup
"

error=
for i in $tools_necessary; do
	if ! command -v $i > /dev/null; then
		echo "$i is necessary. Install it first."
		error=1
	fi
done
if [ "$error" ]; then
	exit 1
fi

if ! [ -d ~/.oh-my-zsh ]; then
	git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi
if ! [ -d ~/.oh-my-zsh/custom/plugins/zsh-completions ]; then
	git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
fi
if ! [ -d ~/.tacklebox ]; then
	git clone https://github.com/justinmayer/tacklebox ~/.tacklebox
fi
if ! [ -d ~/.tackle ]; then
	git clone https://github.com/justinmayer/tackle ~/.tackle
fi
if ! [ -d ~/.local/share/nvim/bundle/Vundle.vim ]; then
	git clone https://github.com/VundleVim/Vundle.vim ~/.local/share/nvim/bundle/Vundle.vim
fi

# find directory
cd "$(dirname $0)"
dotfiles="$(pwd)"
cd - > /dev/null

RCRC="$dotfiles/rcrc" rcup -d "$dotfiles" "$@"
