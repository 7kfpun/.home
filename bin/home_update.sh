#!/bin/bash

# Colors
red='\e[0;31m';
cyan='\e[0;36m';
nc='\e[0m';

print () { echo; echo -e ${cyan} ${1}${nc}; }

configure_locales () {
    print 'Configure locales.'
    dpkg-reconfigure locales
    locale-gen en_US.UTF-8
}

update_system () {
    print 'Update system.'
    add-apt-repository ppa:richarvey/nodester
    apt-get update -y
    apt-get upgrade -y
}

install_home_tools () {
    print 'Install home tools.'
    apt-get install -y guake skype xclip openvpn vim-nox

    print "Install Vagrant"
    dpkg -i debs/vagrant_1.2.2_x86_64.deb

    print "Install Dropbox"
    apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
    sh -c 'echo "deb http://linux.dropbox.com/ubuntu/ raring main" > /etc/apt/sources.list.d/dropbox.list'

    print "Install Google-chrome"
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
    sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list'

    print "Install chromium-browser"
    '' | add-apt-repository ppa:a-v-shkop/chromium

    # print "Install Ubuntu Tweak"
    # '' | add-apt-repository ppa:tualatrix/ppa

    apt-get update -y
    apt-get install -y dropbox google-chrome-stable chromium-browser flashplugin-installer
    # apt-get install -y ubuntu-tweak
    cd /etc/apt/sources.list.d && rm -f dropbox.list google.list tualatrix-ppa*.list *chromium*.list

    # cd ~/.vim && git pull
    # cd ~/.home && git pull
}

install_dev_tools () {
    print 'Install dev tools.'
    apt-get install -y build-essential python-dev libxml2-dev git-core git-buildpackage exuberant-ctags python-software-properties subversion python-psycopg2 vim python-setuptools screen cmatrix virtualbox-qt openjdk-7-jdk curl python-pip nfs-kernel-server mongodb-clients
    apt-get install -y ipython
    # apt-get install -y supervisor postgresql nodejs

    print 'Install virtualbox'
    wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | apt-key add -
    apt-get update
    apt-get install virtualbox
}

install_ec2_tools () {
    print 'Install ec2 tools.'
    apt-add-repository ppa:awstools-dev/awstools
    apt-get update
    apt-get install ec2-api-tools ec2-ami-tools iamcli rdscli
}

install_python_modules () {
    print 'Install python modules.'
    easy_install -U setuptools
    for I in pip virtualenv virtualenv-clone ipython ipdb pylint
    do
        (python -c "import $I" 2>/dev/null || {
        echo -e ${red}$I${cyan} not found! Attempting to install... $nc;
        easy_install -U $I
    }) && echo -e ${cyan}$I installed.${nc}
    done
}

install_grep_tool () {
    cd /tmp/
    git clone https://github.com/ggreer/the_silver_searcher
    cd the_silver_searcher
    apt-get install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev
    ./build.sh
    make install
}

install_ruby () {
    apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev

    # install using rvm
    apt-get install -y libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
    curl -L https://get.rvm.io | bash -s stable
    source ~/.rvm/scripts/rvm
    echo "source ~/.rvm/scripts/rvm" >> ~/.bashrc
    rvm install 2.0.0-p451
    rvm use 2.0.0-p451 --default
    ruby -v

    # tell Rubygems not to install the documentation for each package locally
    echo "gem: --no-ri --no-rdoc" > ~/.gemrc
}

install_goagent () {
    sudo apt-get install python-dev python-greenlet python-gevent python-vte python-openssl python-crypto python-appindicator
}

setup () {
    configure_locales
    update_system
    install_home_tools
    #install_dev_tools
    #install_ec2_tools
    #install_python_modules
    install_grep_tool
    #install_ruby
    #install_goagent
}

setup
