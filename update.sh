#!/bin/bash
cd ~/.vim/bundle/vundle
git fetch
git reset --hard origin/master
cd -
vim +PluginInstall! +qall
