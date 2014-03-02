# ADD LOCAL CONFIGURATION HERE
#alias mysql=/usr/local/mysql/bin/mysql
#alias mysqladmin=/usr/local/mysql/bin/mysqladmin
#alias mysql=/usr/local/mysql/bin/mysql2
#alias mysqladmin=/usr/local/mysql/bin/mysqladmin
#alias git=/usr/local/git/bin/git
#alias gitk=/usr/local/git/bin/gitk
#alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
#alias port=/opt/local/bin/port


# DO NOT EDIT BELOW THIS LINE
# ===== Miscellaneous
alias 'ttop=top -ocpu -R -F -s 2 -n30' # fancy top
alias rm='rm -i' # make rm less destructive
alias acat='< ~/.aliases' # cat aliases to display
alias fcat='< ~/.functions' # cat functions to display
alias sz='source ~/.zshrc'

alias cdd="cd $HOME/Dropbox/Dotfiles"
alias cds="cd $HOME/Dropbox/Scripts"

# ===== Directory movement
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias 'bk=cd $OLDPWD'

# ===== Directory listing
ls --color -d . &>/dev/null 2>&1 && alias ls="ls --color=tty -Fh" || alias ls="ls -GFh"
alias la='ls -a | egrep "^\."'
alias lh='ls -d .*' # show hidden files/directories only
alias lsd='ls -aFhlG'
alias ll='ls -l'
alias tree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"
alias 'dus=du -sckx * | sort -nr' # directories sorted by size
alias 'wordy=wc -w * | sort | tail -n10' # sort files in current directory by the number of words they contain
alias 'filecount=find . -type f | wc -l' # number of files (not directories)

# ===== Ruby
alias ri='ri -Tf ansi' # Search Ruby documentation
alias rake="noglob rake" # Necessary to make rake work inside of zsh
#alias be='bundle exec'
#alias bx='bundle exec'
#alias gentags='ctags .'

# ===== Tmux
alias tm='tmux'
alias tml='tmux list-sessions'

# ===== Mutt
alias mu='mutt'

# ===== Git
alias gv='git log --pretty=format:'%s' | cut -d " " -f 1 | sort | uniq -c | sort -nr'
alias gsh="git shortlog | grep -E '^[ ]+\w+' | wc -l" # show number of commits for current repos for all developers
alias gu="git shortlog | grep -E '^[^ ]'" # show list of all developers and the number of commits they've made

# ===== Mercurial (hg)
alias h='hg status'
alias hc='hg commit'
alias push='hg push'
alias pull='hg pull'
alias clone='hg clone'

# ===== Mac only
if type is_mac &>/dev/null && is_mac; then
  alias ql='qlmanage -p 2>/dev/null' # OS X Quick Look
  alias oo='open .' # open current directory in OS X Finder
  alias 'today=calendar -A 0 -f /usr/share/calendar/calendar.mark | sort'
  alias 'mailsize=du -hs ~/Library/mail'
  alias 'smart=diskutil info disk0 | grep SMART' # display SMART status of hard drive
  alias apps='mdfind "kMDItemAppStoreHasReceipt=1"' # show all Mac App store apps
  alias resetaddressbook='tccutil reset AddressBook' # reset Address Book permissions in Mountain Lion (and later presumably)
  alias refreshbrew='brew outdated | while read cask; do brew upgrade $cask; done' # refresh brew by upgrading all outdated casks
  alias rebuildopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.fram ework/Support/lsregister -kill -r -domain local -domain system -domain user' # rebuild Launch Services to remove duplicate entries on Open With menu
fi
