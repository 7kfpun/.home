# Makefile for home config

BINDIR=$(CURDIR)/bin
UTILSDIR=$(CURDIR)/utils

ifeq ($(shell uname -n), jp-samsung)
	USERNAME := "Pun Ka Fai"
	EMAIL := "jp@multichannel.net"
endif

ifeq ($(shell uname -n), jp-Lenovo-H530s)
	USERNAME := "Pun Ka Fai"
	EMAIL := "jay.pun@liricco.com"
else    
	USERNAME := "kf"
	EMAIL := "7kfpun@gmail.com"
endif

__BASH_USERNAME__ := $(USERNAME)
__BASH_EMAIL__ := $(EMAIL)
__BASH_DEBFULLNAME__ := $(USERNAME)
__BASH_DEBEMAIL__ := $(EMAIL)
__GIT_NAME__ := $(USERNAME)
__GIT_EMAIL__ := $(EMAIL)


.PHONY: help
# target: help - Display callable targets
help:
	@egrep "^# target:" [Mm]akefile

all:
	@git submodule update --init --recursive
	@git submodule foreach --recursive git pull origin master

.PHONY: ssh-keygen
# target: ssh-keygen - Generating a ssh key
ssh-keygen:
	@mkdir -p ~/.ssh
	@if [ ! -f ~/.ssh/id_rsa.pub ] ; \
	then \
     		ssh-keygen -t rsa -C $(EMAIL) -f ~/.ssh/id_rsa -N "" ; \
	fi;
	@xclip -sel clip < ~/.ssh/id_rsa.pub
	@cat ~/.ssh/id_rsa.pub

.PHONY: gpg-keygen
# target: gpg-keygen - Generating a GPG key
gpg-keygen:
	@gpg --gen-key

.PHONY: install
# target: install - Install my dot files
install: uninstall $(HOME)/.bash_profile $(HOME)/.bashrc $(HOME)/.bash_functions \
    $(HOME)/.bash_aliases $(HOME)/.bash_login $(HOME)/.dircolors \
    $(HOME)/.gitconfig $(HOME)/.gitignore \
    $(HOME)/.pip $(HOME)/.pylintrc
	@echo "Installed"
	@git submodule init && git submodule update

$(HOME)/.bash_profile:
	ln -s $(CURDIR)/configs/bash/.bash_profile $(HOME)/.

$(HOME)/.bashrc:
	cat $(CURDIR)/configs/bash/.bashrc \
	    | sed "s/__BASH_USERNAME__/"$(__BASH_USERNAME__)"/g" \
	    | sed "s/__BASH_EMAIL__/"$(__BASH_EMAIL__)"/g" \
	    | sed "s/__BASH_DEBFULLNAME__/"$(__BASH_DEBFULLNAME__)"/g" \
	    | sed "s/__BASH_DEBEMAIL__/"$(__BASH_DEBEMAIL__)"/g" > $(HOME)/.bashrc

$(HOME)/.bash_functions:
	ln -s $(CURDIR)/configs/bash/.bash_functions $(HOME)/.

$(HOME)/.bash_aliases:
	ln -s $(CURDIR)/configs/bash/.bash_aliases $(HOME)/.

$(HOME)/.bash_login:
	ln -s $(CURDIR)/dotfiles/bash/.bash_login $(HOME)/.

$(HOME)/.dircolors:
	wget -O $(CURDIR)/configs/bash/.dir_colors "https://raw.github.com/trapd00r/LS_COLORS/master/LS_COLORS"

$(HOME)/.gitconfig:
	cat $(CURDIR)/configs/.gitconfig \
	    | sed "s/__GIT_NAME__/"$(__GIT_NAME__)"/g" \
	    | sed "s/__GIT_EMAIL__/"$(__GIT_EMAIL__)"/g" > $(HOME)/.gitconfig

$(HOME)/.gitignore:
	ln -s $(CURDIR)/configs/.gitignore $(HOME)/.

$(HOME)/.pip:
	ln -s $(CURDIR)/configs/.pip $(HOME)/.

$(HOME)/.pylintrc:
	ln -s $(CURDIR)/configs/.pylintrc $(HOME)/.

.PHONY: vim
target: install vim configuration
vim: $(HOME)/.vim
	@echo "Installing vim configuration"
	
$(HOME)/.vim:
	@echo
	@echo " Install VIM files."
	rm -rf $(HOME)/.vim
	rm -rf $(HOME)/.vimrc
	@git clone --recursive https://github.com/7kfpun/.vim.git $(HOME)/.vim
	@cd $(HOME)/.vim
	make all
	make install
										
.PHONY: clean_vim
# target: remove vin configuration
clean_vim:
	@echo
	@echo " Clean VIM files."
	rm -rf $(HOME)/.vim
	rm -rf $(HOME)/.vimrc

.PHONY: uninstall
# target: uninstall - Clean installation
uninstall:
	@echo
	@echo "Clean your HOME directory"
	rm -rf $(HOME)/.bash_aliases
	rm -rf $(HOME)/.bash_login
	rm -rf $(HOME)/.bash_profile
	rm -rf $(HOME)/.bashrc
	rm -rf $(HOME)/.gitconfig
	rm -rf $(HOME)/.gitignore
	rm -rf $(HOME)/.pip
	rm -rf $(HOME)/.pylintrc

.PHONY: ansible
# target: ansible - home configuration
ansible:
	@sudo apt-get install ansible -y || echo "Skip ansible installation"
	@ansible-playbook -i ansible/inventory ansible/playbook.yml -c local -sK -vv
