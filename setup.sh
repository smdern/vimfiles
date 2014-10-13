#!/bin/bash
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc

vim +PluginInstall +qall
cd ~/.vim/bundle/ctrlp-cmatcher
CFLAGS=-Qunused-arguments CPPFLAGS=-Qunused-arguments ./install.sh
cd ~/.vim/bundle/vimproc.vim
make

brew install ctags
