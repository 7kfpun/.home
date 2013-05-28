#!/bin/bash

# Colors
red='\e[0;31m';
cyan='\e[0;36m';
nc='\e[0m';

print () { echo; echo -e ${cyan} ${1}${nc}; }

configure_locales () {
    print 'Configure locales.'
    dpkg-reconfigure locales
    sudo locale-gen en_US.UTF-8
}

update_system () {
    print 'Update system.'
    sudo add-apt-repository ppa:richarvey/nodester
    sudo apt-get update -y
    sudo apt-get upgrade -y
}

install_home_tools () {
    print 'Install home tools.'
    sudo apt-get install -y guake skype xclip

    print "Install Vagrant"
    sudo dpkg -i debs/vagrant_1.2.2_x86_64.deb

    print "Install Dropbox"
    sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
    sudo sh -c 'echo "deb http://linux.dropbox.com/ubuntu/ raring main" > /etc/apt/sources.list.d/dropbox.list'

    print "Install Google-chrome"
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
    sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list'

    print "Install Ubuntu Tweak"
    '' | sudo add-apt-repository ppa:tualatrix/ppa

    sudo apt-get update -y
    sudo apt-get install -y dropbox google-chrome-stable ubuntu-tweak
    cd /etc/apt/sources.list.d && rm -f dropbox.list google.list tualatrix-ppa*.list

    # cd ~/.vim && git pull
    # cd ~/.home && git pull
}

install_dev_tools () {
    print 'Install dev tools.'
    sudo apt-get install -y build-essential python-dev libxml2-dev git-core git-buildpackage exuberant-ctags python-software-properties subversion supervisor postgresql python-psycopg2 vim python-setuptools nodejs screen cmatrix virtualbox-qt openjdk-7-jdk curl python-pip nfs-kernel-server mongodb-clients
}

install_python_modules () {
    print 'Install python modules.'
    sudo easy_install -U setuptools
    for I in "pip virtualenv virtualenv-clone ipython ipdb pylint"; do
        (python -c "import $I" 2>/dev/null || {
        echo -e ${red}$I${cyan} not found! Attempting to install... $nc;
        sudo easy_install -U $I
    }) && echo -e ${cyan}$I installed.${nc}
    done
}

setup () {
    configure_locales
    update_system
    install_home_tools
    install_dev_tools
    install_python_modules
}

setup
