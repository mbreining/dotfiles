# vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker:

# Zsh config {{{
source $HOME/.zsh/settings # prompt, completion, path, bindkeys, history
source $HOME/.zsh/aliases
source $HOME/.zsh/colors
source $HOME/.zsh/functions
# }}}

# Zsh local config overrides {{{
[[ -f $HOME/.zshrc.local ]] && . "$HOME/.zshrc.local"
# }}}
