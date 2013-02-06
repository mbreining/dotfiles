# Gets called IF the shell is interactive.
# Invocation order: ~/.zshrc then ~/.zlogin.

# Completion
autoload -U compinit && compinit
setopt auto_cd # automatically enter directories without cd

# Editor
export EDITOR="vim --noplugin" # use vim as my editor
export SVN_EDITOR="vim --noplugin" # disable vim plugins when editing files with Subversion

# Key bindings
bindkey -e # emacs mode
bindkey ^R history-incremental-search-backward # use incremental search

# Prompt
setopt prompt_subst # expand functions in the prompt
export PROMPT='[${SSH_CONNECTION+"%n@%m:"}%~] ' # simple prompt (no git integration)

# History
HISTSIZE=1000
SAVEHIST=1000
HISTORY=$HOME/.zsh_history
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplicate history entries
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

# Path
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH

# DYLD_LIBRARY_PATH (load path for dynamic shared libraries)
# This was needed in order to get /usr/local/bin/search to work
#export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH

# This loads RVM into a shell session
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
