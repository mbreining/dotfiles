# zsh startup files: http://zsh.sourceforge.net/Intro/intro_3.html
# sources: https://github.com/myfreeweb/zshuery
#          http://zanshin.net/2013/02/02/zsh-configuration-from-the-ground-up/

# ===== Zsh configuration file
# Just drop .zsh.conf under ~ and add one or more of the following options:
#   - box_name:<machine_name> # shown in prompt
#   - git_prompt:[light] # load a lighter version of the git prompt
function zsh_conf {
  local conf_file=~/.zsh.conf
  if [ -e $conf_file ]; then
    setting=$(egrep "^$1:" $conf_file)
    [ $setting ] && echo $setting | cut -d ":" -f 2
  fi
}

function box_name {
  [ $(zsh_conf "box_name") ] && zsh_conf "box_name" || hostname -s
}

# ===== Detect environment
is_mac() { [[ $OSTYPE == darwin* ]] }
is_freebsd() { [[ $OSTYPE == freebsd* ]] }
is_linux() { [[ $OSTYPE == linux-gnu ]] }

has_brew() { [[ -n ${commands[brew]} ]] }
has_apt() { [[ -n ${commands[apt-get]} ]] }
has_yum() { [[ -n ${commands[yum]} ]] }

# ===== Setup zsh
source $HOME/.zsh/settings.zsh # cmd line options, completion, path, bindkeys, history
source $HOME/.zsh/appearance.zsh # colors, prompt
source $HOME/.aliases.sh
source $HOME/.functions.sh

# ===== Load autojump
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# ===== Local settings
[[ -f $HOME/.zshrc.local ]] && . "$HOME/.zshrc.local"
