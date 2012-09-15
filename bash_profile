# .bash_profile

# Get the aliases and functions
if [[ -f ~/.bashrc ]]; then
  . ~/.bashrc
fi

# User specific environment and startup programs
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/ssl/bin:/usr/local/git/bin:$PATH

PS1='\[\033[0;32m\]\u\[\033[0;34m\] \w\[\033[00m\]: '
export PS1
