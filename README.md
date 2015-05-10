### Installation

Requires vim compiled with lua. On mac:

```
$ brew install macvim --with-cscope --with-luajit
```

`git clone git://github.com/aaronjensen/vimfiles.git ~/.vim && ~/.vim/setup.sh`

Switched the Ack plugin to use [The Silver Searcher](https://github.com/ggreer/the_silver_searcher)
Install OSX: `brew install the_silver_searcher`

For xmpfilter:

```
$ gem install rcodetools fastri
```

Uses a different [matcher for
ctrlp](https://github.com/JazzCore/ctrlp-cmatcher) that is written in C. The
`setup.sh` will build it, but you should have `python-dev` installed if you do
not.

### Attributions

Inconsolata-g was originally from http://leonardo-m.livejournal.com/77079.html
Many things stolen from Gary Bernhardt: https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
