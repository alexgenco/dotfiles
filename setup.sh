#!/bin/sh

if [ `dirname $0` != "." ]; then
  echo "Run $0 from inside its parent directory"
  exit 1
fi

for dotfile in bash_profile gvimrc pryrc zshrc bash_aliases gitconfig vimrc vim oh-my-zsh
do
  if [ ! -f ./${dotfile} -a ! -d ./${dotfile} ]; then
    echo "Couldn't find $dotfile in working directory. Did you rename it or delete it?"
    exit 1
  fi
done

echo "Initializing submodules"
git submodule init
git submodule update

for dotfile in bash_profile gvimrc pryrc zshrc bash_aliases gitconfig vimrc vim oh-my-zsh
do
  if [ -f ~/.$dotfile -o -d ~/.$dotfile ]; then
    echo "Renaming ~/.$dotfile to ~/.${dotfile}_backup"
    mv ~/.$dotfile ~/.${dotfile}_backup
  fi

  ln -s ./$dotfile ~/.$dotfile
  echo "Linked ~/.$dotfile to $dotfile"
done

echo "Successfully setup dotfiles!"

exit 0
