# Common
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias less='less -r'


# others
alias vi='vim'
alias sim='sudo vim'
alias ..="cd .."
alias vi='vim'

alias ls='ls $LS_OPTIONS -Fh' 
alias ll='ls $LS_OPTIONS -Fhl'
alias la='ll $LS_OPTIONS -FhlA'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


# log
alias log_notification_web='ssh 54.164.114.254 sudo tail -f /var/log/liricco/notification/web.log'
alias log_notification_celery='ssh 54.164.114.254 sudo tail -f /var/log/liricco/notification/celery.log'
