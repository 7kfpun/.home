all: update ansible


.PHONY: help
# target: help - Display callable targets
help:
	@egrep "^# target:" [Mm]akefile


.PHONY: update
# target: update - Setup the system with ansible
update:
	@git fetch origin
	@git rebase origin/master
	@git submodule update --init


.PHONY: ansible
# target: ansible - home configuration
ansible:
	@sudo apt-get install ansible -y || echo "Skip ansible installation"
	@ansible-playbook -i inventory ansible/playbook.yml -c local -sK -vv


.PHONY: ansible-install
# target: ansible-install - install ansible
ansible-install:
	@command -v apt-get && sudo apt-get install software-properties-common && sudo apt-add-repository ppa:ansible/ansible &&  sudo apt-get update && sudo apt-get install ansible -y || true
