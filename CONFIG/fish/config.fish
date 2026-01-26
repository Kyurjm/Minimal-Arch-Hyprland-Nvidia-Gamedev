# Remove Fish Greetings
set -U fish_greeting ""

# Yazi
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# Editor
set -x EDITOR nvim
set -x VISUAL nvim

# Alias
alias ls 'eza -a --icons --git'
alias grep 'grep --color=auto'
alias music ncmpcpp
alias volume pulsemixer
alias bluetooth bluetui
alias wifi impala

# UV Autocompletion
uv generate-shell-completion fish | source
uvx --generate-shell-completion fish | source

# Ollama
set -x OLLAMA_API_BASE http://127.0.0.1:11434

# Rust
if test -f "$HOME/.cargo/env.fish"
    source "$HOME/.cargo/env.fish"
end

# PIPX
fish_add_path /home/kyurjm/.local/bin

# Zoxide
zoxide init fish | source

# Nvim Nightly Build
fish_add_path $HOME/.local/share/bob/nvim-bin

# Color
set -gx TERM xterm-256color
