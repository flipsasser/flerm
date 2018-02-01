#!/usr/bin/env bash
echo "Uninstalling flerm..."

# Install the .vim directory
if [ -d ~/.vim.old/ ]
then
  echo "  restoring ~/.vim.old to ~/.vim"
  rm -rf ~/.vim
  mv ~/.vim.old ~/.vim
fi
flerm_unlink() {
  backup_file=~/.$1.old
  user_file=~/.$1
  if [ -h $user_file -o $user_file ]
  then
    echo "  unlinking $user_file"
    rm -rf $user_file
  fi
  if [ -e $backup_file -o -h $backup_file ]
  then
    echo "  restoring $backup_file to $user_file"
    mv $backup_file $user_file
  fi
}

flerm_unlink "ackrc"
flerm_unlink "gemrc"
flerm_unlink "gvimrc"
flerm_unlink "ignore"
flerm_unlink "profile"
flerm_unlink "vimrc"

rm -rf ~/.flerm
