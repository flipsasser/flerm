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
  git submodule update --init
else
  echo "  cloning flerm"
  git clone git://github.com/flipsasser/flerm.git ~/.flerm
  cd ~/.flerm
  git submodule update --init
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
  else
    if [ -e $user_file -o -h $user_file ]
    then
      echo "  backing up $user_file to $user_file.old"
      mv $user_file $user_file.old
    fi
    echo "  linking $source_file to $user_file"
    ln -s $source_file $user_file
  fi
}

# Link various bash files
flerm_link "ackrc"
flerm_link "gemrc"
flerm_link "gitconfig"
flerm_link "gitignore"
flerm_link "gvimrc"
flerm_link "profile"
flerm_link "vimrc"

# Update vim bundles
vim +BundleInstall +qall

# Source the new environment
source ~/.profile

echo "

FLERM is all set up. Lucky you!

"
