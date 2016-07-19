### Installation

Requires vim compiled with lua. On mac:

```
$ brew install macvim --with-cscope --with-luajit --override-system-vim
```

`git clone git://github.com/smdern/vimfiles.git ~/.vim && ~/.vim/setup.sh`

Switched the Ack plugin to use [The Silver Searcher](https://github.com/ggreer/the_silver_searcher)
Install OSX: `brew install the_silver_searcher`
Install Ubuntu: `sudo apt-get install silversearcher-ag`

Uses [fzf](https://github.com/junegunn/fzf) for fuzzy finding

### Attributions

Inconsolata-g was originally from http://leonardo-m.livejournal.com/77079.html
Many things stolen from Gary Bernhardt: https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
