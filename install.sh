#!/bin/sh
# Install dotfiles under $HOME.
#
# Usage:
# $ ./install.sh

files_to_skip="README.md install.sh install_vim_plugins.sh powerline"

function skip_file() {
  if [[ $files_to_skip =~ $1 ]]; then
    return 0  # true
  else
    return 1  # false
  fi
}

cd ~/dotfiles

# Install zsh plugin manager
brew install getantibody/tap/antibody
brew install tmux

# Install vim plugins
source ~/dotfiles/install_vim_plugins.sh

# Install dotfiles
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
