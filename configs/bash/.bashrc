PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
# Use move to trash instead of remove
rm="mv -t ~/.Trash"


### Alias definitions. ###
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
fi

export DEBFULLNAME="__BASH_DEBFULLNAME__"
export DEBEMAIL="__BASH_DEBEMAIL__"
export USERNAME="__BASH_USERNAME__"
export EMAIL="__BASH_EMAIL__"
export HISTTIMEFORMAT="%h/%d - %H:%M:%S "
export LANG="en_US.UTF-8"

# color ls
if [ "$TERM" != "dumb" ]; then
    export LS_OPTIONS='--color=auto --group-directories-first'
    eval `dircolors -b $HOME/.home/configs/bash/.dir_colors`
fi

# Completion
source $HOME/.home/bash_completion/vagrant-completion.bash
source $HOME/.home/bash_completion/pycompletion/pip-completion.bash
source $HOME/.home/bash_completion/pycompletion/virtualenv-completion.bash
