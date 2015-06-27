__command git && {

    source $CMPDIR/git-completion.bash
    source $CMPDIR/git-flow-completion.bash

    source $INCDIR/git-prompt.sh

    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    PS1=$PS1${GREEN}'$(__git_ps1 "[%s]")'$NC

}
