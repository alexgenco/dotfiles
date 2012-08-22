#!/bin/bash

[ `dirname "$0"` != "." ] && echo "Run `basename "$0"` from its parent directory" && exit 1

for dotfile in bash_profile gvimrc pryrc bash_aliases gitconfig git-completion vimrc vim
do
  if [ ! -f "./${dotfile}" -a ! -d "./${dotfile}" ]; then
    echo "Couldn't find $dotfile in working directory. Did you rename it or delete it?"
    exit 1
  fi
done

echo "Initializing submodules"
git submodule init
git submodule update

backup_dir="$HOME/.backups"

for dotfile in bash_profile gvimrc pryrc bash_aliases gitconfig git-completion vimrc vim
do
  if [ -h "~/.$dotfile" ]; then
    rm ~/.$dotfile
  elif [ -e "~/.$dotfile" ]; then
    [ ! -d "$backup_dir" ] && mkdir -p "$backup_dir"
    mv "~/.$dotfile" "$backup_dir/$dotfile" && echo "Backed up ~/.$dotfile to $backup_dir"
  fi

  ln -s "./$dotfile" "$HOME/.$dotfile" && echo "Linked ~/.$dotfile"
done

echo "Successfully setup dotfiles! Might need to restart shell?"

exit 0
