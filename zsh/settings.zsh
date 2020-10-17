# https://blog.callstack.io/supercharge-your-terminal-with-zsh-8b369d689770

# Exports {{{
export EDITOR="vim"
export GITHUB_USER="mbreining"
export LC_COLLATE=C # CTAGS Sorting in vim/Emacs is better behaved with this in place
export LESS="--ignore-case --raw-control-chars"
export MANPAGER="less -X" # don't clear the screen after quitting man
export PAGER="less"
export GIT_PAGER="less"
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin
export TERM=xterm-256color
# }}}

# Set options basics {{{
setopt no_beep # dont beep on error
setopt interactive_comments # allow comments even in interactive shells

# Changing Directories
setopt auto_cd # if you type foo, and it isnt a command, and it is a directory in your cdpath, go there
setopt cdablevarS # if argument to cd is the name of a parameter whose value is a valid directory, it will become the current directory
setopt pushd_ignore_dups # dont push multiple copies of the same directory onto the directory stack

# Expansion and Globbing
setopt extended_glob # treat #, ~, and ^ as part of patterns for filename generation

# Correction
setopt correct # spelling correction for commands
setopt correctall # spelling correction for arguments

# Prompt
setopt prompt_subst # enable parameter expansion, command substitution, and arithmetic expansion in the prompt
setopt transient_rprompt # only show the rprompt on the current prompt

# Scripts and Functions
setopt multios # perform implicit tees or cats when multiple redirections are attempted
# }}}

# Auto completion {{{
setopt always_to_end # when completing from the middle of a word, move the cursor to the end of the word
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # show completion menu on successive tab press. needs unsetop menu_complete to work
setopt auto_name_dirs # any parameter that is set to the absolute name of a directory immediately becomes a name for that directory
setopt complete_in_word # allow completion from within a word/phrase
unsetopt menu_complete # do not autoselect the first completion entry
setopt always_to_end # move cursor to end if word had one match

autoload -Uz compinit && compinit
zmodload -i zsh/complist

# man zshcontrib
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:*' enable git #svn cvs

# Enable completion caching, use rehash to clear
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

# Fallback to built in ls colors
zstyle ':completion:*' list-colors ''

# Make the list prompt friendly
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'

# Make the selection prompt friendly when there are a lot of choices
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Add simple colors to kill
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# List of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

zstyle ':completion:*' menu select=1 _complete _ignored _approximate

# Insert all expansions for expand completer
# zstyle ':completion:*:expand:*' tag-order all-expansions

# Match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# Ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:scp:*' tag-order files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show
# }}}

# Key bindings {{{
bindkey -e # emacs mode
bindkey "^R" history-incremental-search-backward # use incremental search
# }}}

# History {{{
setopt append_history # allow multiple terminal sessions to all append to one zsh command history
setopt extended_history # save timestamp of command and duration
setopt inc_append_history # add comamnds as they are typed, don't wait until shell exit
setopt hist_expire_dups_first # when trimming history, lose oldest duplicates first
setopt hist_ignore_dups # ignore duplicate history entries
setopt hist_ignore_space # remove command line from history list when first character on the line is a space
setopt hist_find_no_dups # when searching history don't display results already cycled through twice
setopt hist_reduce_blanks # remove extra blanks from each command line being added to history
setopt hist_verify # dont execute, just expand history
setopt share_history # imports new commands and appends typed commands to history

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
# }}}
#
# Colors {{{
autoload -U colors && colors # enable colors in prompt

# The variables are wrapped in \%\{\%\}
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
  eval PR_$COLOR='%{$fg_no_bold[${(L)COLOR}]%}'
  eval PR_BOLD_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done

eval RESET='$reset_color'
export PR_RED PR_GREEN PR_YELLOW PR_BLUE PR_WHITE PR_BLACK
export PR_BOLD_RED PR_BOLD_GREEN PR_BOLD_YELLOW PR_BOLD_BLUE
export PR_BOLD_WHITE PR_BOLD_BLACK

# Enable color in grep
export GREP_COLOR='3;33'
# }}}
