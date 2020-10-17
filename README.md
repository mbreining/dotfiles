My dotfiles

Requirements
----------------

- Install [https://github.com/tmux/tmux](tmux)
- Install vim with python3 (e.g. `brew install vim --with-python3`)
- Install [https://github.com/junegunn/fzf](fzf)
- Install ack (e.g. `brew install ack`)
- install vim minpac plugin [https://github.com/k-takata/minpac](minpac)

Installation
------------

```
$ git clone git@github.com:mbreining/dotfiles.git
$ cd dotfiles
$ ./install.sh
```

Pure prompt configuration
-------------------------

Append the following at the end of ~/.zshrc.local.

```
autoload -U promptinit; promptinit
prompt pure
```

More info [https://github.com/sindresorhus/pure#install](here).
