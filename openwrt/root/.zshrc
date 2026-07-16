export PATH="/root/bin:${PATH}"

# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/nix-community/home-manager/issues/177.
export HISTSIZE="1000000000"
export SAVEHIST="1000000000"

export HISTFILE="/root/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

alias -- ..='cd ..'
alias -- ....='cd ../..'
alias -- ........='cd ../../..'
alias -- mkdir='mkdir -pv'
alias -- mv='mv -v'
alias -- cp='cp -v'
alias -- rm='rm -v'
alias -- grep='grep --color=auto'
alias -- ip='ip --color'
alias -- ll='ls -alh --color=auto -t'
alias -- ls='ls --color=auto'
alias -- rg='rg --pcre2 --glob '\''!{/proc,/sys,$(go env GOPATH),**/.git/*}'\'''
alias -- fd='fd --absolute-path --exclude /proc --exclude /sys --exclude $(go env GOPATH) --exclude '\''**/.git/*'\'''

eval "$(starship init zsh)"
eval "$(atuin init zsh --disable-up-arrow)"

#bindkey "^[[B" history-substring-search-down
#bindkey "^[[A" history-substring-search-up
