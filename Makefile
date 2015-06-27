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
	@command -v ansible-playbook || make ansible-install
	@ansible-playbook -i inventory ansible/playbook.yml -c local -sK -vv


.PHONY: ansible-install
# target: ansible-install - install ansible
ansible-install:
	@command -v pip && sudo pip install ansible || true
	@command -v apt-get && sudo apt-get install ansible -y || true
	@command -v yum && sudo yum install ansible || true
