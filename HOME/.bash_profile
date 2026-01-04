#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# UWSM
if uwsm check may-start; then
  exec uwsm start hyprland.desktop
fi

# Rust
. "$HOME/.cargo/env"

# Created by `pipx` on 2026-01-04 12:50:46
export PATH="$PATH:/home/kyurjm/.local/bin"
