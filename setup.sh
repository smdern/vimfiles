#!/bin/bash
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc

vim +PluginInstall +qall
cd ~/.vim/bundle/ctrlp-cmatcher
./install_linux.sh

brew install ctags
