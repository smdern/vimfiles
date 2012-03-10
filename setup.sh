#!/bin/bash
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc

vim +BundleInstall +qall

cd ~/.vim/bundle/Command-T/ruby/command-t && ruby extconf.rb && make
