#!/bin/bash

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

backup_dir=$HOME/.backups

for dotfile in bash_profile gvimrc pryrc zshrc bash_aliases gitconfig vimrc
do
  if [ -f ~/.$dotfile ]; then
    mkdir -p $backup_dir
    mv ~/.$dotfile $backup_dir/$dotfile
    echo "Backed up ~/.$dotfile to ~/$backup_dir/$dotfile"
  fi

  ln -s ./$dotfile ~/.$dotfile
  echo "Linked ~/.$dotfile"
done

for dotdir in vim oh-my-zsh
do
  if [ -d ~/.$dotdir ]; then
    mkdir -p $backup_dir
    mv ~/.$dotdir $backup_dir/$dotdir
    echo "Backed up ~/.$dotdir to ~/$backup_dir/$dotdir"
  fi

  ln -s ./$dotdir ~/.$dotdir
  echo "Linked ~/.$dotdir"
done

if [ `basename $SHELL` != "zsh" ]; then
  echo "Changing default shell to zsh"
  chsh -s /bin/zsh
fi

echo "Successfully setup dotfiles! Restart shell for changes"

exit 0
