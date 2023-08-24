#!/usr/bin/env bash
echo "Uninstalling flerm..."

# Install the .vim directory
if [ -d ~/.vim.old/ ]; then
  echo "  restoring ~/.vim.old to ~/.vim"
  rm -rf ~/.vim
  mv ~/.vim.old ~/.vim
fi
flerm_unlink() {
  backup_file=~/.$1.old
  user_file=~/.$1
  if [ -h $user_file -o $user_file ]; then
    echo "  unlinking $user_file"
    rm -rf $user_file
  fi
  if [ -e $backup_file -o -h $backup_file ]; then
    echo "  restoring $backup_file to $user_file"
    mv $backup_file $user_file
  fi
}

flerm_unlink "ackrc"
flerm_unlink "asdfrc"
flerm_unlink "bash_profile"
flerm_unlink "gemrc"
flerm_unlink "gitconfig"
flerm_unlink "gitignore"
flerm_unlink "git_template"
flerm_unlink "hushlogin"
flerm_unlink "ignore"
flerm_unlink "inputrc"
flerm_unlink "irbrc"
flerm_unlink "psqlrc"
flerm_unlink "vimrc"

rm -rf ~/.flerm
