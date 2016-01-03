# Exports {{{
export EDITOR="vim"
export GITHUB_USER="mbreining"
export LC_COLLATE=C # CTAGS Sorting in vim/Emacs is better behaved with this in place
export LESS="--ignore-case --raw-control-chars"
export MANPAGER="less -X" # don't clear the screen after quitting man
export PAGER="less"
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin
export TERM=xterm-256color
# }}}

# Set options basics {{{
setopt no_beep # Don't beep on error
setopt interactive_comments # Allow comments even in interactive shells

# Changing Directories
setopt auto_cd # If you type foo, and it isn't a command, and it is a directory in your cdpath, go there
setopt cdablevarS # If argument to cd is the name of a parameter whose value is a valid directory, it will become the current directory
setopt pushd_ignore_dups # Don't push multiple copies of the same directory onto the directory stack

# Expansion and Globbing
setopt extended_glob # Treat #, ~, and ^ as part of patterns for filename generation

# Correction
setopt correct # Spelling correction for commands
setopt correctall # Spelling correction for arguments

# Prompt
setopt prompt_subst # Enable parameter expansion, command substitution, and arithmetic expansion in the prompt
setopt transient_rprompt # Only show the rprompt on the current prompt

# Scripts and Functions
setopt multios # Perform implicit tees or cats when multiple redirections are attempted
# }}}

# Auto completion {{{
setopt always_to_end # When completing from the middle of a word, move the cursor to the end of the word
setopt auto_menu # Show completion menu on successive tab press. needs unsetop menu_complete to work
setopt auto_name_dirs # Any parameter that is set to the absolute name of a directory immediately becomes a name for that directory
setopt complete_in_word # Allow completion from within a word/phrase
unsetopt menu_complete # Do not autoselect the first completion entry

autoload -U compinit && compinit
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
setopt append_history # Allow multiple terminal sessions to all append to one zsh command history
setopt extended_history # Save timestamp of command and duration
setopt inc_append_history # Add comamnds as they are typed, don't wait until shell exit
setopt hist_expire_dups_first # When trimming history, lose oldest duplicates first
setopt hist_ignore_dups # Ignore duplicate history entries
setopt hist_ignore_space # Remove command line from history list when first character on the line is a space
setopt hist_find_no_dups # When searching history don't display results already cycled through twice
setopt hist_reduce_blanks # Remove extra blanks from each command line being added to history
setopt hist_verify # Don't execute, just expand history
setopt share_history # Imports new commands and appends typed commands to history

HISTSIZE=10000
SAVEHIST=9000
HISTFILE=$HOME/.zsh_history
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

unset LSCOLORS
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad
export LS_COLORS=exfxcxdxbxegedabagacad

# Enable color in grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='3;33'
# }}}

# Prompt {{{
# Python virtualenv
function _virtualenv_info {
  [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

# ± When you're in a Git repo, ☿ in a Mercurial repo, ○ otherwise
function _prompt_char {
  git branch >/dev/null 2>/dev/null && echo '☿' && return
  hg root >/dev/null 2>/dev/null && echo '±' && return
  echo '○'
}

function box_name {
  [ $(zsh_conf "box_name") ] && zsh_conf "box_name" || hostname -s
}

# http://blog.joshdick.net/2012/12/30/my_git_prompt_for_zsh.html
# Copied from https://gist.github.com/4415470
# Adapted from code found at <https://gist.github.com/1712320>.

# Modify the colors and symbols in these variables as desired.
GIT_PROMPT_SYMBOL="%{$fg[blue]%}±"
GIT_PROMPT_PREFIX="%{$fg[green]%} [%{$reset_color%}"
GIT_PROMPT_SUFFIX="%{$fg[green]%}]%{$reset_color%}"
GIT_PROMPT_AHEAD="%{$fg[red]%}ANUM%{$reset_color%}"
GIT_PROMPT_BEHIND="%{$fg[cyan]%}BNUM%{$reset_color%}"
GIT_PROMPT_MERGING="%{$fg_bold[magenta]%}⚡︎%{$reset_color%}"
GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}u%{$reset_color%}"
GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}m%{$reset_color%}"
GIT_PROMPT_STAGED="%{$fg_bold[green]%}s%{$reset_color%}"

# Show Git branch/tag, or name-rev if on detached head
function _parse_git_branch() {
  (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}

# Show different symbols as appropriate for various Git repository states
function _parse_git_state() {
  local GIT_STATE=""
  if [ $(zsh_conf "git_prompt") ] && [ $(zsh_conf "git_prompt") = "light" ]; then
    # Simple git prompt that indicates when staging/working directory is dirty
    local SUBMODULE_SYNTAX="--ignore-submodules=dirty" # available with git 1.7.2 and above only
    if [[ -n $(git status -s ${SUBMODULE_SYNTAX} 2> /dev/null) ]]; then
      GIT_STATE="%{%F{red}%}*%{%f%b%}"
    fi
  else
    # More advanced git prompt that shows the state in more details
    local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
    if [ "$NUM_AHEAD" -gt 0 ]; then
      GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
    fi

    local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
    if [ "$NUM_BEHIND" -gt 0 ]; then
      GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
    fi

    local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
    if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
      GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
    fi

    if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
      GIT_STATE=$GIT_STATE$GIT_PROMPT_UNTRACKED
    fi

    if ! git diff --quiet 2> /dev/null; then
      GIT_STATE=$GIT_STATE$GIT_PROMPT_MODIFIED
    fi

    if ! git diff --cached --quiet 2> /dev/null; then
      GIT_STATE=$GIT_STATE$GIT_PROMPT_STAGED
    fi
  fi

  if [[ -n $GIT_STATE ]]; then
    echo "$GIT_PROMPT_PREFIX$GIT_STATE$GIT_PROMPT_SUFFIX"
  fi
}

# If inside a Git repository, print its branch and state
function _git_prompt_string() {
  local git_where="$(_parse_git_branch)"
  [ -n "$git_where" ] && echo "on %{$fg[blue]%}${git_where#(refs/heads/|tags/)}$(_parse_git_state)"
}

# Determine Ruby version whether using RVM or rbenv
# the chpwd_functions line cause this to update only when the directory changes
function _update_ruby_version() {
  typeset -g ruby_version=''
  if which rvm-prompt &> /dev/null; then
    ruby_version="$(rvm-prompt i v g)"
  else
    if which rbenv &> /dev/null; then
      ruby_version="$(rbenv version | sed -e "s/ (set.*$//")"
    fi
  fi
}
chpwd_functions+=(_update_ruby_version)

function _current_pwd {
  echo $(pwd | sed -e "s,^$HOME,~,")
}

# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
PROMPT='
${PR_GREEN}%n%{$reset_color%} %{$FG[239]%}at%{$reset_color%} ${PR_BOLD_BLUE}$(box_name)%{$reset_color%} %{$FG[239]%}in%{$reset_color%} ${PR_BOLD_YELLOW}$(_current_pwd)%{$reset_color%} $(_git_prompt_string)
$(_prompt_char) '
export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color [(y)es (n)o (a)bort (e)dit]? "
RPROMPT='${PR_GREEN}$(_virtualenv_info)%{$reset_color%} ${PR_RED}${ruby_version}%{$reset_color%}'
# }}}
