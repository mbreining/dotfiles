# Gets called IF the shell is a login shell.
# First ~/.zshrc then ~/.zlogin.

# Colors
autoload -U colors # makes color constants available
colors
export CLICOLOR=1 # enable colored output from ls, etc

# Prompt
# Return git HEAD which can then be appended to prompt.
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " [%{%B%F{blue}%}${ref#refs/heads/}$(parse_git_dirty)%{%f%k%b%K{black}%B%F{green}%}]"
}

# Checks if working tree is dirty
function parse_git_dirty() {
  #local SUBMODULE_SYNTAX=''
  #if [[ $POST_1_7_2_GIT -gt 0 ]]; then
  #      SUBMODULE_SYNTAX="--ignore-submodules=dirty"
  #fi
  if [[ -n $(git status -s ${SUBMODULE_SYNTAX}  2> /dev/null) ]]; then
    echo " %{%F{red}%}*%{%f%k%b%}"
  else
    echo ""
  fi
}

#PROMPT='%{%f%k%b%}
#%{%K{black}%B%F{green}%}%n%{%B%F{blue}%}@%{%B%F{cyan}%}%m%{%B%F{green}%} %{%b%F{yellow}%K{black}%}%~%{%B%F{green}%}$(git_prompt_info)%E%{%f%k%b%}
#%{%K{black}%}$(_prompt_char)%{%K{black}%} %#%{%f%k%b%} '
PROMPT='%{%f%k%b%}
%{%b%F{yellow}%K{black}%}%~%{%B%F{green}%}$(git_prompt_info)%{%K{black}%} %#%{%f%k%b%} '
RPROMPT='!%{%B%F{cyan}%}%!%{%f%k%b%}'
#export PS1='$(git_prompt_info)[${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%~%{$reset_color%}] '

# Completion
# autocompletion for ruby_test
# works with tu/tf aliases
function _ruby_tests() {
  if [[ -n $words[2] ]]; then
    compadd `ruby_test -l ${words[2]}`
  fi
}
compdef _ruby_tests ruby_test

# autocompletion for ruby_spec
# works with sm/sc aliases
function _ruby_specs() {
  if [[ -n $words[2] ]]; then
    compadd `ruby_spec -l ${words[2]}`
  fi
}
compdef _ruby_specs ruby_spec

# autocompletion for ruby_tu_rs
# works with su/sf aliases
function _ruby_mixed_tests() {
  if [[ -n $words[2] ]]; then
    compadd `ruby_tu_rs -l ${words[2]}`
  fi
}
compdef _ruby_mixed_tests ruby_tu_rs

function _git_remote_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    if (( CURRENT == 2 )); then
      # first arg: operation
      compadd create publish rename delete track
    elif (( CURRENT == 3 )); then
      if [[ $words[2] == "publish" ]]; then
        # second arg: local branch name
        compadd `git branch -l | sed "s/[ \*]//g"`
      else;
        # second arg: remote branch name
        compadd `git branch -r | grep -v HEAD | sed "s/.*\///" | sed "s/ //g"`
      fi
    elif (( CURRENT == 4 )); then
      # third arg: remote name
      compadd `git remote`
    fi
  else;
    _files
  fi
}
compdef _git_remote_branch grb

# autocompletion for schema
function _rails_tables() {
  if [[ -n $words[2] ]]; then
    compadd `schema -l ${words[2]}`
  fi
}
compdef _rails_tables schema

# autocompletion for cuc
function _cucumber_features() {
  compadd `ls features/**/*.feature | sed "s/features\/\(.*\).feature/\1/"`
}
compdef _cucumber_features cuc
