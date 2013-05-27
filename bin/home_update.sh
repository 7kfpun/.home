# Colors
red='\e[0;31m';
cyan='\e[0;36m';
nc='\e[0m';

print () { echo; echo -e  ${cyan} ${1}${nc}; }

print 'Update system.'
sudo add-apt-repository ppa:richarvey/nodester
sudo apt-get update -y

for I in "vim guake skype xclip virtualbox-qt openjdk-7-jdk curl git git-buildpackage python-dev python-pip nfs-kernel-server"; do
    print "Apt-get install -y ${I}"
    sudo apt-get install -y $I
done

for I in "supervisor virtualenv"; do
    print "Upgrade ${I}"
    sudo pip install --upgrade $I
done

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

sudo apt-get update
sudo apt-get install -y dropbox google-chrome-stable ubuntu-tweak
cd /etc/apt/sources.list.d && rm -f dropbox.list google.list tualatrix-ppa*.list

# cd ~/.vim && git pull
# cd ~/.home && git pull