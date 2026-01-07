#
# ~/.bashrc
#
# Default
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\W]$ '

# Use bash-completion, if available, and avoid double-sourcing
[[ $PS1 &&
  ! ${BASH_COMPLETION_VERSINFO:-} &&
  -f /usr/share/bash-completion/bash_completion ]] &&
  . /usr/share/bash-completion/bash_completion

##################################################

# Yazi
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

# Terminal Editor
export EDITOR=nvim
export VISUAL=nvim

# Zoxide
eval "$(zoxide init bash)"

# Alias
alias cd='z'
alias ls='eza -a --icons --git'
alias grep='grep --color=auto'
alias music='ncmpcpp'
alias volume='pulsemixer'
alias bluetooth='bluetui'
alias wifi='impala'

# UV Autocomplete
eval "$(uv generate-shell-completion bash)"
eval "$(uvx --generate-shell-completion bash)"

# Ollama
export OLLAMA_API_BASE=http://127.0.0.1:11434
