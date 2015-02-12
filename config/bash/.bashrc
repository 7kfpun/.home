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

if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

export DEBFULLNAME="__BASH_DEBFULLNAME__"
export DEBEMAIL="__BASH_DEBEMAIL__"
export USERNAME="__BASH_USERNAME__"
export EMAIL="__BASH_EMAIL__"
export HISTTIMEFORMAT="%h/%d - %H:%M:%S "
export LANG="en_US.UTF-8"

# AWS credentials
export EC2_PRIVATE_KEY=$(echo $HOME/.keys/ec2/pk-*.pem)
export EC2_CERT=$(echo $HOME/.keys/ec2/cert-*.pem)
export AWS_CREDENTIAL_FILE=$HOME/.keys/ec2/aws-credential-file.txt

# color ls
if [ "$TERM" != "dumb" ]; then
    export LS_OPTIONS='--color=auto --group-directories-first'
    eval `dircolors -b $HOME/.dir_colors`
fi

# Completion
source $HOME/.home/config/bash/completion/ack-grep-completion.bash
# source $HOME/.home/config/bash/completion/ag-completion.bash
source $HOME/.home/config/bash/completion/django-completion.bash
# source $HOME/.home/config/bash/completion/gem1.9.1-completion.bash
# source $HOME/.home/config/bash/completion/git-buildpackage-completion.bash
source $HOME/.home/config/bash/completion/git-completion.bash
source $HOME/.home/config/bash/completion/git-flow-completion.bash
source $HOME/.home/config/bash/completion/mercurial-completion.bash
source $HOME/.home/config/bash/completion/openvpn-completion.bash
source $HOME/.home/config/bash/completion/pip-completion.bash
source $HOME/.home/config/bash/completion/vagrant-completion.bash
# source $HOME/.home/config/bash/completion/virtualenv-completion.bash
