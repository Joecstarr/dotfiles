typeset -U path cdpath fpath manpath
for profile in ${(z)NIX_PROFILES}; do
  fpath+=($profile/share/zsh/site-functions $profile/share/zsh/$ZSH_VERSION/functions $profile/share/zsh/vendor-completions)
done

HELPDIR="/nix/store/51yi7b64mxyspaa012c5gwpmg92rs5c5-zsh-5.9.2/share/zsh/$ZSH_VERSION/help"

autoload -U compinit && compinit
source /nix/store/flalyhs27vr9y1353mnx2k1nagwj58pa-zsh-autosuggestions-0.7.1/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history)


eval "$(/nix/store/7d3xxhs2825j4ikfv165k6c95k849xsz-zoxide-0.10.0/bin/zoxide init zsh )"

# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/nix-community/home-manager/issues/177.
HISTSIZE="10000"
SAVEHIST="10000"

HISTFILE="/home/joe/.local/share/zsh/zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

if [[ $options[zle] = on ]]; then
  source <(/nix/store/nvw3nii5qk8c217936k0a974lvc512ga-fzf-0.74.4/bin/fzf --zsh)
fi

# Set shell options
set_opts=(
  HIST_FCNTL_LOCK EXTENDED_HISTORY HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS
  HIST_IGNORE_SPACE SHARE_HISTORY NO_APPEND_HISTORY NO_HIST_FIND_NO_DUPS
  NO_HIST_IGNORE_ALL_DUPS NO_HIST_SAVE_NO_DUPS
)
for opt in "${set_opts[@]}"; do
  setopt "$opt"
done
unset opt set_opts

function tat {
  
  name=$(basename `pwd` | sed -e 's/\.//g')

  if tmux ls 2>&1 | grep "$name: "; then
    true
  else
    tmux new-session -s "$name" -d
  fi
  tmux switch-client -t "$name" 2> /dev/null || tmux attach -t "$name"

  if tmux ls 2>&1 | grep "Useful_Tools: "; then
    true
  else
      tmux new-session -s Useful_Tools "cmus" -d
      tmux new-window -s Useful_Tools -n 2
      tmux send-keys -t Useful_Tools:2 "btop" C-m
  fi

}    

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
  command yazi "$@" --cwd-file="$tmp"
  if cwd="$(<"$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

if [[ $TERM != "dumb" ]]; then
  eval "$(/nix/store/idhgbr9k9ypxzfzchar1hkl5kjd0khli-starship-1.26.0/bin/starship init zsh)"
fi

if test -n "$KITTY_INSTALLATION_DIR"; then
  export KITTY_SHELL_INTEGRATION="no-rc"
  autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
  kitty-integration
  unfunction kitty-integration
fi

eval "$(/nix/store/xnwlm1b2q78in91whkpn5bdazwahvf2p-direnv-2.37.1/bin/direnv hook zsh)"

alias -- ..='cd ..'
alias -- ...='cd ../..'
alias -- ....='cd ../../..'
alias -- c=clear
alias -- cat='bat --style=plain'
alias -- cd=z
alias -- celar=clear
alias -- clera=clear
alias -- e=exit
alias -- eza='eza --icons auto --group-directories-first --no-quotes '\''--icons=always'\'''
alias -- grep='grep --color=auto'
alias -- icat='/nix/store/dy87dzxv945pabii41gl7fn5mqnnsgsx-kitty-0.49.0/bin/kitty +kitten icat'
alias -- ip='ip -color=auto'
alias -- la='eza --color=always -a'
alias -- ll='eza --color=always -alh'
alias -- lla='eza -la'
alias -- ls='eza --icons=always --color=always --no-quotes'
alias -- lt='eza --tree'
alias -- mde='echo " use flake " >> .envrc && direnv allow'
alias -- mv='mv -b'
alias -- note=notes
alias -- notes=''
alias -- open=/nix/store/76nlfdjwr0n1bh2hmwqjbbg4l3azp2hl-xdg-utils-1.2.1/bin/xdg-open
alias -- prune='git fetch --prune || git branch -vv | grep '\''gone]'\'' | awk '\''{print $1}'\'' | xargs git branch -D'
alias -- radar='linecast radar'
alias -- rm='echo Use '\''rip'\'' instead of rm.'
alias -- sl=ls
alias -- ssh='kitty +kitten ssh'
alias -- sunset='linecast sunshine'
alias -- top=btop
alias -- tree='eza --icons=always --color=always --tree --no-quotes'
alias -- v=nvim
alias -- vi=nvim
alias -- vim=nvim
alias -- weather='linecast weather'
alias -- wireguard-import='nmcli connection import type wireguard file'
source /nix/store/flm0avh0db0g4k8wsvyvbz7r2p2aw9pa-zsh-syntax-highlighting-0.8.0/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)



source /nix/store/v5r711wdkdwwyhcn939h0kdqnj612aqr-zsh-history-substring-search-1.1.0/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
