# Completion
autoload -U compinit
compinit

# Automatically enter directories without cd
setopt auto_cd

# Use vim as my editor
export EDITOR="vim --noplugin"

# Disable vim plugins when editing files with Subversion
export SVN_EDITOR="vim --noplugin"

# Emacs mode
bindkey -e

# Use incremental search
bindkey ^R history-incremental-search-backward

# Expand functions in the prompt
setopt prompt_subst

# Prompt
export PS1='[${SSH_CONNECTION+"%n@%m:"}%~] '

# History
HISTSIZE=1000
SAVEHIST=1000
HISTORY=~/.zsh/history

setopt sharehistory
setopt INC_APPEND_HISTORY

# Ignore duplicate history entries
setopt histignoredups

# Path
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/openssl/bin:/usr/local/git/bin:$PATH

# DYLD_LIBRARY_PATH (load path for dynamic shared libraries)
# This was needed in order to get /usr/local/bin/search to work
#export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH

# Bring in all my aliases and functions
source ~/etc/aliases
source ~/etc/functions

# This loads RVM into a shell session
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
