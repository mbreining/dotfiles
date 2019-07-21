#!/bin/sh
# Install vim plugins using vim's native plugin manager.
#
# Usage:
# $ ./install_vim_plugins.sh

# Create new folder in ~/.vim/pack that contains a start folder and cd into it
# e.g. set_group syntax-highlighting
function set_group () {
  package_group=$1
  path="$HOME/.vim/pack/$package_group"
  start="$path/start"
  opt="$path/opt"
  mkdir -p {"$start","$opt"}
  cd "$path"
}

# Clone or update a git repo in the current directory
# e.g. package https://github.com/tpope/vim-endwise.git
function package () {
  repo_url=$1
  repo_dir=$2
  cd "$repo_dir"
  expected_repo=$(basename "$repo_url" .git)
  if [ -d "$expected_repo" ]; then
    cd "$expected_repo" || exit
    result=$(git pull --force)
    echo "$expected_repo: $result"
  else
    echo "$expected_repo: Installing..."
    git clone -q "$repo_url"
  fi
  cd ..
}

(
set_group general
package https://github.com/junegunn/fzf.git start &
package https://github.com/junegunn/fzf.vim.git start &
package https://github.com/mileszs/ack.vim.git start &
package https://github.com/tpope/vim-surround.git start &
package https://github.com/tpope/vim-unimpaired.git start &
package https://github.com/easymotion/vim-easymotion.git start &
package https://github.com/scrooloose/nerdtree.git start &
wait
) &
(
set_group colorschemes
package https://github.com/altercation/vim-colors-solarized.git start &
package https://github.com/itchyny/lightline.vim.git start &
package https://github.com/flazz/vim-colorschemes.git opt &
wait
) &
(
set_group syntax
package https://github.com/tpope/vim-markdown.git start &
package https://github.com/scrooloose/syntastic.git start &
package https://github.com/w0rp/ale.git start &
package https://github.com/prettier/vim-prettier.git start &
wait
) &
(
set_group python
package https://github.com/klen/python-mode.git start &
package https://github.com/yssource/python.vim.git start &
#package https://github.com/python_match.vim.git start &
#package https://github.com/pythoncomplete.git start &
package https://github.com/tmhedberg/SimpylFold.git start &
wait
) &
(
set_group ruby
package https://github.com/tpope/vim-rails.git opt &
package https://github.com/tpope/vim-rake.git opt &
package https://github.com/tpope/vim-bundler.git opt &
package https://github.com/tpope/vim-endwise.git opt &
wait
) &
wait

#vim "+helptags ALL"
