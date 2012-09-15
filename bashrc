# ./bashrc

# Read global startup file if it exists
if [[ -f /etc/bashrc ]]; then
  . /etc/bashrc
fi

# Keep files safe from accidental overwriting
# http://www.e-reading.org.ua/htmbook.php/orelly/unix2.1/upt/ch13_06.htm
set -o noclobber
