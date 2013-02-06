# Gets called IF the shell is a login shell.
# Invocation order: ~/.zshrc then ~/.zlogin.

# Colors
autoload -U colors # makes color constants available
colors
export CLICOLOR=1 # enable colored output from ls, etc

# Prompt
# Return git HEAD which can then be appended to prompt.
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " %{%B%F{green}%}[%{%B%F{blue}%}${ref#refs/heads/}$(parse_git_dirty)%{%f%b%B%F{green}%}]"
}

# Checks if working tree is dirty
function parse_git_dirty() {
  local SUBMODULE_SYNTAX="--ignore-submodules=dirty" # available with git 1.7.2 and above only
  if [[ -n $(git status -s ${SUBMODULE_SYNTAX} 2> /dev/null) ]]; then
    echo " %{%F{red}%}*%{%f%b%}"
  else
    echo ""
  fi
}

# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
PROMPT='%{%f%k%b%}
%{%b%F{yellow}%}%~$(git_prompt_info) %{%b%F{blue}%}%#%{%f%b%} '
RPROMPT='!%{%B%F{cyan}%}%!%{%f%k%b%}'

# Bring in all my functions and aliases
[[ -f $HOME/.functions ]] && . $HOME/.functions
[[ -f $HOME/.aliases ]] && . $HOME/.aliases
