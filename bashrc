# ./bashrc

# Read global startup file if it exists
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Keep files safe from accidental overwriting
set -o noclobber
