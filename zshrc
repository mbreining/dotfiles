# zsh startup files: http://zsh.sourceforge.net/Intro/intro_3.html
# sources: https://github.com/myfreeweb/zshuery
#          http://zanshin.net/2013/02/02/zsh-configuration-from-the-ground-up/

is_mac() { [[ $OSTYPE == darwin* ]] }
is_freebsd() { [[ $OSTYPE == freebsd* ]] }
is_linux() { [[ $OSTYPE == linux-gnu ]] }

has_brew() { [[ -n ${commands[brew]} ]] }
has_apt() { [[ -n ${commands[apt-get]} ]] }
has_yum() { [[ -n ${commands[yum]} ]] }

source $HOME/.zsh/settings.zsh # cmd line options, completion, path, bindkeys, history
source $HOME/.zsh/appearance.zsh # colors, prompt
source $HOME/.zsh/aliases.zsh
#source $HOME/.zsh/functions.zsh

# This loads RVM into a shell session
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

[[ -f $HOME/.zshrc.local ]] && . "$HOME/.zshrc.local"
