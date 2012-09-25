# ./bashrc

# Read global startup file if it exists
[[ -f /etc/bashrc ]] && . /etc/bashrc

export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/git/bin:$PATH

PS1='\[\033[0;32m\]\u\[\033[0;34m\] \w\[\033[00m\]: '
export PS1

# Keep files safe from accidental overwriting
# http://www.e-reading.org.ua/htmbook.php/orelly/unix2.1/upt/ch13_06.htm
set -o noclobber

# Source aliases
[[ -f $HOME/.aliases ]] && . $HOME/.aliases
