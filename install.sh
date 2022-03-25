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
  source_file=~/.flerm/$1
  user_file=~/$2
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
flerm_link "bash/ackrc" ".ackrc"
flerm_link "bash/asdfrc" ".asdfrc"
flerm_link "bash/bash_profile" ".bash_profile"
flerm_link "bash/gemrc" ".gemrc"
flerm_link "bash/gitconfig" ".gitconfig"
flerm_link "bash/gitignore" ".gitignore"
flerm_link "bash/git_template" ".git_template"
flerm_link "bash/hushlogin" ".hushlogin"
flerm_link "bash/ignore" ".ignore"
flerm_link "bash/inputrc" ".inputrc"
flerm_link "bash/psqlrc" ".psqlrc"
flerm_link "bash/vimrc" ".vimrc"

# Install the .bin directory
mkdir -p ~/.bin
flerm_link "bin/rubocop" ".bin/rubocop"

# Update vim bundles
vim +BundleInstall +qall

# Install asdf (if it's not installed)
if [ ! -d ~/.asdf ]; then
  echo "  installing ASDF into ~/.asdf"
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.9.0
fi

# Source the new environment
source ~/.bash_profile

echo "

Flerm is all set up. Lucky you!

"
