#!/bin/bash
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc

vim +BundleInstall +qall
cd ~/.vim/bundle/ctrlp-cmatcher
./install_linux.sh
cd ~/.vim/bundle/YouCompleteMe
./install.sh

brew install ctags
