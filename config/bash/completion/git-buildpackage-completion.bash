# -*- shell-script -*-
#
# Bash tab auto-completion rules for git-buildpackage.
#
# Copyright (C) 2010  Siegfried-Angel Gevatter Pujals <siegfried@gevatter.com>
# Copyright (C) 2010  Guido Guenther <agx@sigxcpu.org>
#
# Distributed under the GNU General Public License, version 2.0.

_gbp_branches ()
{
     [ -d .git ] || return 0
     git  for-each-ref --format="%(refname:short)" refs/heads
}


_gbp_options ()
{
    $1 --help | egrep -o '^ +\-\-[a-z\-]+=?'
}


_gbp_comp ()
{
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local prev="${COMP_WORDS[COMP_CWORD - 1]}"
    local options=$1
    local branch_opts=$2

# COMPREPLY considers '=' as a word. For $prev we prefer the word before the actual "="
    if [[ "$prev" == "=" ]]
    then
        prev="${COMP_WORDS[COMP_CWORD - 2]}"
    elif [[ "$cur" == "=" ]]
    then
        cur=""
    fi

    if [[ "${branch_opts}" == *$prev* ]]; then
    local refs=$(_gbp_branches)
        COMPREPLY=( $(compgen -W "$refs" -- $cur ) )
        return 0
    fi

    COMPREPLY=($(compgen -W "$options" -- $cur))
}


have git-buildpackage &&
_git_buildpackage()
{
    local options=$(_gbp_options git-buildpackage)
    local branch_opts="--git-debian-branch\= --git-upstream-branch\="

    _gbp_comp "$options" "$branch_opts"
}
[ "${have:-}" ] && complete -F _git_buildpackage -o default git-buildpackage


have git-dch &&
_git_dch ()
{
    local options=$(_gbp_options git-dch)
    local branch_opts="--debian-branch\="

    _gbp_comp "$options" "$branch_opts"
}
[ "${have:-}" ] && complete -F _git_dch -o default git-dch


have git-import-orig &&
_git_import_orig ()
{
    local options=$(_gbp_options git-import-orig)
    local branch_opts="--debian-branch\= --upstream-branch\="

    _gbp_comp "$options" "$branch_opts"
}
[ "${have:-}" ] && complete -F _git_import_orig -o default git-import-orig


have git-import-dsc &&
_git_import_dsc ()
{
    local options=$(_gbp_options git-import-dsc)
    local branch_opts="--debian-branch\= --upstream-branch\="

    _gbp_comp "$options" "$branch_opts"
}
[ "${have:-}" ] && complete -F _git_import_dsc -o default git-import-dsc
