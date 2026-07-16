export PATH="/root/bin:${PATH}"

# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/nix-community/home-manager/issues/177.
export HISTFILE="/root/.zsh_history"
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
# export HISTTIMEFORMAT="[%F %T] "
# export HIST_STAMPS="[%F %T] "

mkdir -p "$(dirname "$HISTFILE")"

# https://github.com/warpdotdev/Warp/issues/3422#issuecomment-2137925034
setopt HIST_IGNORE_ALL_DUPS # Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_SPACE    # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS    # Older duplicates are omitted.
setopt INC_APPEND_HISTORY   # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY        # Share history between all sessions.

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

export STARSHIP_CONFIG=~/.starship.toml
eval "$(starship init zsh)"
eval "$(atuin init zsh --disable-up-arrow)"

#bindkey "^[[B" history-substring-search-down
#bindkey "^[[A" history-substring-search-up
