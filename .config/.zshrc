# History
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt INTERACTIVE_COMMENTS
bindkey -e

# Completion
autoload -Uz compinit
compinit

# zsh-autocomplete
source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# zoxide
eval "$(zoxide init zsh)"

# Aliases
alias c='clear'
alias q='exit'
alias l='yay -Ss'
alias g='yay -S'
alias v='nvim'
alias f='yazi'
alias ff='fastfetch'
alias disk='df -h | awk "NR==1 || (\$1 ~ /nvme0n1/ && \$6 != \"\")"'
alias aa='linux-toolkit'
alias mem='sudo ps_mem | tail -8'

# Pomodoro
declare -A pomo_options=(
  [work]='45m'
  [short]='25m'
  [break]='10m'
)

pomodoro() {
  local key="$1"
  local val="${pomo_options[$key]}"

  if [[ -n "$val" ]]; then
    echo "$key" | lolcat -f -S 30 -F 0.5
    timer "$val" && notify-send -a "Pomodoro" -u critical \
      "Session Finished" "Your '$key' session is done!" &>/dev/null &
  else
    echo "Usage: pomodoro [work|short|break]"
  fi
}

alias 45="pomodoro work"
alias 25="pomodoro short"
alias br="pomodoro break"

# Prompt
setopt prompt_subst
PROMPT=$'%F{blue}%n%f %F{yellow}%~%f\n%F{green}>%f '

# Environment
export EDITOR='nvim'
export VISUAL='nvim'
export PATH="$HOME/.local/bin:$PATH"

# NVM (lazy load)
export NVM_DIR="$HOME/.nvm"

_nvm_lazy_load() {
  unset -f node npm npx nvm _nvm_lazy_load
  [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
}

for cmd in node npm npx nvm; do
  eval "$cmd() { _nvm_lazy_load; $cmd \"\$@\"; }"
done
