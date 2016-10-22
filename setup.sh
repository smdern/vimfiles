#!/bin/bash

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc

unamestr=`uname`

function install_ctags {
  case `uname` in
    Darwin)
      brew install ctags
      ;;
    Linux)
      sudo apt-get install ctags
      ;;
    *)
      exit 1
  esac
}

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

install_ctags
install_eslint_d

vim +PlugInstall! +qall
