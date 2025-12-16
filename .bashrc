#
# ~/.bashrc
#
# Default
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
##################################################
# Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
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
