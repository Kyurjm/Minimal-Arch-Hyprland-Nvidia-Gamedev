#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# UWSM
if uwsm check may-start; then
    exec uwsm start hyprland.desktop
fi
