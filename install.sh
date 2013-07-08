#!/usr/bin/env bash
echo "Installing flim..."

#if [ -d ~/.flim ]
#then
  #echo "  removing old versions"
  #rm -rf ~/.flim
#fi

#git clone git://github.com/flipsasser/flim.git ~/.flim
#cd ~/.flim

git submodule init
git submodule update

#if [ -e ~/.vimrc -o -h ~/.vimrc ]
#then
	#echo "  backing up ~/.vimrc to ~/.vimrc.old"
  #mv ~/.vimrc ~/.vimrc.old
#fi

#ln -s ~/.flim/vimrc ~/.vimrc

#if [ -d ~/.vim/ ]
#then
	#echo "  backing up ~/.vim to ~/.vim.old"
  #mv ~/.vim ~/.vim.old
#fi

#ln -s ~/.flim/ ~/.vim

#if [ -e ~/.profile -o -h ~/.profile ]
#then
	#echo "  backing up ~/.profile to ~/.profile.old"
  #mv ~/.profile ~/.profile.old
#fi

#ln -s ~/.flim/profile ~/.profile
