# vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker

# Miscellaneous {{{
alias 'ttop=top -ocpu -R -F -s 2 -n30' # fancy top
alias rm='rm -i' # make rm less destructive
alias vi=vim
alias python=python3
# }}}

# Directory handling {{{
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias 'bk=cd $OLDPWD'

ls --color -d . &>/dev/null 2>&1 && alias ls="ls --color=tty -Fh" || alias ls="ls -GFh"
alias la='ls -d .*' # show hidden files/directories only
alias lsd='ls -aFhlG'
alias ll='ls -l'
alias tree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"
alias 'dus=du -sckx * | sort -nr' # directories sorted by size
alias 'wordy=wc -w * | sort | tail -n10' # sort files in current directory by the number of words they contain
alias 'wcfile=find . -type f | wc -l' # number of files (not directories)

alias mkdir="mkdir -p"
# }}}

# Git {{{
alias gv='git log --pretty=format:'%s' | cut -d " " -f 1 | sort | uniq -c | sort -nr'
alias gsh="git shortlog | grep -E '^[ ]+\w+' | wc -l" # show number of commits for current repos for all developers
alias gu="git shortlog | grep -E '^[^ ]'" # show list of all developers and the number of commits they've made
# }}}
