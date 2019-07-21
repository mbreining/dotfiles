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

To add a vim plugin as a git submodule:
```
mkdir ~/dotfiles/vim/pack/myplugins/{opt,start}
git submodule add https://github.com/vim-airline/vim-airline.git vim/pack/myplugins/start/vim-airline
```

or to have loaded up with :packadd:
```
git submodule add https://github.com/vim-airline/vim-airline.git vim/pack/myplugins/opt/vim-airline
```

Then:
```
git commit -am "Add vim-airline plugin"
git push
```
