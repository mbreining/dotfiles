My dotfiles

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

More info here: https://github.com/sindresorhus/pure#install
