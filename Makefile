# Makefile for home config

BINDIR=$(CURDIR)/bin
UTILSDIR=$(CURDIR)/utils

.PHONY: help
# target: help - Display callable targets
help:
	@egrep "^# target:" [Mm]akefile

.PHONY: install
# target: install - Install my dot files
install: $(HOME)/.gitconfig $(HOME)/.pip
	@echo "Installed"
	@git submodule init && git submodule update

$(HOME)/.gitconfig:
	ln -s $(CURDIR)/configs/.gitconfig $(HOME)/.

$(HOME)/.pip:
	ln -s $(CURDIR)/configs/.pip $(HOME)/.

.PHONY: uninstall
# target: uninstall - Clean installation
uninstall:
	@echo
	@echo "Clean your HOME directory"
	rm -rf $(HOME)/.gitconfig
	rm -rf $(HOME)/.pip
