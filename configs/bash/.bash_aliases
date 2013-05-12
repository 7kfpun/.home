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
