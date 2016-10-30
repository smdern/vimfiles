#!/bin/bash

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc

unamestr=`uname`

function install_eslint_d {
  case `uname` in
    Darwin)
      yarn global add eslint_d
      ;;
    Linux)
      sudo npm install -g eslint_d
      ;;
    *)
      exit 1
  esac
}

install_eslint_d

`(which nvim || which vim)` +PlugInstall! +qall
