#!/usr/bin/env bash
echo "Installing flerm..."

# Rename old .flim installations to .flerm
if [ -d ~/.flim ]
then
  echo "  moving .flim to .flerm"
  mv ~/.flim ~/.flerm
fi

# Update or clone flerm
if [ -d ~/.flerm ]
then
  echo "  updating flerm"
  cd ~/.flerm
  git pull origin master
  git submodule update --recursive
else
  echo "  cloning flerm"
  git clone git://github.com/flipsasser/flerm.git ~/.flerm
  git submodule init --update
  cd ~/.flerm
fi

# Install the .vim directory
if [ -d ~/.vim/ ]
then
  echo "  backing up ~/.vim to ~/.vim.old"
  rm -rf ~/.vim.old
  mv ~/.vim ~/.vim.old
fi

ln -s ~/.flerm/vim/ ~/.vim

flerm_link() {
  source_file=~/.flerm/bash/$1
  user_file=~/.$1
  if [ -h $user_file -o $user_file ]
  then
    echo "  re-linking $user_file"
    rm -rf $user_file
  elif [ -e $user_file -o -h $user_file ]
  then
    echo "  backing up $user_file to $user_file.old"
    mv $user_file $user_file.old
  else
    echo "  linking $source_file to $user_file"
  fi
  ln -s $source_file $user_file
}

flerm_link "ackrc"
flerm_link "gemrc"
flerm_link "gvimrc"
flerm_link "profile"
flerm_link "vimrc"
