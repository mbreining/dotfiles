My dotfiles

Pre-requirements
----------------

- Install [https://github.com/alacritty/alacritty](Alacritty)
- Install [https://github.com/tmux/tmux](tmux)
- Install [https://github.com/junegunn/fzf](fzf)

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
