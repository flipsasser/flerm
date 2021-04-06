#!/usr/bin/env bash
echo "Installing Flerm..."

# Update or clone Flerm
if [ -d ~/.flerm ]; then
  echo "  already installed; updating"
  cd ~/.flerm
  git stash
  git pull --rebase origin master
  git submodule update --init
  git stash pop
else
  echo "  cloning Flerm"
  [ -f ~/.ssh/id_rsa.pub ] && git clone git@github.com:flipsasser/flerm.git ~/.flerm || git clone https://github.com/flipsasser/flerm.git ~/.flerm
  cd ~/.flerm
  git submodule update --init
fi

# Install the .vim directory
if [ -d ~/.vim/ ]; then
  echo "  backing up ~/.vim to ~/.vim.old"
  rm -rf ~/.vim.old
  mv ~/.vim ~/.vim.old
fi

ln -s ~/.flerm/vim/ ~/.vim

flerm_link() {
  source_file=~/.flerm/bash/$1
  user_file=~/.$1
  if [ -h $user_file -o $user_file ]; then
    echo "  re-linking $user_file"
    rm -rf $user_file
  else
    if [ -e $user_file -o -h $user_file ]; then
      echo "  backing up $user_file to $user_file.old"
      mv $user_file $user_file.old
    fi
  fi
  echo "  linking $source_file to $user_file"
  ln -s $source_file $user_file
}

# Link various bash files
flerm_link "ackrc"
flerm_link "bash_profile"
flerm_link "gemrc"
flerm_link "gitconfig"
flerm_link "gitignore"
flerm_link "git_template"
flerm_link "hushlogin"
flerm_link "ignore"
flerm_link "inputrc"
flerm_link "psqlrc"
flerm_link "vimrc"

# Update vim bundles
vim +BundleInstall +qall

# Source the new environment
source ~/.bash_profile

echo "

Flerm is all set up. Lucky you!

"
