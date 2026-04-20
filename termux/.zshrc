HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

PATH="$HOME/.local/bin:$HOME/.bin:$HOME/bin:$HOME/go/bin:$HOME/.cargo/bin:$PATH"

# Rust stuff
CARGO_NET_GIT_FETCH_WITH_CLI="true"

alias ll='ls -alh --color=auto'
alias ls='ls --color=auto'
alias ip='ip --color'
alias grep='grep --color=auto'

alias ".."='cd ..'
alias "..."='cd ../..'
alias "...."='cd ../../..'
alias mkdir="mkdir -pv"
alias cp="cp -rv"
alias mv="mv -v"
alias rm="rm -vi"

eval "$(atuin init zsh --disable-up-arrow)"
eval "$(starship init zsh)"
