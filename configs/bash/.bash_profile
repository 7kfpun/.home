# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi


# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


# Set Guake terminal keeps title unchanged
[ -f "/usr/bin/guake" ] && gconftool-2 --set /apps/guake/general/use_vte_titles --type boolean false

# bash enable ctrl-s for terminal
vim()
{
    local STTYOPTS="$(stty --save)"
    stty stop '' -ixoff
    command vim "$@"
    stty "$STTYOPTS"
}

# magic mouse setting
sudo rmmod hid_magicmouse
sudo modprobe hid_magicmouse scroll-speed=55 scroll-acceleration=1
mouse_id=$(xinput list | grep 's Mouse' | egrep -o "[[:digit:]]{2}") 
eval "$(xinput set-button-map $mouse_id 1 2 3 5 4)"
