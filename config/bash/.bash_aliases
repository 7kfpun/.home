# Common
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias less='less -r'
alias tmp='cd /tmp'

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

# tmux
alias tmux='tmux -2'

# python
alias env='source .env/bin/activate'

# log
alias log_notification_web='ssh 54.164.114.254 sudo tail -f /var/log/liricco/notification/web.log'
alias log_notification_celery='ssh 54.164.114.254 sudo tail -f /var/log/liricco/notification/celery.log'
alias log_production_web='ssh 192.168.1.116 -p 2222 sudo tail -f /var/log/liricco/production/web.log'
alias log_production_tcp='ssh 192.168.1.116 -p 2222 sudo tail -f /var/log/liricco/production/tcp.log'
alias log_localization='ssh localization.valta.com sudo tail -f /var/log/liricco/localization/web.log'
