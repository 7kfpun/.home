# Makefile for home config

BINDIR=$(CURDIR)/bin
UTILSDIR=$(CURDIR)/utils

USERNAME := "kf"
EMAIL := "7kfpun@gmail.com"

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
install: uninstall $(HOME)/.bash_profile $(HOME)/.bashrc $(HOME)/.bash_aliases $(HOME)/.dircolors \
    $(HOME)/.gitconfig $(HOME)/.gitignore \
    $(HOME)/.pip $(HOME)/.pylintrc
	@echo "Installed"
	@git submodule init && git submodule update

$(HOME)/.bash_profile:
	ln -s $(CURDIR)/configs/bash/.bash_profile $(HOME)/.

$(HOME)/.bashrc:
	ln -s $(CURDIR)/configs/bash/.bashrc $(HOME)/.

$(HOME)/.bash_aliases:
	ln -s $(CURDIR)/configs/bash/.bash_aliases $(HOME)/.

$(HOME)/.dircolors:
	wget -O $(CURDIR)/configs/bash/.dir_colors "https://raw.github.com/trapd00r/LS_COLORS/master/LS_COLORS"

$(HOME)/.gitconfig:
	$(CURDIR)/configs/.gitconfig \
	    | sed "s/__GIT_NAME__/$(__GIT_NAME__)/g" \
	    | sed "s/__GIT_EMAIL__/$(__GIT_EMAIL__)/g"
	ln -s $(CURDIR)/configs/.gitconfig $(HOME)/.

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
	rm -rf $(HOME)/.bash_profile
	rm -rf $(HOME)/.bashrc
	rm -rf $(HOME)/.gitconfig
	rm -rf $(HOME)/.gitignore
	rm -rf $(HOME)/.pip
	rm -rf $(HOME)/.pylintrc

