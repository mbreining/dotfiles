My dotfiles

Installation
------------

```
$ git clone git@github.com:mbreining/dotfiles.git
$ cd dotfiles
$ ./install.sh
```

The above will install most dotfiles under your $HOME directory.

Append the following at the end of ~/.zshrc.local to setup Pure prompt configuration.

```
# https://github.com/sindresorhus/pure
autoload -U promptinit; promptinit
prompt pure
```
