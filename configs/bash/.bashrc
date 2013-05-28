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

export DEBFULLNAME="Pun Ka Fai"
export DEBEMAIL="jp@multichannel.net"

# Completion
source $HOME/.home/bash_completion/vagrant-completion.bash
source $HOME/.home/bash_completion/pycompletion/pip-completion.bash
source $HOME/.home/bash_completion/pycompletion/virtualenv-completion.bash
