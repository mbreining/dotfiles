# zsh startup files: http://zsh.sourceforge.net/Intro/intro_3.html
# sources: https://github.com/myfreeweb/zshuery
#          http://zanshin.net/2013/02/02/zsh-configuration-from-the-ground-up/

# Zsh customization {{{
# Drop zsh.conf under ~/.zsh and add the following options as key-value pairs:
#   - box_name:<machine_name> # shown in prompt
#   - git_prompt:[light] # load a lighter version of the git prompt
function zsh_conf {
  local conf_file=~/.zsh/zsh.conf
  if [ -e $conf_file ]; then
    setting=$(egrep "^$1:" $conf_file)
    [ $setting ] && echo $setting | cut -d ":" -f 2
  fi
}
# }}}

# Environment {{{
is_mac() { [[ $OSTYPE == darwin* ]] }
is_freebsd() { [[ $OSTYPE == freebsd* ]] }
is_linux() { [[ $OSTYPE == linux-gnu ]] }

has_brew() { [[ -n ${commands[brew]} ]] }
has_apt() { [[ -n ${commands[apt-get]} ]] }
has_yum() { [[ -n ${commands[yum]} ]] }
# }}}

# Zsh config {{{
source $HOME/.zsh/settings.zsh # prompt, completion, path, bindkeys, history
source $HOME/.aliases.sh
source $HOME/.functions.sh
# }}}

# Zsh local config overrides {{{
[[ -f $HOME/.zshrc.local ]] && . "$HOME/.zshrc.local"
# }}}
