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

for dotfile in bash_profile gvimrc pryrc zshrc bash_aliases gitconfig vimrc vim oh-my-zsh
do
  if [ -h ~/.$dotfile ]; then
    rm ~/.$dotfile
  elif [ -e ~/.$dotfile ]; then
    mkdir -p $backup_dir
    mv ~/.$dotfile $backup_dir/$dotfile
    echo "Backed up ~/.$dotfile to $backup_dir"
  fi

  ln -s $PWD/$dotfile $HOME/.$dotfile
  echo "Linked ~/.$dotfile"
done

if [ `basename $SHELL` != "zsh" ]; then
  echo "Changing default shell to zsh"
  chsh -s /bin/zsh
fi

echo "Successfully setup dotfiles! Might need to restart shell?"

exit 0
