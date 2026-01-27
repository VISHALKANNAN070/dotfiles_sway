# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/vishal/.zshrc'

autoload -Uz compinit
compinit

setopt INTERACTIVE_COMMENTS
zle -N autocomplete-word

source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

#zoxide
eval "$(zoxide init zsh)"



# End of lines added by compinstall

#alias
alias c='clear'
alias q='exit'
alias l='yay -Ss'
alias g='yay -S'
alias w='micro'
alias v="nvim"
alias f='yazi'
alias ff="fastfetch"
alias disk='df -h | awk "NR==1 || (\$1 ~ /nvme0n1/ && \$6 != \"\")"'
alias aa="linux-toolkit"
alias hxh="mpv --playlist=~/Movies/hxh/playlist.txt"
mem() {
  ps -eo comm,rss --no-headers |
  awk '
    { mem[$1]+=$2; total+=$2 }
    END {
      for (p in mem)
        printf "%-25s %8.1f MB\n", p, mem[p]/1024
      printf "TOTAL RSS: %.1f MB\n", total/1024 > "/dev/stderr"
    }
  ' |
  sort -k2 -nr |
  head
}

declare -A pomo_options=(
  ["work"]="45m"
  ["short"]="25m"
  ["mini"]="1m"
  ["break"]="10m"
)

pomodoro () {
  local key="$1"
  local val="${pomo_options[$key]}"

  if [[ -n "$val" ]]; then
    # Reduced -S to 30 so 'br' (break) actually shows the rainbow
    echo "$key" | lolcat -f -S 30 -F 0.5
    
    if timer "$val"; then
      # The { ... } &>/dev/null & part hides the "Job done" message
      { notify-send -a "Pomodoro" -u critical "Session Finished" "Your '$key' session is done!" ; } &>/dev/null &
    fi
  else
    echo "Usage: pomodoro [work|short|mini|break]"
  fi
}

alias 45="pomodoro 'work'"
alias 25="pomodoro 'short'"
alias 1="pomodoro 'mini'"
alias br="pomodoro 'break'"

#Username custom
autoload -Uz vcs_info
precmd() { vcs_info }
setopt prompt_subst

# Colors
name_color="%F{blue}"
arrow_color="%F{green}"
path_color="%F{yellow}"


PROMPT=$'%F{blue}${USER}%f%F{green}%f %F{yellow}%~%f\n%F{green}>%f '
export "MICRO_TRUECOLOR"=1
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.nvm/versions/node/v24.13.0/bin:$PATH"

# --- Fast NVM lazy load ---
export NVM_DIR="$HOME/.nvm"

_nvm_lazy_load() {
  unset -f node npm npx nvm _nvm_lazy_load
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
}

for cmd in node npm npx nvm; do
  eval "$cmd() { _nvm_lazy_load; $cmd \"\$@\"; }"
done
# --- End fast lazy load ---

export EDITOR="nvim"
export VISUAL="nvim"

clear() {
  printf '\033[3J\033c\033[2J'
}

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
