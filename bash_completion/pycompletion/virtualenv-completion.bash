#!/bin/sh

_virtualenv()
{
    local cur prev split=false

    COMPREPLY=()
    cur=`_get_cword`
    prev=${COMP_WORDS[COMP_CWORD-1]}

    _split_longopt && split=true

    case "$prev" in
        -p|--python)
            _filedir
            return 0
            ;;
    esac

    $split && return 0

    if [[ "$cur" == -* ]]; then
        COMPREPLY=( $( compgen -W '-h -v -q -p --help --verbose --version \
            --quiet --python= --clear --no-site-packages --unzip-setuptools \
            --relocatable --distribute' -- "$cur" ) )
        return 0
    fi

    return 0
} &&
complete -F _virtualenv -o default virtualenv virtualenv.py
