# zsh startup files: http://zsh.sourceforge.net/Intro/intro_3.html
# sources: https://github.com/myfreeweb/zshuery
#          http://zanshin.net/2013/02/02/zsh-configuration-from-the-ground-up/

# Zsh config {{{
source $HOME/.zsh/settings.zsh # prompt, completion, path, bindkeys, history
source $HOME/.aliases.sh
source $HOME/.functions.sh
# }}}

# Zsh local config overrides {{{
[[ -f $HOME/.zshrc.local ]] && . "$HOME/.zshrc.local"
# }}}
