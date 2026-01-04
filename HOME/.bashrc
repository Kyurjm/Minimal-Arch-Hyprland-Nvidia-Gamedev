#
# ~/.bashrc
#
# Default
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\W]'
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
alias music='ncmpcpp'
alias volume='pulsemixer'
alias bluetooth='bluetui'
alias wifi='impala'

# Rust
. "$HOME/.cargo/env"

# Created by `pipx` on 2026-01-04 12:50:46
export PATH="$PATH:/home/kyurjm/.local/bin"

# UV Autocomplete
eval "$(uv generate-shell-completion bash)"
eval "$(uvx --generate-shell-completion bash)"

# Ollama
export OLLAMA_API_BASE=http://127.0.0.1:11434
