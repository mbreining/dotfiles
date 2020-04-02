My dotfiles

Pre-requirements
----------------

- Install [https://github.com/alacritty/alacritty](Alacritty)
- Install [https://github.com/tmux/tmux](tmux)
- Install vim with python3 (`brew install vim --with-python3`)
- Install [https://github.com/junegunn/fzf](fzf)
- Install ack (`brew install ack`)

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
