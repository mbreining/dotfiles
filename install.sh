#!/bin/sh
# install.sh: Install dotfiles on system.

cutstring="DO NOT EDIT BELOW THIS LINE"

for name in *; do
  target="$HOME/.$name"
  if [[ -e $target ]]; then
    if [[ ! -L $target ]]; then
      # Dotfile already exists and is not a symlink. Update it.
      cutline=`grep -n -m1 "$cutstring" "$target" | sed "s/:.*//"`
      if [[ -n $cutline ]]; then
        # The dotfile appears to have been installed in the past by with this script.
        let "cutline = $cutline - 1"
        echo "Updating $target"
        head -n $cutline "$target" > update_tmp
        startline=`tail -r "$name" | grep -n -m1 "$cutstring" | sed "s/:.*//"`
        if [[ -n $startline ]]; then
          tail -n $startline "$name" >> update_tmp
        else
          cat "$name" >> update_tmp
        fi
        mv update_tmp "$target"
      else
        echo "WARNING: $target exists but is not a symlink."
      fi
    fi
  else
    if [[ $name != 'install.sh' ]] && [[ $name != 'README.md' ]]; then
      # Dotfile doesn't yet exist. Create it.
      echo "Creating $target"
      if [[ -n `grep "$cutstring" "$name"` ]]; then
        # Copy the dotfile since it can be edited/customized on the target system.
        cp "$PWD/$name" "$target"
      else
        # Symlink the dotfile.
        ln -s "$PWD/$name" "$target"
      fi
    fi
  fi
done
