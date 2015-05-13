#!/bin/bash
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
. ~/.vim/bundle/neobundle.vim/bin/neoinstall

ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc

brew install ctags
