# Makefile for home config

BINDIR=$(CURDIR)/bin
UTILSDIR=$(CURDIR)/utils

.PHONY: help
# target: help - Display callable targets
help:
	@egrep "^# target:" [Mm]akefile

.PHONY: install
# target: install - Install my dot files
install: autoenv $(HOME)/.gitconfig $(HOME)/.pip
	@echo "Installed"
	@git submodule init && git submodule update

autoenv:
	@echo 'source ~/scripts/.autoenv/activate.sh' >> ~/.bashrc

$(HOME)/.gitconfig:
	ln -s $(CURDIR)/configs/.gitconfig $(HOME)/.

$(HOME)/.gitignore:
        ln -s $(CURDIR)/configs/.gitignore $(HOME)/.

$(HOME)/.pip:
	ln -s $(CURDIR)/configs/.pip $(HOME)/.

.PHONY: uninstall
# target: uninstall - Clean installation
uninstall:
	@echo
	@echo "Clean your HOME directory"
	rm -rf $(HOME)/.gitconfig
	rm -rf $(HOME)/.pip

.PHONY: apt-get
# target: install - apt-get installation
apt-get:
	@echo
	@echo "apt-get installation"
	sudo apt-get update
	sudo apt-get upgrade
	sudo apt-get install -y xclip git python-pip python-virtualenv
