# Miscellaneous {{{
alias 'ttop=top -ocpu -R -F -s 2 -n30' # fancy top
alias rm='rm -i' # make rm less destructive
alias acat='< ~/.aliases.sh' # cat aliases to display
alias fcat='< ~/.functions.sh' # cat functions to display
alias sz='source ~/.zshrc'
#alias vi='nvim'
#alias vim='nvim'
alias vi='vim'
# }}}

# Directory movement {{{
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias 'bk=cd $OLDPWD'
# }}}

# Directory listing {{{
ls --color -d . &>/dev/null 2>&1 && alias ls="ls --color=tty -Fh" || alias ls="ls -GFh"
alias la='ls -a | egrep "^\."'
alias lh='ls -d .*' # show hidden files/directories only
alias lsd='ls -aFhlG'
alias ll='ls -l'
alias tree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"
alias 'dus=du -sckx * | sort -nr' # directories sorted by size
alias 'wordy=wc -w * | sort | tail -n10' # sort files in current directory by the number of words they contain
alias 'filecount=find . -type f | wc -l' # number of files (not directories)
# }}}

# Git {{{
alias gv='git log --pretty=format:'%s' | cut -d " " -f 1 | sort | uniq -c | sort -nr'
alias gsh="git shortlog | grep -E '^[ ]+\w+' | wc -l" # show number of commits for current repos for all developers
alias gu="git shortlog | grep -E '^[^ ]'" # show list of all developers and the number of commits they've made
# }}}

# Mac only {{{
if type is_mac &>/dev/null && is_mac; then
  alias ql='qlmanage -p 2>/dev/null' # OS X Quick Look
  alias oo='open .' # open current directory in OS X Finder
  alias apps='mdfind "kMDItemAppStoreHasReceipt=1"' # show all Mac App store apps
  alias resetaddressbook='tccutil reset AddressBook' # reset Address Book permissions in Mountain Lion (and later presumably)
  alias refreshbrew='brew outdated | while read cask; do brew upgrade $cask; done' # refresh brew by upgrading all outdated casks
  alias rebuildopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.fram ework/Support/lsregister -kill -r -domain local -domain system -domain user' # rebuild Launch Services to remove duplicate entries on Open With menu
fi
#}}}
