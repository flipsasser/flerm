#!/usr/bin/env bash
git clone git@github.com:flipsasser/flim.git ~/.flim
cd ~/.flim
git submodule update --init
ln -s vimrc ~/.vimrc
ln -s vim/ ~/.vim
