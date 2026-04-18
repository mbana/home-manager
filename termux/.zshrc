
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

eval "$(atuin init zsh --disable-up-arrow)"
eval "$(starship init zsh)"
