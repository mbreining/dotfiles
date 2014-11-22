#!/bin/sh
# install.sh: Install dotfiles on current system.

for name in *; do
  target="$HOME/.$name"
  if [[ ! -e $target ]]; then
    if [[ $name != 'install.sh' ]] && [[ $name != 'README.md' ]]; then
      echo "Creating symlink for $target"
      ln -s "$PWD/$name" "$target"
    fi
  fi
done
