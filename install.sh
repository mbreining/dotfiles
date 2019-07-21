#!/bin/sh
# Install dotfiles under $HOME.
#
# Usage:
# $ ./install.sh

files_to_skip="README.md install.sh powerline"

function skip_file() {
  if [[ $files_to_skip =~ $1 ]]; then
    return 0  # true
  else
    return 1  # false
  fi
}

for name in *; do
  target="$HOME/.$name"
  if [[ -e $target ]]; then
    echo "$target already installed; skipping..."
  else
    if ! skip_file $name; then
      echo "$target not yet installed; creating symlink..."
      ln -s "$PWD/$name" "$target"
    fi
  fi
done
