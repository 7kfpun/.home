# Common
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias less='less -r'

if [ "$TERM" != "dumb" ]; then
    export LS_OPTIONS='--color=auto --group-directories-first'
    eval `dircolors $HOME/.home/configs/.dir_colors`
fi

alias ls='ls $LS_OPTIONS -Fh' 
alias ll='ls $LS_OPTIONS -Fhl'
alias la='ll $LS_OPTIONS -FhlA'

# others
alias vi='vim'
alias sim='sudo vim'
alias ..="cd .."
alias vi='vim'

# color ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
                 
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
