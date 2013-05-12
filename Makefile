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

.PHONY: install
# target: install - Install my dot files
install: $(HOME)/.bash_aliases $(HOME)/.gitconfig $(HOME)/.gitignore $(HOME)/.pip
	@echo "Installed"
	@git submodule init && git submodule update

$(HOME)/.bash_aliases:
	ln -s $(CURDIR)/configs/bash/.bash_aliases $(HOME)/.

$(HOME)/.gitconfig:
	cat $(CURDIR)/configs/.gitconfig \
	    | sed "s/__GIT_NAME__/"$(__GIT_NAME__)"/g" \
	    | sed "s/__GIT_EMAIL__/"$(__GIT_EMAIL__)"/g" > $(HOME)/.gitconfig

$(HOME)/.gitignore:
	ln -s $(CURDIR)/configs/.gitignore $(HOME)/.

$(HOME)/.pip:
	ln -s $(CURDIR)/configs/.pip $(HOME)/.

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
	rm -rf $(HOME)/.gitconfig
	rm -rf $(HOME)/.gitignore
	rm -rf $(HOME)/.pip
